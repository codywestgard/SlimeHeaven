extends Control

var id: String
var display_name: String
var type: String
var sprite_path: String

@onready var icon = $Icon
func load_json(path):
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open JSON file at: " + path)
		return

	var json_text := file.get_as_text()
	file.close()

	var json := JSON.new()
	var error := json.parse(json_text)

	if error != OK:
		push_error("JSON parse error: " + json.get_error_message() + " at line " + str(json.get_error_line()))
		return

	var data = json.data
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Invalid JSON structure: Expected Dictionary at root")
		return

	id = data.get("id", "")
	display_name = data.get("display_name", "")
	type = data.get("type", "null")
	sprite_path = data.get("sprite_path", "")

	$Label.text = self.display_name
	$Icon.texture = load(self.sprite_path)


func _get_drag_data(position):
	if self.type != "empty":
		var drag_preview = icon.duplicate()
		set_drag_preview(drag_preview)
		return self 

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var source_type = data.type
	var source_slot = data.get_parent().get_meta('type')
	var target_type = data.type
	var target_slot = self.get_parent().get_meta('type')
	#print(source_type, "   ",  target_type)
	
	if target_slot.has(source_type) and source_slot.has(target_type):
		# make green
		return true
	# make red
	return false


func _drop_data(position: Vector2, data):
	var source_slot = data.get_parent()
	var target_slot := self.get_parent()

	# Get current items
	var source_item = data
	var target_item = self
		
	# Remove both items from their slots
	if source_item:
		source_slot.remove_child(source_item)
	if target_item:
		target_slot.remove_child(target_item)

	# Swap them
	if source_item:
		source_item.position = Vector2.ZERO
		target_slot.add_child(source_item)
	if target_item:
		target_item.position = Vector2.ZERO
		source_slot.add_child(target_item)
