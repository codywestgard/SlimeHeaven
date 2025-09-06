extends Area2D

var range: int
var damage: int
var fire_cooldown: float
var bullet_scene: PackedScene
var line: Line2D
var raycast : RayCast2D

var stored_charge:= 0.
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


func setup_laser():
	line.points = [Vector2(0, 0), Vector2(0, 0)]
	line.width = 2.0
	line.default_color = Color.RED

	raycast.set_collision_mask_value(Utils.CollisionLayers.PLAYER, false)
	raycast.set_collision_mask_value(Utils.CollisionLayers.ENEMIES, true)
	
func update_self():
	$CollisionShape2D.shape.radius = range

var sum_delta := 99.
func _physics_process(delta: float) -> void:
	sum_delta += delta
	var target = aim()
	if target:
		look_at(target.global_position)
		if sum_delta > fire_cooldown:
			fire(target)
	else:
		sum_delta = sum_delta

func charge(delta):
	pass


func aim():
	var enemy_list = get_overlapping_bodies()
	var target = TargetingAlgorithms.get_nearest_target(self.position, enemy_list)
	return target

func fire(target):
	print('fire heavy laser')
	queue_redraw()
	sum_delta = 0

func _draw():
	draw_line(Vector2(0,0), Vector2(100,0), Color.RED, 10)
