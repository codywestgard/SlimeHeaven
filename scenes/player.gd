extends CharacterBody2D

const SPEED := 300.0

func _ready():
	Utils.set_friendly_collision(self)
	SignalBus.weapon_equipped.connect(update_weapon)
	
	# change signal, it should emit a slot/node, and the data
	# connects to the function, which smartly routes node 
	# another function to further parse and modify the scene
	# most weapons can probably be the basic_gun scene, just a few special ones (charging)

	pass

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	velocity = input_vector * SPEED
	move_and_slide()


func update_weapon(data, slot_number):
	print('slot number read here', slot_number)
	var target_node = self.get_node( "WeaponSlot" + str(slot_number) )
	Utils.clear_children(target_node)
	
	var scene_path = data.scene_path
	if scene_path!= "":
		var scene = load(scene_path)
		var new_weapon_scene = scene.instantiate()
		# additional scene modifications here
		target_node.add_child(new_weapon_scene)
