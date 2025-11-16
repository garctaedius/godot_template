class_name MainMenu extends TopLevelNode

@onready var start_menu: StartMenu = %StartMenu
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var credits_menu: CreditsMenu = %CreditsMenu

func _ready():
	show_start_menu()
	
	_connect_start_menu()
	_connect_options_menu()
	_connect_credits_menu()
	
func connect_to_main(main: Main):
	super(main)
	start_menu.start_button.connect("pressed", main.load_game)
	
func show_start_menu():
	_show_menu(start_menu)
	
func show_options_menu():
	_show_menu(options_menu)
	
func show_credits_menu():
	_show_menu(credits_menu)
	
func _show_menu(menu):
	for child in get_children():
		if child is not Menu:
			continue
		if child == menu:
			child.show()
		else:
			child.hide()

func _connect_start_menu():
	# TODO: add connection for start button
	start_menu.options_button.connect("pressed", show_options_menu)
	start_menu.credits_button.connect("pressed", show_credits_menu)

func _connect_options_menu():
	options_menu.back_button.connect("pressed", show_start_menu)
	
func _connect_credits_menu():
	credits_menu.back_button.connect("pressed", show_start_menu)
