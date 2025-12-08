class_name Goal extends Area2D

signal reached


func _on_body_entered(body):
	if body is Player:
		reached.emit()
