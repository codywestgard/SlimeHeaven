extends Control

@export var button_scene: PackedScene
const ROW_HEIGHT := 100
const BUTTONS_PER_ROW := 3

func _ready():
	button_scene = preload("res://scenes/UI_files/map_node.tscn")
	var total_buttons := 6
	for i in range(total_buttons):
		var btn := button_scene.instantiate()
		
		var row := i / BUTTONS_PER_ROW
		var col := i % BUTTONS_PER_ROW
		
		var x := col * 200# + randf() * 100
		var y := (row + 1) * ROW_HEIGHT
		
		btn.position = Vector2(x, y)
		btn.z_index = i  # force increasing z-index per button		
		btn.setup(i)
		btn.node_selected.connect(_on_node_selected)
		add_child(btn)


func _on_node_selected(id: int):
	print("Node selected:", id)
	# Handle map logic here
