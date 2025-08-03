@tool
class_name FusionSettingDisplay
extends HBoxContainer

@export var setting: FusionSetting:
	set(x): setting = x; _ready()

var node: Node

func _ready() -> void:
	if node:
		node.queue_free()
	
	if setting is FusionListSetting:
		var list := OptionButton.new()
	
		var id_values : Array[Variant] = []
		var default_id := -1
		
		for i in len(setting.option_names):
			if setting.get_value() == setting.option_values[i]:
				default_id = i
			
			id_values.push_back(setting.option_values[i])
			list.add_item(setting.option_names[i], i)
		
		if default_id == -1:
			push_error("Default value not found in option values.")
		else:
			list.selected = default_id
		
		list.item_selected.connect(
			func(id: int) -> void:
				var value : Variant = id_values[id]
				setting.set_value(value)
		)
		
		_setup_node(list)
	
	elif setting is FusionRangeSetting:
		var slider := HSlider.new()
		
		slider.min_value = setting.minimum
		slider.max_value = setting.maximum
		slider.step = setting.step
		
		slider.value = setting.get_value()
		
		var set_setting := \
			func(changed: bool) -> void: 
				if changed: setting.set_value(slider.value)
		
		if setting.apply_every_step:
			slider.value_changed.connect(set_setting)
		else:
			slider.drag_ended.connect(set_setting)
		
		_setup_node(slider)
	
	elif setting.default_value is bool:
		var toggle := CheckButton.new()
		
		toggle.button_pressed = setting.get_value()
		
		toggle.toggled.connect(
			func(on: bool) -> void:
				setting.set_value(on)
		)
		
		_setup_node(toggle)
	
	elif setting.default_value is String:
		var line := LineEdit.new()
		
		line.text = setting.get_value()
		
		line.text_changed.connect(
			func(text: String) -> void:
				setting.set_value(text)
		)
		
		_setup_node(line)
	
	elif setting.default_value is int:
		var line = LineEdit.new()
		
		line.text = "%d" % setting.default_value
		
		line.text_changed.connect(
			func(text: String) -> void:
				setting.set_value(int(text))
		)
		
		_setup_node(line)
	
	elif setting.default_value is float:
		var line = LineEdit.new()
		
		line.text = "%d" % setting.default_value
		
		line.text_changed.connect(
			func(text: String) -> void:
				setting.set_value(float(text))
		)
		
		_setup_node(line)
	
	elif setting.default_value is Color:
		var picker := ColorPickerButton.new()
		
		picker.color = setting.get_value()
		
		picker.color_changed.connect(
			func(color: Color) -> void:
				setting.set_value(color)
		)
		
		_setup_node(picker)
	
	else:
		push_error(
			"Setting is not of type that can be used",
			self,
			setting.key_name,
			setting.default_value
		)

func _setup_node(option_node: Control) -> void:
	var box := HBoxContainer.new()
	box.set_anchors_preset(PRESET_FULL_RECT)
	box.tooltip_text = setting.description
	node = box
	add_child(box)
	
	var label := Label.new()
	label.text = setting.title
	
	box.add_child(label)
	
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	option_node.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	option_node.tooltip_text = setting.description
	
	box.add_child(option_node)
