extends Control

func _can_drop_data(position, data):
	return true

func _drop_data(position: Vector2, data) -> void:
	var target_parent = get_parent()
	var source_parent = data.get_parent()

	if source_parent != target_parent:
		# Remove from old parent
		source_parent.remove_child(data)
		# Add to new parent
		target_parent.add_child(data)
	
	# Move to correct index
	var target_index := target_parent.get_children().find(self)
	target_parent.move_child(data, target_index)
