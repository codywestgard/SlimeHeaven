extends Node2D

var direction: Vector2
var speed: float
var pierce_count:= 0
var bounce_count:= 0
var max_pierce: int = 10
var max_bounce: int

var max_travel := 10000
var distance_traveled:= 0.


var raycast = RayCast2D 
var collision_point : Vector2
var velocity
var stored_charge
var max_charge := 3

func setup():
	distance_traveled = 0
	direction = Vector2(1, 0)
	speed = 0
	stored_charge = 0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	distance_traveled += speed * delta
	if distance_traveled > max_travel:
		die()

func charge(delta):
	if speed == 0:
		stored_charge += delta
		stored_charge = clamp(stored_charge, 0.5, max_charge)
		$Sprite2D.scale = Vector2(stored_charge, stored_charge)
		$CollisionShape2D.scale = Vector2(stored_charge, stored_charge)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		_on_impact()
		pierce_and_shrink()

func pierce_and_shrink():
	pierce_count += 1
	if pierce_count > max_pierce:
		die()
	stored_charge = stored_charge * 0.8
	if stored_charge < 0.5:
		die()
	$Sprite2D.scale = Vector2(stored_charge, stored_charge)
	$CollisionShape2D.scale = Vector2(stored_charge, stored_charge)


func _on_impact():
	pass

func die():
	queue_free()
