extends Control

signal node_selected(node_id)
var node_id: int

func _ready():
	$TextureButton.pressed.connect(_on_pressed)
	$TextureButton.texture_normal = preload("res://assets/enemy.png")

func setup(_node_id):
	node_id = _node_id
	$Label.text = str(node_id)

func _on_pressed():
	print('pressed id: ', node_id)
	node_selected.emit(node_id)

func setup2(path):
	var data = Utils.load_json(path)
	#assert data.macroclass == "Map_Node"
	# 
