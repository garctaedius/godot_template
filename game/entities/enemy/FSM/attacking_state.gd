extends EnemyTreeState

func enter():
	enemy.animated_sprite.pause()
	enemy.velocity = Vector2.ZERO
		
func physics_update(_delta):		
	var player_vector: Vector2 = player.position - enemy.position
	enemy.player_ray.target_position = player_vector
	if player_vector.length() > enemy.attack_range:
		transitioned.emit(self, "hunting")
		return
	
	print("attacking")
