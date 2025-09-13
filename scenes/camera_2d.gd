extends Camera2D

var zoom_speed := 0.1
var min_zoom := 0.2
var max_zoom := 4.0

func _process(delta):
	var new_zoom := zoom

	if Input.is_action_just_pressed("zoom_in"):
		new_zoom *= 1.0 + zoom_speed

	elif Input.is_action_just_pressed("zoom_out"):
		new_zoom *= 1.0 - zoom_speed

	# Clamp each axis manually
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)

	zoom = new_zoom
