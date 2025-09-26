extends Area2D

var range: int
var damage: int
var fire_cooldown: float
var bullet_scene: PackedScene
var line: Line2D
var raycast : RayCast2D
var full_ammo: int
var ammo: int
var reload_duration : float

var targeting_alg : Callable
var target: Node2D
func _ready() -> void:
	line = $Line2D
	raycast = $RayCast2D
	setup()

func setup():
	range = 600
	damage = 50
	fire_cooldown = 0.5
	full_ammo = 10
	ammo = full_ammo
	reload_duration = 5.0
	bullet_scene = preload("res://scenes/weapon_files/basic_bullet.tscn")
	#targeting_alg = TargetingAlgorithms()
	update_self()
	setup_laser_sight()

func setup_laser_sight():
	line.points = [Vector2(0, 0), Vector2(0, 0)]
	line.width = 2.0
	line.default_color = Color.RED

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
		if false:
			adjust_laser_sight()
		if sum_delta > fire_cooldown and ammo > 0:
			fire()
			sum_delta = 0

func update_targeting_algorithm():
	pass

func aim():
	var enemy_list = get_overlapping_bodies()
	#var target = TargetingAlgorithms.get_nearest_target(self.global_position, enemy_list)
	var target = TargetingAlgorithms.get_lowest_stat_target(enemy_list, "hp")
	if target:
		look_at(target.global_position)
	return target

func fire():
	var new_bullet = bullet_scene.instantiate()
	add_child(new_bullet)
	new_bullet.setup()
	ammo -= 1
	if ammo <= 0:
		reload()

func reload():
	print('Reloading weapon ', ammo)
	var value = $TextureProgressBar.value
	var t := 0.0
	while t < reload_duration:
		await get_tree().process_frame
		t += get_process_delta_time()
		value = t / reload_duration
	value = 0.0
	ammo = full_ammo
	print('Reload complete ', ammo)

func adjust_laser_sight():
	raycast.target_position = Vector2(1000,0)
	var laser_distance := 1000
	if raycast.is_colliding():
		laser_distance = raycast.global_position.distance_to(raycast.get_collision_point())
	line.points[-1] = Vector2(laser_distance, 0)
