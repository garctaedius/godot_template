class_name State extends Node

@warning_ignore("unused_signal")
signal transitioned(old_state: State, new_state_name: String)

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta):
	pass
	
func PhysicsUpdate(_delta):
	pass
