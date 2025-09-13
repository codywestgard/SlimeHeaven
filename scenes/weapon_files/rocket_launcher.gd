extends Area2D

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
	fire_cooldown = 1.2
	bullet_scene = preload("res://scenes/weapon_files/basic_rocket.tscn")
	update_self()
	
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
	var new_bullet = bullet_scene.instantiate()
	add_child(new_bullet)
	new_bullet.setup()
