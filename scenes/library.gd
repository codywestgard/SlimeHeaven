extends Node2D

var item_pool := {}
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Timer.wait_time = 300.
	$Three_Choice_Window.visible = false
	SignalBus.choice_made.connect(_on_choice_made)

func setup():
	add_directory_to_pool("res://JSONs/weapons2")
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	$Timer.paused = true
	$Three_Choice_Window.global_position = Utils.get_player_position()
	$Three_Choice_Window.visible = true
	var options = retrieve_x_options(3)
	$Three_Choice_Window.update_choices(options)
	SignalBus.pause_request.emit()

func _on_choice_made():
	$Timer.paused = false
	$Three_Choice_Window.visible = false
	SignalBus.unpause_request.emit()

func retrieve_x_options(target_x=3,
		target_macrotypes=[], target_microtypes=[], array_so_far=[]):
	var output_array := []
	var keys = item_pool.keys()
	keys.shuffle()
	while output_array.size() < target_x and keys.size() > 0:
		var first_item = keys[0]
		# if target_macrotypes.has(item.macrotype):
		# if target_microtypes.has(item.microtype): #just one match
		if true:
			output_array.append(item_pool[first_item])
		keys.remove_at(0)
	return output_array

func remove_item_from_pool(id):
	if item_pool.has(id):
		item_pool.erase(id)
	else:
		print("Item to remove not found")

func add_item_to_pool(data: Dictionary):
	if item_pool.has(data.id):
		print("duplicate entry being created, probably wrong")
		return
	item_pool[data.id] = data

func add_directory_to_pool(dir_path: String) -> void:
	var dir = DirAccess.open(dir_path)
	if dir == null:
		push_error("Failed to open directory: %s" % dir_path)
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".json"):
			var full_path = dir_path.path_join(file_name)
			var data = Utils.load_json(full_path)
			add_item_to_pool(data)
			
		file_name = dir.get_next()
	dir.list_dir_end()
