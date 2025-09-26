extends Control

var settings_menu : PackedScene
func _ready():
	%PlayButton.pressed.connect(_on_play_pressed)
	%SettingsButton.pressed.connect(_on_settings_pressed)
	%QuitButton.pressed.connect(_on_quit_pressed)
	%CloseSettingsButton.pressed.connect(_on_close_settings_pressed)
	
	%SettingsMenu.visible = false
	#settings_menu = preload("res://scenes/UI_files/settings_menu.tscn")
	

func _on_play_pressed():
	print('play')
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_settings_pressed():
	%PrimaryMenu.visible = false
	%SettingsMenu.visible = true
	#get_tree().change_scene_to_file("res://SettingsMenu.tscn")

func _on_quit_pressed():
	print('quit the game')
	#get_tree().quit()

func _on_close_settings_pressed():
	%PrimaryMenu.visible = true
	%SettingsMenu.visible = false
