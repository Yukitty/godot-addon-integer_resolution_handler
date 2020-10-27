tool
extends EditorPlugin


const SETTING_BASE_WIDTH := "display/window/integer_resolution_handler/base_width"
const SETTING_BASE_HEIGHT := "display/window/integer_resolution_handler/base_height"
const DEFAULT_BASE_WIDTH: int = 320
const DEFAULT_BASE_HEIGHT: int = 240


func _enter_tree():
	add_autoload_singleton("IntegerResolutionHandler", "res://addons/integer_resolution_handler/integer_resolution_handler.gd")

	if not ProjectSettings.has_setting(SETTING_BASE_WIDTH):
		ProjectSettings.set_setting(SETTING_BASE_WIDTH, DEFAULT_BASE_WIDTH)
	ProjectSettings.set_initial_value(SETTING_BASE_WIDTH, DEFAULT_BASE_WIDTH)
	ProjectSettings.add_property_info({
		"name": SETTING_BASE_WIDTH,
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,1024,1,or_greater"
	})

	if not ProjectSettings.has_setting(SETTING_BASE_HEIGHT):
		ProjectSettings.set_setting(SETTING_BASE_HEIGHT, DEFAULT_BASE_HEIGHT)
	ProjectSettings.set_initial_value(SETTING_BASE_HEIGHT, DEFAULT_BASE_HEIGHT)
	ProjectSettings.add_property_info({
		"name": SETTING_BASE_HEIGHT,
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,600,1,or_greater"
	})

	var order: int = ProjectSettings.get_order("display/window/size/width") - 2
	ProjectSettings.set_order(SETTING_BASE_WIDTH, order)
	ProjectSettings.set_order(SETTING_BASE_HEIGHT, order + 1)
	ProjectSettings.save()


func disable_plugin():
	remove_autoload_singleton("IntegerResolutionHandler")
	ProjectSettings.clear("display/window/integer_resolution_handler/base_width")
	ProjectSettings.clear("display/window/integer_resolution_handler/base_height")
	ProjectSettings.save()

