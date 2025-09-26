extends Node2D

func _ready():
	Utils.player_node = $Player
	Utils.inventory_node = %Inventory
	SignalBus.choice_made.connect(combat_start)
	
	$Timer.wait_time = 30.

	if $Library:
		$Library.setup()

func combat_start():
	SignalBus.combat_start.emit()
	SignalBus.unpause_request.emit()
	%Inventory.visible = false
	%UI_Map.visible = false

func combat_end():
	SignalBus.combat_end.emit()
	SignalBus.pause_request.emit()
	%Inventory.visible = false
	%UI_Map.visible = true

func _on_timer_timeout() -> void:
	combat_end()
