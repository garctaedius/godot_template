extends EnemyTreeState

func enter():
	enemy.velocity = Vector2.ZERO
	
	enemy.animated_sprite.play("falling_asleep")
	await enemy.animated_sprite.animation_finished
	transitioned.emit(self, "sleeping")
		
func physics_update(_delta):
	var player_vector: Vector2 = player.position - enemy.position
	enemy.player_ray.target_position = player_vector
	if player_vector.length() < enemy.follow_distance and !%PlayerRay.is_colliding():
		transitioned.emit(self, "hunting")
