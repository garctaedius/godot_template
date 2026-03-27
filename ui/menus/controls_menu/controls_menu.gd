class_name ControlsMenu extends Control

@onready var back_button: Button = %BackButton
@onready var button_container: GridContainer = %ButtonContainer

var remap_buttons: Array[RemapButton]

var user_controls: UserControls

# Called when the node enters the scene tree for the first time.
func _ready():
	# user_controls = UserControls.load_or_create()
	#$GridContainer/UpButton1.text = user_controls.up_button
	
	for button in button_container.get_children():
		if button is RemapButton:
			remap_buttons.append(button)
			button.setting_key.connect(disable_all_other_keys)
			button.release_key.connect(enable_all_keys)

func disable_all_other_keys(pressed_button: RemapButton):
	for button in remap_buttons:
		if button == pressed_button:
			continue
		button.disabled = true
	back_button.disabled = true

func enable_all_keys():
	for button in remap_buttons:
		button.disabled = false
	back_button.disabled = false
