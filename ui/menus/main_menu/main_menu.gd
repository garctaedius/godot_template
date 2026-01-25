class_name MainMenu extends TopLevelNode

@onready var start_menu: StartMenu = %StartMenu
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var credits_menu: CreditsMenu = %CreditsMenu
@onready var win_menu: WinMenu = %WinMenu
@onready var lose_menu: LoseMenu = %LoseMenu

func _ready():
	match GameState.LastGameState:
		GameState.LastGameStates.NONE:
			show_start_menu()
		GameState.LastGameStates.WIN:
			show_win_menu()
		GameState.LastGameStates.LOSS:
			show_lose_menu()
	
	_connect_start_menu()
	_connect_options_menu()
	_connect_credits_menu()
	_connect_win_menu()
	_connect_lose_menu()
	
func connect_to_main(main: Main):
	super(main)
	start_menu.start_button.connect("pressed", main.load_game)			
	
func show_start_menu():
	_show_menu(start_menu)
	
func show_options_menu():
	_show_menu(options_menu)
	
func show_credits_menu():
	_show_menu(credits_menu)

func show_win_menu():
	_show_menu(win_menu)

func show_lose_menu():
	_show_menu(lose_menu)
	
func _show_menu(menu: Menu):
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
	
func _connect_win_menu():
	win_menu.back_button.connect("pressed", show_start_menu)
	
func _connect_lose_menu():
	lose_menu.back_button.connect("pressed", show_start_menu)
