extends GridContainer

func _can_drop_data(position, data):
	return data is Control  # Or check for specific item types

func _drop_data(position, data):
	if data.get_parent():
		data.get_parent().remove_child(data)
	add_child(data)
