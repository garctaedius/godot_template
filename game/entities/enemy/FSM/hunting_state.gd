extends EnemyTreeState

var woken_up: bool = false
func enter():
	enemy.animated_sprite.play("waking")
	await enemy.animated_sprite.animation_finished
	woken_up = true

func exit():
	enemy.velocity = Vector2.ZERO
		
func physics_update(_delta):
	if not woken_up:
		return
		
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
		enemy.velocity = player_vector.normalized() * enemy.move_speed
	else:
		enemy.velocity = Vector2.ZERO
		
func update(_delta):
	if not woken_up:
		return
		
	if enemy.velocity != Vector2.ZERO:
		var direction_diff: Dictionary[String, float] = {
			"up": (enemy.velocity.normalized() - Vector2.UP).length(),
			"down": (enemy.velocity.normalized() - Vector2.DOWN).length(),
			"left": (enemy.velocity.normalized() - Vector2.LEFT).length(),
			"right": (enemy.velocity.normalized() - Vector2.RIGHT).length(),
		}
		var min_value = direction_diff.values().min()
		var direction: String = direction_diff.find_key(min_value)
			
		enemy.animated_sprite.play(direction)
	else:
		enemy.animated_sprite.pause()
		enemy.animated_sprite.frame = 0
