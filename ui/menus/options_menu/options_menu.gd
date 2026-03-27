class_name OptionsMenu extends Menu

@onready var basic_options: Control = %BasicOptions

@onready var back_button: Button = %BackButton

@onready var control_menu_button: Button = %ControlsButton
@onready var control_menu: ControlsMenu = %ControlsMenu

func _ready():
	control_menu.hide()
	
	control_menu_button.connect("pressed", show_controls_menu)
	
	control_menu.back_button.connect("pressed", show_basic_options)

func show_controls_menu():
	control_menu.show()
	basic_options.hide()

func show_basic_options():
	control_menu.hide()
	basic_options.show()
