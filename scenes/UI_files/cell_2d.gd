# Cell2D.gd
extends Node2D

var is_alive := false
var live_color := Color.WEB_GRAY
var dead_color := Color.DIM_GRAY
var dead_color2 := Color.DARK_GRAY

@onready var rect := $ColorRect

func _ready():
	update_visual()

func update_visual():
	#rect.color = live_color if is_alive else rand_dead_color()
	rect.color = rand_dead_color() if is_alive else live_color

func rand_dead_color():
	return dead_color
	if randf() < 0.9:
		return dead_color
	return dead_color2
	
func set_alive(state: bool):
	is_alive = state
	update_visual()
