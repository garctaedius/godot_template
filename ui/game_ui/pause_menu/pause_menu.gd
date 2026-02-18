extends Control

var options_scene_name: String = "res://ui/menus/options_menu/options_menu.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	%ResumeButton.pressed.connect(Global.toggle_pause)
	%ExitToMenuButton.pressed.connect(Global.go_to_main_menu)
	%OptionsButton.pressed.connect(load_options_menu)

var options_menu: OptionsMenu 
func load_options_menu():
	options_menu = load(options_scene_name).instantiate()
	call_deferred("connect_option_menu_buttons")
	
	add_child(options_menu)

func connect_option_menu_buttons():
	options_menu.back_button.pressed.connect(unload_options_menu)

func unload_options_menu():
	if options_menu:
		options_menu.queue_free()
