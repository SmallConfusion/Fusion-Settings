@tool
extends EditorPlugin

var settings := [
	{
		"name": "fusion_settings/config_save_path",
		"default": "user://settings.cfg",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_FILE_PATH,
	},
	{
		"name": "fusion_settings/autoload_path",
		"default": ["res://settings/"],
		"type": TYPE_ARRAY,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"hint_string": "%d:%d" % [TYPE_STRING, PROPERTY_HINT_DIR]
	},
]

func _enable_plugin() -> void:
	for setting in settings:
		if not ProjectSettings.has_setting(setting.name):
			ProjectSettings.set_setting(setting.name, setting.default)
			#ProjectSettings.set_initial_value(setting.name, setting.default)
			ProjectSettings.add_property_info(setting)
	ProjectSettings.save()
	
	add_autoload_singleton("FusionSettings", "fusion_settings.gd")

func _disable_plugin() -> void:
	for setting in settings:
		ProjectSettings.set_setting(setting.name, null)
	ProjectSettings.save()
	
	remove_autoload_singleton("FusionSettings")
