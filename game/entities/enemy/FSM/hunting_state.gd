extends EnemyTreeState

func exit():
	enemy.velocity = Vector2.ZERO
		
func physics_update(_delta):
	# TODO: add counter for how long it hasn't seen player. If it hasn't seen
	# player in a set amount of time, to go idle no matter how far away the player is
	#var player_vector: Vector2 = Global.player.position - enemy.position
	#enemy.player_ray.target_position = player_vector
	#if player_vector.length() < enemy.detection_distance and !%PlayerRay.is_colliding():
		#transitioned.emit(self, "hunting")
		
	var player_vector: Vector2 = player.position - enemy.position
	if player_vector.length() < enemy.attack_range:
		transitioned.emit(self, "attacking")
		return
		
	if player_vector.length() < enemy.follow_distance:
		enemy.velocity = get_dir_from_agent() * enemy.move_speed
	else:
		transitioned.emit(self, "backtobase")
		return
	
func get_dir_from_agent() -> Vector2:
	enemy.nav_agent.target_position = player.position
	return enemy.position.direction_to(enemy.nav_agent.get_next_path_position())
	
		
func update(_delta):
	update_animation()

func update_animation():
	if enemy.velocity != Vector2.ZERO:
		var direction = Utils.get_cardinal_direction(enemy.velocity)
		enemy.animated_sprite.play(Utils.direction_to_string(direction))
	else:
		enemy.animated_sprite.pause()
		enemy.animated_sprite.frame = 0
