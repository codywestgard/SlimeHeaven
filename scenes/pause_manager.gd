extends Node2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	SignalBus.pause_request.connect(_on_pause_request)
	SignalBus.unpause_request.connect(_on_unpause_request)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		if get_tree().paused:
			hide_inventory()
			_on_unpause_request()
		else:
			show_inventory()
			_on_pause_request()

	if event.is_action_pressed("escape"):
		$SettingsMenu.visible = not $SettingsMenu.visible
		_on_pause_request()


func _on_pause_request():
	get_tree().paused = true

func _on_unpause_request():
	get_tree().paused = false

func show_inventory():
	%Inventory.visible = true
	var viewport_size = get_viewport().get_visible_rect().size
	%Inventory.global_position = Utils.get_player_position() - viewport_size /2

func hide_inventory():
	%Inventory.visible = false
