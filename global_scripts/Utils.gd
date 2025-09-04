extends Node

var player_node: Node2D
var enemy_node: Node2D

enum TargetingStrategy {
	NEAREST,
	FARTHEST,
	HIGHEST_HP,
	LOWEST_HP,
}

enum CollisionLayers {
	PLAYER,
	ENEMIES,	
}

func get_player_position():
	return player_node.global_position

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



func get_nearest_target(start_pos: Vector2, entities: Array, max_dist: float = 300.) -> Node2D:
	var nearest: Node2D
	var shortest := INF #max_dist * max_dist

	for entity in entities:
		if entity.is_in_group("enemies"):
			var dist = start_pos.distance_squared_to(entity.global_position)
			if dist < shortest:
				shortest = dist
				nearest = entity
	return nearest

func get_farthest_target(start_pos: Vector2, entities: Array, max_dist: float = 500) -> Node2D:
	#TODO optional add a minimum distance too
	var nearest: Node2D
	var max_dist_sq := max_dist * max_dist
	var farthest := -INF

	for entity in entities:
		var dist = start_pos.distance_squared_to(entity.global_position)
		if dist > farthest and dist < max_dist_sq:
			farthest = dist
			nearest = entity
	return nearest

func get_highest_hp_target(start_pos: Vector2, entities: Array, max_dist: float = 500) -> Node2D:
	var best_target : Node2D
	var best_metric := -INF
	
	for entity in entities:
		var metric = entity.hp
		if metric > best_metric:
			best_target = entity
			best_metric = metric
	return best_target
	
func get_lowest_hp_target(start_pos: Vector2, entities: Array, max_dist: float = 500) -> Node2D:
	var best_target : Node2D
	var best_metric := INF
	
	for entity in entities:
		var metric = entity.hp
		if metric < best_metric:
			best_target = entity
			best_metric = metric
	return best_target
