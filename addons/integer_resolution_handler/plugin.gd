tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("IntegerResolutionHandler", "res://addons/integer_resolution_handler/integer_resolution_handler.gd")

	ProjectSettings.set_setting(
		"display/window/integer_resolution_handler/base_width",
		max(floor(ProjectSettings.get_setting("display/window/size/width") / 3), 8))
	ProjectSettings.add_property_info({
		"name": "display/window/integer_resolution_handler/base_width",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,1024,1,or_greater"
	})
	ProjectSettings.set_initial_value(
		"display/window/integer_resolution_handler/base_width", 320)

	ProjectSettings.set_setting(
		"display/window/integer_resolution_handler/base_height",
		max(floor(ProjectSettings.get_setting("display/window/size/height") / 3), 8))
	ProjectSettings.add_property_info({
		"name": "display/window/integer_resolution_handler/base_height",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,600,1,or_greater"
	})
	ProjectSettings.set_initial_value(
		"display/window/integer_resolution_handler/base_height", 240)


func _exit_tree():
	remove_autoload_singleton("IntegerResolutionHandler")
	ProjectSettings.clear("display/window/integer_resolution_handler/base_width")
	ProjectSettings.clear("display/window/integer_resolution_handler/base_height")
