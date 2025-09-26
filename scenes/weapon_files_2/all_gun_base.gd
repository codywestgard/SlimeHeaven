extends Area2D
class_name weapon

var id: String
var display_name: String
var scene_path: String
var sprite_path: String
var macroclass: String

var range: int
var damage: int
var fire_cooldown: float
var accuracy: float
var bullet_count: int
var bullet_scene_path: String
var bullet_scene: PackedScene

var ammo_max: int
var reload_time: float

var targeting_alg : Callable
var target_stat : String
var target: Node2D
var json_data: Dictionary

func _ready() -> void:
	pass

func setup(data):
	json_data = data
	load_json_data()
	update_targeting_algorithm("get_highest_stat_target", "hp")
	update_other_nodes()


func load_from_json(path:String):
	json_data = Utils.load_json(path)

func load_json_data():
	id = json_data.get("id", "null_id")
	display_name =  json_data.get("display_name", "")
	scene_path  =  json_data.get("scene_path", "")
	sprite_path =  json_data.get("sprite_path", "")
	bullet_scene_path = json_data.get("bullet_scene", "res://scenes/weapon_files/basic_bullet.tscn")
	$Sprite2D.texture = load(sprite_path)
	bullet_scene = load(bullet_scene_path)
	
	range = json_data.get("range", 500)
	damage = json_data.get("damage", 10)
	fire_cooldown = json_data.get("fire_cooldown", 0.1)
	accuracy = json_data.get("accuracy", 0.8)
	bullet_count= json_data.get("bullet_count", 1)
	
	ammo_max= json_data.get("ammo_max", 30)
	reload_time = json_data.get("reload_time", 2.0)
	


func update_other_nodes():
	$CollisionShape2D.shape.radius = range

func update_targeting_algorithm(alg_name: String, stat: String):
	self.targeting_alg = Callable(self, alg_name)
	self.target_stat = stat


var sum_delta := 0.
func _physics_process(delta: float) -> void:
	sum_delta += delta
	aim()

func aim():
	var enemy_list = get_overlapping_bodies()
	#targeting_alg.call(enemy_list, target_stat)
	get_nearest_target(enemy_list)
	if target:
		look_at(target.global_position)
		if sum_delta > fire_cooldown:
			fire()
	return target

func get_spread_direction(base_direction: Vector2) -> Vector2:
	var max_spread_angle = deg_to_rad(22.5)
	var spread = (1. - accuracy) * max_spread_angle
	var angle_offset = randf_range(-spread, spread)
	return base_direction.rotated(angle_offset).normalized()

func fire():
	for i in range(bullet_count):
		var new_bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(new_bullet)
		var bullet_direction = Vector2.RIGHT.rotated(rotation)
		bullet_direction = get_spread_direction(bullet_direction)
		new_bullet.setup(bullet_direction, damage)
		new_bullet.global_position = global_position
	sum_delta = 0


func get_nearest_target(entities: Array, junk:String=""):
	var nearest_target: Node2D
	var shortest := INF

	for entity in entities:
		if entity.is_in_group("enemies"):
			var dist = self.global_position.distance_squared_to(entity.global_position)
			if dist < shortest:
				shortest = dist
				nearest_target = entity
	self.target = nearest_target

func get_farthest_target(entities: Array, junk:String=""):
	var farthest_target: Node2D
	var farthest := -INF

	for entity in entities:
		var dist = self.global_position.distance_squared_to(entity.global_position)
		if dist > farthest:
			farthest = dist
			farthest_target = entity
	self.target = farthest_target

func get_highest_stat_target(entities, stat: String):
	var best_target_list: Array = []
	var best_metric := -INF
	var metric = 0.

	for entity in entities:
		metric = entity.get(stat)
		if metric:
			if metric > best_metric:
				best_target_list = [entity]
				best_metric = metric
			if metric == best_metric:
				best_target_list.append(entity)
	get_nearest_target(best_target_list)

func get_lowest_stat_target(entities, stat: String): # -> Node2D:
	var best_target_list: Array = []
	var best_metric := INF
	var metric = 0.

	for entity in entities:
		metric = entity.get(stat)
		if metric:
			if metric < best_metric:
				best_target_list = [entity]
				best_metric = metric
			if metric == best_metric:
				best_target_list.append(entity)
	get_nearest_target(best_target_list)


func target_radar(_enemy_list, _junk):
	target = null
	self.rotation += TAU / 4 * get_physics_process_delta_time()
	if self.sum_delta > self.fire_cooldown:
		fire()
