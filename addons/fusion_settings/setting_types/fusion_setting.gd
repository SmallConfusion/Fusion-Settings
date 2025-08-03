@tool
@icon("../icons/FusionSetting.svg")
class_name FusionSetting
extends Resource

const SECTION_DEFAULT = "fusion_settings"

@export var title := "Untitled setting"
@export var default_value : Variant

# The script to run when the setting is applied. 
@export var apply_script: GDScript

## The description of this setting.
@export var description := ""

## The key that this should be saved as. This can be left empty to use the
## title.
@export var key := ""

## The section of the config file to save this setting in. Leaving this empty
## is allowed.
@export var section := ""

func get_value() -> Variant:
	return FusionSettings.config.get_value(
		section if section != "" else SECTION_DEFAULT,
		key if key != "" else title,
		default_value
	)

func set_value(value: Variant) -> void:
	FusionSettings.config.set_value(
		section if section != "" else SECTION_DEFAULT,
		key if key != "" else title,
		value
	)
	FusionSettings.save()
	apply()

func apply() -> void:
	if apply_script == null: return
	if not apply_script.has_method("apply"):
		push_error("Invalid script on setting. Function apply(value) not found.")
	apply_script.apply(get_value())
