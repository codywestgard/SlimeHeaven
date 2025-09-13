extends Node2D


#var inventory_scene: PackedScene = preload("res://Inventory.tscn")
#var inventory_instance: Node = null
#var inventory_open := false
##var inventory_scene: PackedScene = preload('res://scenes/inventory.tscn')


@onready var inventory_scene := preload("res://scenes/inventory.tscn")
var inventory_instance: Node = null
var inventory_open := false

func _ready():
	Utils.player_node = $Player



func spawn_mob():
	var new_enemy= preload("res://scenes/enemy_files/basic_enemy.tscn").instantiate()
	#this is how you get something to randomlly spawn on a path
	
	%PathFollow2D.progress_ratio=randf()
	new_enemy.global_position=%PathFollow2D.global_position
	add_child(new_enemy)

func _on_timer_timeout() -> void:
	spawn_mob()


func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		open_inventory()
	if event.is_action_pressed("close_inventory"):
		close_inventory()
		



func open_inventory():
	# Pause only gameplay nodes
	for node in get_tree().get_nodes_in_group("pausable"):
		node.process_mode = Node.PROCESS_MODE_DISABLED

	# Add inventory overlay
	inventory_instance = inventory_scene.instantiate()
	get_tree().root.add_child(inventory_instance)  # Add to root so it’s not paused

func close_inventory():
	# Remove inventory
	if inventory_instance:
		inventory_instance.queue_free()
		inventory_instance = null

	# Resume gameplay nodes
	for node in get_tree().get_nodes_in_group("pausable"):
		node.process_mode = Node.PROCESS_MODE_INHERIT
