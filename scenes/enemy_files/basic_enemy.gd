extends CharacterBody2D

var player_pos : Vector2

var speed: float = 60.0
var hp: float

func _init(load_hp: float = 200, load_speed: float = 80.):
	self.hp = load_hp
	self.speed = load_speed
	add_to_group("enemies")
	Utils.set_hostile_collision(self)


func setup_enemy(load_hp: float = 200, load_speed: float = 80.):
	self.hp = load_hp
	self.speed = load_speed

func _physics_process(delta):
	player_pos = Utils.get_player_position()
	var direction = (player_pos - global_position).normalized()
	velocity = direction * speed
	#move_and_slide()

func take_damage(amount):
	self.hp -= amount
	if hp <= 0:
		die()

func die():
	queue_free()
