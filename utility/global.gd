extends Node

var player: Player

var current_level: Level

func game_over():
	print("game over")

func spawn_projectile(scene: PackedScene, position: Vector2,
					  direction: Vector2, speed: float):
	var projectile: Node2D = scene.instantiate()
	projectile.position = position
	projectile.linear_velocity = speed * direction
	current_level.add_child(projectile)
	
