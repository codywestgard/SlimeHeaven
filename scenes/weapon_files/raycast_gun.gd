extends Area2D

# Most basic gun
var range: int
var damage: int
var fire_cooldown: float
var bullet_scene: PackedScene
var line: Line2D
var raycast : RayCast2D

func _ready() -> void:
	line = $Line2D
	raycast = $RayCast2D
	setup()

func setup():
	range = 1000
	damage = 50
	fire_cooldown = 0.7
	bullet_scene = preload("res://scenes/weapon_files/basic_bullet.tscn")
	update_self()
	setup_laser_sight()

func setup_laser_sight():
	line.points = [Vector2(0, 0), Vector2(0, 0)]
	line.width = 2.0
	line.default_color = Color.DIM_GRAY

	raycast.set_collision_mask_value(Utils.CollisionLayers.PLAYER, false)
	raycast.set_collision_mask_value(Utils.CollisionLayers.ENEMIES, true)
	
func update_self():
	$CollisionShape2D.shape.radius = range

var sum_delta := 0.
func _physics_process(delta: float) -> void:
	sum_delta += delta
	var target = aim()
	if target:
		look_at(target.global_position)
		if sum_delta > fire_cooldown:
			fire(target)
			sum_delta = 0

func aim():
	var enemy_list = get_overlapping_bodies()
	var target = Utils.get_nearest_target(self.position, enemy_list, range)
	return target

func fire(target):
	# fire, piercing shot, with visual
	raycast.target_position = Vector2(1000,0)
	var laser_distance := 1000
	if raycast.is_colliding():
		laser_distance = raycast.global_position.distance_to(raycast.get_collision_point())
	line.points[-1] = Vector2(laser_distance, 0)
	
