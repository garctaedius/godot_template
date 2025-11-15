extends Node


func _ready():
	call_deferred("ready_main_menu")

# TODO: connect buttons to start game
func ready_main_menu():
	var main_menu_scene = "res://menus/main_menu.tscn"
	var main_menu = load(main_menu_scene).instantiate()
	add_child(main_menu)

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		swap_fullscreen_mode()
	
func swap_fullscreen_mode():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
