extends Node2D

var direction: Vector2
var speed: float
var pierce_count:= 0
var bounce_count:= 0
var max_pierce: int
var max_bounce: int

var max_travel := 10000
var distance_traveled:= 0


var raycast = RayCast2D 
var collision_point : Vector2
var velocity
var damage := 10

func setup():
	distance_traveled = 0
	direction = Vector2(1, 0)
	speed = 500

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	distance_traveled += speed * delta
	if distance_traveled > max_travel:
		die()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		_on_impact(body)

func _on_impact(body):
	if body.has_method("take_damage"):
		body.take_damage(self.damage)
	die()

func die():
	queue_free()
