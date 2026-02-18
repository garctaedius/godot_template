extends EnemyTreeState
		
func physics_update(_delta):
	var player_vector: Vector2 = player.position - enemy.position
	if player_vector.length() < enemy.follow_distance:
		transitioned.emit(self, "hunting")
		return
		
	var base_vector: Vector2 = enemy.base_pos - enemy.position
	if base_vector.length() < 5:  # random tolerance level
		# TODO: Use navigation agent signal to determine that goal is reached
		transitioned.emit(self, "fallingasleep")
		return
		
	enemy.velocity = get_dir_from_agent() * enemy.move_speed
	
func get_dir_from_agent() -> Vector2:
	enemy.nav_agent.target_position = enemy.base_pos
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
