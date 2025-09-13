extends Area2D

var range: int
var damage: int
var fire_cooldown: float
var bullet_scene: PackedScene
var line: Line2D
var raycast : RayCast2D

var charging := true
var charging_bullet = null

func _ready() -> void:
	line = $Line2D
	raycast = $RayCast2D
	setup()

func setup():
	range = 500
	damage = 50
	fire_cooldown = 1.0
	bullet_scene = preload("res://scenes/weapon_files/ball_laser_bullet.tscn")
	update_self()

func update_self():
	$CollisionShape2D.shape.radius = range

var sum_delta := 99.
func _physics_process(delta: float) -> void:
	sum_delta += delta
	var target = aim()
	if target:
		look_at(target.global_position)
		if sum_delta > fire_cooldown:
			charge(delta)
			fire(target)
	else:
		charge(delta)
	queue_redraw()


func charge(delta):
	if charging_bullet == null:
		charging_bullet = bullet_scene.instantiate()
		add_child(charging_bullet)
		charging_bullet.setup()
		charging_bullet.position = Vector2(30,0)
	charging_bullet.charge(delta)

func aim():
	var enemy_list = get_overlapping_bodies()
	var target = TargetingAlgorithms.get_nearest_target(self.global_position, enemy_list)#, range)
	return target

func fire(target):
	if charging_bullet:
		charging_bullet.speed = 500
		#charging_bullet.position += Vector2(100,9)
		charging_bullet = null
		
		sum_delta = 0

func _draw():
	draw_circle(Vector2.ZERO, range, Color(1, 0, 0, 0.1))  # Red semi-transparent
