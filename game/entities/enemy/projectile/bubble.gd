class_name Bubble extends Area2D

var damage: int
var speed: float
var direction: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_area_entered(_area):
	queue_free()


func _on_body_entered(_body):
	queue_free()
