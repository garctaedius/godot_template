class_name RemapButton extends Button

@export var key_index: int
@export var action: String

signal setting_key(button: RemapButton)
signal release_key
signal remapped_action(action: String, events: Array[InputEvent])

func _init():
	toggle_mode = true


func _ready():
	set_process_unhandled_input(false)
	update_key_text()


func _toggled(is_button_pressed):
	set_process_unhandled_input(is_button_pressed)
	if is_button_pressed:
		release_focus()
		setting_key.emit(self)
		GameState.can_unpause = false
	else:
		update_key_text()
		grab_focus()
		release_key.emit()
		call_deferred("_set_can_unpause")
	
func _set_can_unpause():
	GameState.can_unpause = true

func _unhandled_input(event):
	if event.pressed:
		# Ignore press if event already exists
		for a in InputMap.get_actions():
			if a.contains("ui"):
				# Built-in actions contain prefix "ui"
				continue
			if InputMap.event_is_action(event, a):
				return
		
		# Get all events for this action
		var all_events = InputMap.action_get_events(action)
		
		# Update the events for the action.
		if key_index >= len(all_events):
			all_events.append(event)
		else:
			all_events[key_index] = event
		
		# Need to erase all events and recreate them to keep the correct order
		InputMap.action_erase_events(action)
		
		for e in all_events:
			InputMap.action_add_event(action, e)
		
		button_pressed = false
		
		remapped_action.emit(action, all_events)


func update_key_text():
	var events = InputMap.action_get_events(action)
	if key_index >= len(events):
		text = "not set"
		return
	
	var new_text = events[key_index].as_text()
	
	# Only keep text up to brackets (sometimes raw_text="W - Physical")
	new_text = new_text.get_slice(" ", 0)
	
	text = new_text
