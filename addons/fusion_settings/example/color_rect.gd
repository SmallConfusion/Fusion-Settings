extends ColorRect

const BACKGROUND_COLOR = preload("uid://bc2bn23i8stp5")

func _process(delta: float) -> void:
	modulate = BACKGROUND_COLOR.get_value()
