extends Area2D

var id: String
var display_name: String
var type: String
var damage: int
var fire_cooldown: float
var bullet_scene: PackedScene
var range: int
var pierce_count : int
var knockback: int
var sprite_path: String

var line: Line2D
var raycast : RayCast2D

func _ready() -> void:
	line = $Line2D
	raycast = $RayCast2D
	#setup()


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
	display_name = data.get("name", "")
	type = data.get("type", "")
	sprite_path = data.get("sprite_path", "")

#func setup():
	#range = 600
	#damage = 50
	#fire_cooldown = 0.8
	#bullet_scene = preload("res://scenes/weapon_files/basic_bullet.tscn")
	#update_self()
	#setup_laser_sight()
#
#func setup_laser_sight():
	#line.points = [Vector2(0, 0), Vector2(0, 0)]
	#line.width = 2.0
	#line.default_color = Color.RED
#
	#raycast.set_collision_mask_value(Utils.CollisionLayers.PLAYER, false)
	#raycast.set_collision_mask_value(Utils.CollisionLayers.ENEMIES, true)
	#
#func update_self():
	#$CollisionShape2D.shape.radius = range
#
#var sum_delta := 0.
#func _physics_process(delta: float) -> void:
	#sum_delta += delta
	#var target = aim()
	#if target:
		#look_at(target.global_position)
		#if false:
			#adjust_laser_sight()
		#if sum_delta > fire_cooldown:
			#fire(target)
			#sum_delta = 0
#
#func aim():
	#var enemy_list = get_overlapping_bodies()
	#var target = Utils.get_nearest_target(self.position, enemy_list, range)
	#return target
#
#func fire(target):
	#var new_bullet = bullet_scene.instantiate()
	#add_child(new_bullet)
	#new_bullet.setup()
#
#
#func adjust_laser_sight():
	#raycast.target_position = Vector2(1000,0)
	#var laser_distance := 1000
	#if raycast.is_colliding():
		#laser_distance = raycast.global_position.distance_to(raycast.get_collision_point())
	#line.points[-1] = Vector2(laser_distance, 0)
