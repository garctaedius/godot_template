class_name PlayerHitboxes extends Node2D


@onready var hitboxes: Dictionary[Utils.Direction, Area2D] = {
	Utils.Direction.DOWN: %HitBoxDown,
	Utils.Direction.LEFT: %HitBoxLeft,
	Utils.Direction.RIGHT: %HitBoxRight,
	Utils.Direction.UP: %HitBoxUp
}

func _ready():
	deactivate()
		
func activate(direction: Utils.Direction):
	assert(direction in hitboxes.keys(), "Unknown direction!")
	
	var hitbox: Area2D = hitboxes[direction]
	hitbox.monitorable = true
	hitbox.monitoring = true
	
func deactivate():
	for hitbox in hitboxes.values():
		hitbox.monitoring = false
		hitbox.monitorable = false
