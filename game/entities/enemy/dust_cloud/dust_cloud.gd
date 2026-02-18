extends AnimatedSprite2D


func _ready():
	play("poof")


func _on_animation_finished():
	queue_free()
