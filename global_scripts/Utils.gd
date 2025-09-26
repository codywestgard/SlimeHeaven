extends Node

var player_node: Node2D
var inventory_node: Control
var enemy_node: Node2D


enum CollisionLayers {
	PLAYER,
	ENEMIES,	
}

func get_player_node():
	return player_node

func get_player_position():
	return player_node.global_position

func get_inventory_top_node():
	return inventory_node

func clear_children(target_node: Node):
	if target_node:
		for child in target_node.get_children():
			child.queue_free()

func set_friendly_collision(entity):
	## Player does this, will collide with enemies not player stuff
	entity.set_collision_layer_value(Utils.CollisionLayers.PLAYER, true)
	entity.set_collision_layer_value(Utils.CollisionLayers.ENEMIES, false)
	entity.set_collision_mask_value(Utils.CollisionLayers.PLAYER, false)
	entity.set_collision_mask_value(Utils.CollisionLayers.ENEMIES, true)

func set_hostile_collision(entity):
	## will collide with player but not enemies, used for most hostile entities
	entity.set_collision_layer_value(Utils.CollisionLayers.PLAYER, false)
	entity.set_collision_layer_value(Utils.CollisionLayers.ENEMIES, true)
	entity.set_collision_mask_value(Utils.CollisionLayers.PLAYER, true)
	entity.set_collision_mask_value(Utils.CollisionLayers.ENEMIES, false)

func load_json(path:String):
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
	return data
