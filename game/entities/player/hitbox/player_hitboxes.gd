class_name PlayerHitboxes extends Node2D


@onready var hitboxes: Dictionary[String, Area2D] = {
	"down": %HitBoxDown,
	"left": %HitBoxLeft,
	"right": %HitBoxRight,
	"up": %HitBoxUp
}

func _ready():
	deactivate()
		
func activate(direction: String):
	direction = direction.to_lower()
	assert(direction in hitboxes.keys(), "Unknown direction!")
	
	var hitbox: Area2D = hitboxes[direction]
	hitbox.monitorable = true
	hitbox.monitoring = true
	
func deactivate():
	for hitbox in hitboxes.values():
		hitbox.monitoring = false
		hitbox.monitorable = false
