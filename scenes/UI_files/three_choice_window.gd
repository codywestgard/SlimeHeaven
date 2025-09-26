extends Control

var choices
func _ready():
	pass


func update_choices(_choices:Array):
	choices = _choices
	assert(choices.size() == 3)
	load_choice(%Choice1, choices[0])
	load_choice(%Choice2, choices[1])
	load_choice(%Choice3, choices[2])

func _on_hover():
	# display more information when hovering over
	pass

func load_choice(target_node, data):
	# get sprite
	var sprite_path = data.get("sprite_path", "res://assets/weapons/laser.png")
	target_node.get_node("TextureRect").texture = load(sprite_path)
	## get name
	target_node.get_node("Label").text = data.get("display_name", "Display name not found")
	# get stats
	pass

func on_choice_chosen():
	SignalBus.choice_made.emit()


func _on_choice_1_pressed() -> void:
	PlayerGlobals.add_weapon(choices[0])
	on_choice_chosen()

func _on_choice_2_pressed() -> void:
	PlayerGlobals.add_weapon(choices[1])
	on_choice_chosen()

func _on_choice_3_pressed() -> void:
	PlayerGlobals.add_weapon(choices[2])
	on_choice_chosen()
