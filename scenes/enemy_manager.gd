extends Node2D


func _ready():
	$Timer.wait_time = 1.0
	
	await get_tree().process_frame
	for i in range(5):
		spawn_mob()
	
	# in ready load level data, probably a list of enemies
	# on timeout, call enemy_queue func to see whats next
	# call spawn_mob to make it appear

	
func spawn_mob():
	var player_pos = Utils.get_player_position()
	var angle = randf_range(0.0, TAU)
	var offset = Vector2(cos(angle), sin(angle)) * 600
	var new_position = player_pos + offset
	
	var new_enemy= preload("res://scenes/enemy_files/basic_enemy.tscn").instantiate()
	new_enemy.global_position = new_position
	add_child(new_enemy)


func _on_timer_timeout() -> void:
	spawn_mob()
