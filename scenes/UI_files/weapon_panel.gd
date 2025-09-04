extends PanelContainer


func _ready():
	self.set_meta('drop_group', "weapon_slot")
	$VBoxContainer/HBoxContainer/Weapon/TextureRect.set_meta('drop_group', 'weapon')
	$VBoxContainer/HBoxContainer/Chip/TextureRect.set_meta('drop_group', 'chip')
	$VBoxContainer/HBoxContainer/Attachment/TextureRect.set_meta('drop_group', 'attachment')
	#.set_meta('drop_group', '')

var drag_preview
func _get_drag_data(position):
	var preview := duplicate()
	var wrapper := Control.new()
	wrapper.add_child(preview)
	set_drag_preview(wrapper)
	drag_preview = wrapper
	return self

func check_if_valid(target, source):
	return true

	
func _can_drop_data(position, data):
	var preview = drag_preview
	#var hover_node = node_at_position(position)
	var is_valid = true
	return is_valid
	#if hover_node and preview:
		#is_valid = check_if_valid(hover_node, self)
#
		#if preview:
			#if is_valid:
				#preview.modulate = Color.GREEN
			#else:
				#preview.modulate = Color.RED
#
	#return is_valid

#func node_at_position(position):
	#var global_pos = get_global_position() + position
	#var deep_node = _find_deepest_control(global_pos, self)
	#print('deep node: ', deep_node, 'deep meta: ', deep_node.get_meta(' drop_group'))
	#print(self.get_meta('drop_group'))
	#return deep_node
#
#func _find_deepest_control(global_pos, node):
	#for child in node.get_children():
		#if child is Control:
			#var rect = child.get_global_rect()
			#if rect.has_point(global_pos):
				## Dive deeper into this child
				#var deeper = _find_deepest_control(global_pos, child)
				#if deeper != null:
					#return deeper
				#return child
	#return null

func _drop_data(position: Vector2, data: Variant) -> void:
	var parent := get_parent()
	var index := parent.get_children().find(self)
	parent.move_child(data, index)
