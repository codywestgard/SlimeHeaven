#extends Control
extends CanvasLayer

var player
var time_left : int
func _ready():
	time_left = 30
	update_timer()
	player = Utils.get_player_node()

func update_hp():
	pass

func update_money():
	pass

func update_timer():
	$Label.text = str(time_left)


func _on_timer_timeout() -> void:
	time_left -= 1
	update_timer()
