extends PanelContainer

func _ready():
	self.set_meta('type', ["weapon_group"])
	$VBoxContainer/HBoxContainer/PanelContainerWeapon.set_meta('type', ['empty', 'weapon', ] )
	$VBoxContainer/HBoxContainer/PanelContainerChip.set_meta('type', ['empty', 'chip', ] )
	$VBoxContainer/HBoxContainer/PanelContainerAttachment.set_meta('type', ['empty', 'attachment', ] )
	
	$VBoxContainer/HBoxContainer/PanelContainerWeapon.set_meta('equip_signal', SignalBus.weapon_equipped)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print('clicked on : ', self)
		SignalBus.weapon_selected.emit(self)
		_on_weapon_updated()

func _on_weapon_updated():
	var weapon_item = $VBoxContainer/HBoxContainer/PanelContainerWeapon/Inventory_Slot_Weapon
	# when a weapon is updated, read the three nodes
	# form the data from that as a dictionary
	# send a signal to the relevant weapon slot
	# do this via signal, or this panel could know about the weapon slot, and update that way
	# sprite, target_alg, damage, fire_rate, area2D info, special logic (charging)
	#var data_dict = {
		#'one': 1,
		#'two': 2,
	#}
	#data_dict['sprite_path'] = 1
	##data_dict[''] = 1
	#pass
	var player_node = Utils.get_player_node()
	player_node.update_weapon(preload("res://scenes/weapon_files/basic_gun.tscn"))
	pass



#var drag_preview
#func _get_drag_data(position):
	#var preview := duplicate()
	#var wrapper := Control.new()
	#wrapper.add_child(preview)
	#set_drag_preview(wrapper)
	#drag_preview = wrapper
	#return self
	#
#func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	## these panels only swap with each other
	#if is_instance_of(data, Node):
		#return self.get_parent() == data.get_parent()
	#return false
#
#
#func _drop_data(position: Vector2, data: Variant) -> void:
	#var parent := get_parent()
	#var index := parent.get_children().find(self)
	#parent.move_child(data, index)
