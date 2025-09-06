extends Area2D

@onready var signal_to_listen_for
func _ready():
	SignalBus.weapon_slot_1_equipped.connect(load_data)
	pass

func setup():
	# connect a signal to the load_data
	pass


func load_data(data):
	print('sig received  ', data)
	# load the data for the weapon from the UI's signal
	pass

func _physics_process(delta: float) -> void:
	# complex because we call different functions based on what the weapon does
	pass
