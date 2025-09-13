extends Node2D

var path_node
func _ready():
	$Timer.wait_time = 1.0
	
	# load level data, probably a list of enemies
	# on timeout, get next in queue, 

	
func spawn_mob():
	print('mob spawned')
	var player_pos = Utils.get_player_position()
	var angle = randf_range(0.0, TAU)
	var offset = Vector2(cos(angle), sin(angle)) * 1000
	var new_position = player_pos + offset
	
	var new_enemy= preload("res://scenes/enemy_files/basic_enemy.tscn").instantiate()
	new_enemy.global_position = new_position
	add_child(new_enemy)


func _on_timer_timeout() -> void:
	spawn_mob()
