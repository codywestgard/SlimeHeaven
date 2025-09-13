extends Control

var id: String
var display_name: String
var type: String
var sprite_path: String
var scene_path: String

@onready var icon = $Icon

func _ready():
	if self.get_meta('type') == null:
		set_my_type("empty")

func set_my_type(new_type='empty'):
	print('type is being set to:   ', new_type)
	self.set_meta('type', new_type)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print('clicked on : ', self, self.get_meta('type'))
		SignalBus.item_selected.emit(self)

func load_json(path):
	var data = Utils.load_json(path)
	
	id = data.get("id", "")
	display_name = data.get("display_name", "")
	type = data.get("type", "empty")
	set_my_type(type)
	sprite_path = data.get("sprite_path", "")
	scene_path = data.get("scene_path", "")

	#$Label.text = self.display_name
	$Icon.texture = load(self.sprite_path)

func _get_drag_data(position):
	if self.type != "empty":
		var drag_preview = icon.duplicate()
		set_drag_preview(drag_preview)
		return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var source_type = data.get_meta('type')
	var source_slot = data.get_parent().get_meta('type')
	var target_type = self.get_meta('type')
	var target_slot = self.get_parent().get_meta('type')

	if not target_slot:
		print('error type of target slot not set', target_slot)
		return false
	if target_slot.has(source_type) and source_slot.has(target_type):
		return true
	print('cannot place', source_type, source_slot, target_type, target_slot)
	return false

func _drop_data(position: Vector2, data):
	var source_slot = data.get_parent()
	var target_slot := self.get_parent()
	var source_item = data
	var target_item = self
		
	# Remove both items from their slots
	source_slot.remove_child(source_item)

	target_slot.remove_child(target_item)

	# Swap them
	source_item.position = Vector2.ZERO
	target_slot.add_child(source_item)

	target_item.position = Vector2.ZERO
	source_slot.add_child(target_item)
	
	var signal_to_send = target_slot.get_meta('equip_signal')
	if signal_to_send:
		var weapon_slot_number = target_slot.get_parent().get_parent().get_parent().get_meta("weapon_slot_number")
		signal_to_send.emit(source_item, weapon_slot_number)
	signal_to_send = source_slot.get_meta('equip_signal')
	if signal_to_send:
		var weapon_slot_number = target_slot.get_parent().get_parent().get_parent().get_meta("weapon_slot_number")
		signal_to_send.emit(target_item, weapon_slot_number)

func swap_items():
	pass

func place_items():
	pass
