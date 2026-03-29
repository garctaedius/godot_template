class_name ControlsMenu extends Control

@onready var back_button: Button = %BackButton
@onready var button_container: GridContainer = %ButtonContainer

var remap_buttons: Array[RemapButton]

var user_controls: UserControls

# Called when the node enters the scene tree for the first time.
func _ready():
	user_controls = UserControls.load_or_create()
	
	for button in button_container.get_children():
		if button is RemapButton:
			remap_buttons.append(button)
			button.setting_key.connect(disable_all_other_keys)
			button.release_key.connect(enable_all_keys)
			button.remapped_action.connect(_on_key_remapped)
	
	change_keys_from_user_controls()

func change_keys_from_user_controls():
	for action in user_controls.action_mappings.keys():
		InputMap.action_erase_events(action)
		for event in user_controls.action_mappings[action]:
			InputMap.action_add_event(action, event)
	
	for button in remap_buttons:
		button.update_key_text()
	
func _on_key_remapped(action: String, events: Array[InputEvent]):
	user_controls.action_mappings[action] = events
	
	user_controls.save()

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
