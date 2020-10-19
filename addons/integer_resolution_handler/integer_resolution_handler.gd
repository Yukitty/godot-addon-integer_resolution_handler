extends Node
# IntegerResolutionHandler autoload.
# Watches for window size changes and handles
# game screen scaling with exact integer
# multiples of a base resolution in mind.

const SETTING_BASE_WIDTH = "display/window/integer_resolution_handler/base_width"
const SETTING_BASE_HEIGHT = "display/window/integer_resolution_handler/base_height"

var base_resolution := Vector2(320, 240)
var stretch_mode: int
var stretch_aspect: int
onready var stretch_shrink: float = ProjectSettings.get_setting("display/window/stretch/shrink")

onready var _root: Viewport = get_node("/root")


func _ready():
	# Parse project settings
	if ProjectSettings.has_setting(SETTING_BASE_WIDTH):
		base_resolution.x = ProjectSettings.get_setting(SETTING_BASE_WIDTH)
	if ProjectSettings.has_setting(SETTING_BASE_HEIGHT):
		base_resolution.y = ProjectSettings.get_setting(SETTING_BASE_HEIGHT)

	match ProjectSettings.get_setting("display/window/stretch/mode"):
		"2d":
			stretch_mode = SceneTree.STRETCH_MODE_2D
		"viewport":
			stretch_mode = SceneTree.STRETCH_MODE_VIEWPORT
		_:
			stretch_mode = SceneTree.STRETCH_MODE_DISABLED

	match ProjectSettings.get_setting("display/window/stretch/aspect"):
		"keep":
			stretch_aspect = SceneTree.STRETCH_ASPECT_KEEP
		"keep_height":
			stretch_aspect = SceneTree.STRETCH_ASPECT_KEEP_HEIGHT
		"keep_width":
			stretch_aspect = SceneTree.STRETCH_ASPECT_KEEP_WIDTH
		"expand":
			stretch_aspect = SceneTree.STRETCH_ASPECT_EXPAND
		_:
			stretch_aspect = SceneTree.STRETCH_ASPECT_IGNORE

	# Enforce minimum resolution.
	OS.min_window_size = base_resolution

	# Remove default stretch behavior.
	var tree: SceneTree = get_tree()
	tree.set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_IGNORE, base_resolution, 1)

	# Start tracking resolution changes and scaling the screen.
	update_resolution()
	# warning-ignore:return_value_discarded
	tree.connect("screen_resized", self, "update_resolution")


func update_resolution():
	var video_mode: Vector2 = OS.window_size
	if OS.window_fullscreen:
		video_mode = OS.get_screen_size()

	var scale := int(max(floor(min(video_mode.x / base_resolution.x, video_mode.y / base_resolution.y)), 1))
	var screen_size: Vector2 = base_resolution
	var viewport_size: Vector2 = screen_size * scale
	var overscan: Vector2 = ((video_mode - viewport_size) / scale).floor()
	var margin: Vector2
	var margin2: Vector2

	match stretch_aspect:
		SceneTree.STRETCH_ASPECT_KEEP_WIDTH:
			screen_size.y += overscan.y
		SceneTree.STRETCH_ASPECT_KEEP_HEIGHT:
			screen_size.x += overscan.x
		SceneTree.STRETCH_ASPECT_EXPAND, SceneTree.STRETCH_ASPECT_IGNORE:
			screen_size += overscan
	viewport_size = screen_size * scale
	margin = (video_mode - viewport_size) / 2
	margin2 = margin.ceil()
	margin = margin.floor()

	match stretch_mode:
		SceneTree.STRETCH_MODE_VIEWPORT:
			_root.set_size((screen_size / stretch_shrink).floor())
			_root.set_attach_to_screen_rect(Rect2(margin, viewport_size))
			_root.set_size_override_stretch(false)
			_root.set_size_override(false)
		SceneTree.STRETCH_MODE_2D, _:
			_root.set_size((viewport_size / stretch_shrink).floor())
			_root.set_attach_to_screen_rect(Rect2(margin, viewport_size))
			_root.set_size_override_stretch(true)
			_root.set_size_override(true, (screen_size / stretch_shrink).floor())

	if margin.x < 0:
		margin.x = 0
	if margin.y < 0:
		margin.y = 0
	if margin2.x < 0:
		margin2.x = 0
	if margin2.y < 0:
		margin2.y = 0
	VisualServer.black_bars_set_margins(int(margin.x), int(margin.y), int(margin2.x), int(margin2.y))
