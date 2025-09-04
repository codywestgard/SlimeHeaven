extends CharacterBody2D

const SPEED := 300.0

func _ready():
	Utils.set_friendly_collision(self)


	pass

var counter = 0
func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	velocity = input_vector * SPEED
	move_and_slide()
