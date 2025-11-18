class_name ExitButton extends Button


func _on_pressed():
	# TODO: save state first
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(0)
