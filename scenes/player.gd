extends CharacterBody2D

const SPEED := 300.0
var hp := 100

func _ready():
	Utils.set_friendly_collision(self)
	SignalBus.weapon_equipped.connect(update_weapon)
	SignalBus.choice_made.connect(weapon_from_globals)
	weapon_from_globals()
	# change signal, it should emit a slot/node, and the data
	# connects to the function, which smartly routes node 
	# another function to further parse and modify the scene
	# most weapons can probably be the basic_gun scene, just a few special ones (charging)

	#var starter_weapon_path = "res://scenes/weapon_files/basic_gun.tscn"
	#update_weapon_from_path(starter_weapon_path, 1)


func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	velocity = input_vector * SPEED
	move_and_slide()

func weapon_from_globals():
	var weapon_list = PlayerGlobals.weapon_list
	for i in range(4):
		if weapon_list.size() >= i+1:
			#print(weapon_list[i])
			update_weapon(weapon_list[i], i+1)

func update_weapon(data, slot_number):
	#print('data: ',data, data.scene_path)
	#print(slot_number)
	var target_node = self.get_node( "WeaponSlot" + str(slot_number) )
	Utils.clear_children(target_node)
	
	var scene_path = data.scene_path
	if scene_path!= "":
		var scene = load(scene_path)
		var new_weapon_scene = scene.instantiate()
		# additional scene modifications here
		new_weapon_scene.setup(data)
		target_node.add_child(new_weapon_scene)

func take_damage_player(amount):
	self.hp -= amount
	if self.hp <= 0:
		die()

func die():
	print('game should end because player died')
