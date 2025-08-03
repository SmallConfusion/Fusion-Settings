extends Node

var config := ConfigFile.new()

func _ready() -> void:
	print(ProjectSettings.get_setting_with_override("fusion_settings/autoload_path"))
	config.load(ProjectSettings.get_setting_with_override("fusion_settings/config_save_path"))
	
	var load_paths: Array = ProjectSettings.get_setting_with_override("fusion_settings/autoload_path")
	
	for path in load_paths:
		_apply_settings_dir(path)

func _apply_settings_dir(path: String) -> void:
	var files := DirAccess.get_files_at(path)
	
	for file in files:
		if file.ends_with(".uid"): continue
		
		file = file.replace(".remap", "")
		
		var setting := load(path.path_join(file))
		
		if setting is FusionSetting:
			setting.apply()
	
	var directories := DirAccess.get_directories_at(path)
	
	for dir in directories:
		_apply_settings_dir(path.path_join(dir))

func save() -> void:
	config.save(ProjectSettings.get_setting_with_override("fusion_settings/config_save_path"))
