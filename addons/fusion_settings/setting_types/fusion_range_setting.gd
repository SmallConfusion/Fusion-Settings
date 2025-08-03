class_name FusionRangeSetting
extends FusionSetting

@export var minimum := 0.0
@export var maximum := 1.0
@export var step := 0.01

# When enabled, the setting will be applied as the slider changes, resulting in
# a smooth change. This behaves badly in cases where the slider changes the gui
# scale.
@export var apply_every_step := false
