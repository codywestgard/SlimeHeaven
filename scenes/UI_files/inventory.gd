extends Control

var inventory_slot_scene = preload("res://scenes/UI_files/inventory_slot.tscn")
@onready var inventory_grid = $InventoryUI/TopVbox/HBoxContainer/VBoxContainer/Inventory
@onready var inventory_grid2 = $InventoryUI/TopVbox/HBoxContainer/PlayerArea/TestGridContainer

func _ready():
	inventory_grid.set_meta('type', ['empty', 'weapon', ])
	$InventoryUI/TopVbox/HBoxContainer/PlayerArea/TestGridContainer.set_meta('type', ['empty', 'weapon', ])
	setup_grid(inventory_grid)

	#load_icon_from_json("res://JSONs/.json")
	load_icon_from_json("res://JSONs/ball_laser.json")
	load_icon_from_json("res://JSONs/heavy_laser.json")
	load_icon_from_json("res://JSONs/laser.json")
	load_icon_from_json("res://JSONs/shotgun.json")
	load_icon_from_json2("res://JSONs/sniper.json")

func setup_grid(grid:GridContainer, x:=5, y:=5):
	grid.columns = x
	for i in range(x):
		for ii in range(y):
			load_icon_from_json("res://JSONs/empty.json")


func load_icon_from_json(path):
	var item = inventory_slot_scene.instantiate()
	item.load_json(path)
	inventory_grid.add_child(item)

func load_icon_from_json2(path):
	var item = inventory_slot_scene.instantiate()
	item.load_json(path)
	inventory_grid2.add_child(item)


func _can_drop_data(position, data):
	return true

func _drop_data(position, data):
	if data is Control:
		data.get_parent().remove_child(data)
		inventory_grid.add_child(data)
