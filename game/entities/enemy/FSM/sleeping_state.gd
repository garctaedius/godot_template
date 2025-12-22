extends EnemyTreeState

func enter():
	enemy.animated_sprite.play("sleeping")
		
func physics_update(_delta):
	var player_vector: Vector2 = player.position - enemy.position
	enemy.player_ray.target_position = player_vector
	if player_vector.length() < enemy.wake_up_distance and !%PlayerRay.is_colliding():
		transitioned.emit(self, "waking")
