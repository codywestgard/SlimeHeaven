extends Node

enum TargetingStrategy {
	NEAREST,
	FARTHEST,
	HIGHEST_HP,
	LOWEST_HP,
}

func get_nearest_target(start_pos: Vector2, entities: Array) -> Node2D:
	var nearest: Node2D
	var shortest := INF

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

func get_highest_stat_target(entities, stat: String):
	var best_target : Node2D
	var best_metric := -INF
	var metric = 0.

	for entity in entities:
		metric = entity.get(stat)
		if metric:
			if metric > best_metric:
				best_target = entity
				best_metric = metric
	return best_target

func get_lowest_stat_target(entities, stat: String): # -> Node2D:
	var best_target : Node2D
	var best_metric := INF
	var metric = 0.

	for entity in entities:
		metric = entity.get(stat)
		if metric:
			if metric < best_metric:
				best_target = entity
				best_metric = metric
	return best_target

func get_highest_hp_target(entities: Array) -> Node2D:
	return get_highest_stat_target(entities, "hp")
	
func get_lowest_hp_target(entities: Array) -> Node2D:
	return get_lowest_stat_target(entities, "hp")

func target_radar():
	pass
