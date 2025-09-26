extends Node2D

@export var cell_scene: PackedScene
@export var grid_size := Vector2i(72, 40)
@export var cell_size := Vector2(16, 16)
@export var tick_interval := 0.3

@onready var container := $CellContainer
@onready var timer := $Timer

var cells := []
var start_life_ratio := 0.3

func _ready() -> void:
	cell_scene = preload("res://scenes/UI_files/cell_2d.tscn")
	create_grid()
	timer.wait_time = tick_interval
	timer.timeout.connect(_on_timer_tick)
	timer.start()

func create_grid() -> void:
	cells.clear()
	for y in range(grid_size.y):
		var row := []
		for x in range(grid_size.x):
			var cell := cell_scene.instantiate()
			cell.position = Vector2(x * cell_size.x, y * cell_size.y)
			cell.is_alive = randf() < start_life_ratio
			container.add_child(cell)
			row.append(cell)
		cells.append(row)

func _on_timer_tick() -> void:
	var next_state := []
	for y in range(grid_size.y):
		var row := []
		for x in range(grid_size.x):
			var alive = cells[y][x].is_alive
			var next = alive
			# Modified so only half of cells update
			if randf() > 0.5:
				var neighbors := count_alive_neighbors(x, y)
				next = alive and (neighbors == 2 or neighbors == 3) or (not alive and neighbors == 3)
			row.append(next)
		next_state.append(row)

	for y in range(grid_size.y):
		for x in range(grid_size.x):
			cells[y][x].set_alive(next_state[y][x])

func count_alive_neighbors(x: int, y: int) -> int:
	var count := 0
	for dy in range(-1, 2):
		for dx in range(-1, 2):
			if dx == 0 and dy == 0:
				continue
			var nx := x + dx
			var ny := y + dy
			if nx >= 0 and nx < grid_size.x and ny >= 0 and ny < grid_size.y:
				if cells[ny][nx].is_alive:
					count += 1
	return count
