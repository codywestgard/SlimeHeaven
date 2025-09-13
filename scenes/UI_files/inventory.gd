extends Control

var inventory_slot_scene = preload("res://scenes/UI_files/inventory_slot.tscn")
@onready var inventory_grid = $InventoryUI/TopVbox/HBoxContainer/VBoxContainer/Panel2/Inventory
@onready var info_panel = $InventoryUI/TopVbox/HBoxContainer/PlayerArea/Panel/Label
@onready var weapon_info = $InventoryUI/TopVbox/HBoxContainer/WeaponSlots/WeaponInfo/Label
var selected_item
var selected_weapon

func _ready():
	SignalBus.item_selected.connect(_on_item_selected)
	SignalBus.weapon_selected.connect(_on_weapon_selected)
	SignalBus.weapon_equipped.connect(_on_weapon_equipped)
	
	
	inventory_grid.set_meta('type', ['empty', 'weapon', 'chip', 'attachment'])

	#load_icon_from_json("res://JSONs/.json")
	load_icon_from_json("res://JSONs/laser.json")
	load_icon_from_json("res://JSONs/laser.json")
	load_icon_from_json("res://JSONs/laser.json")
	load_icon_from_json("res://JSONs/laser.json")
	load_icon_from_json("res://JSONs/ball_laser.json")
	load_icon_from_json("res://JSONs/heavy_laser.json")
	load_icon_from_json("res://JSONs/chips/blue_chip.json")

	$InventoryUI/TopVbox/HBoxContainer/WeaponSlots/Weapon_Panel1.set_meta('equip_signal', SignalBus.weapon_equipped)
	$InventoryUI/TopVbox/HBoxContainer/WeaponSlots/Weapon_Panel1.set_meta('weapon_slot_number', 1)
	$InventoryUI/TopVbox/HBoxContainer/WeaponSlots/Weapon_Panel2.set_meta('weapon_slot_number', 2)
	$InventoryUI/TopVbox/HBoxContainer/WeaponSlots/Weapon_Panel3.set_meta('weapon_slot_number', 3)
	$InventoryUI/TopVbox/HBoxContainer/WeaponSlots/Weapon_Panel4.set_meta('weapon_slot_number', 4)

func _on_item_selected(item):
	selected_item = item
	item.modulate = Color(0.68, 0.85, 0.90, 0.8)
	update_info_panel(item)

func update_info_panel(item):
	info_panel.text = str(item.global_position)

func _on_weapon_selected(weapon):
	selected_weapon = weapon
	update_weapon_info(weapon)

func _on_weapon_equipped(weapon, slot_number):
	var node_string = "InventoryUI/TopVbox/HBoxContainer/WeaponSlots/Weapon_Panel" + str(slot_number)
	var node_to_update = get_node(node_string)
	#print(node_to_update, 'node to update')
	#node_to_update.update_weapon()
	pass

func update_weapon_info(weapon):
	weapon_info.text = str(weapon.global_position)

func load_icon_from_json(path):
	var item = inventory_slot_scene.instantiate()
	item.load_json(path)
	inventory_grid.add_child(item)
	
func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		#print(inventory_open)
		SceneSwitcher.goto_scene("res://scenes/main.tscn")
