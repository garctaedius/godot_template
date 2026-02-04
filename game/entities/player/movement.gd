extends Node

var player: Player
var animated_sprite: AnimatedSprite2D

func connect_to_player(_player: Player, _animated_sprite: AnimatedSprite2D):
	player = _player
	animated_sprite = _animated_sprite

var direction: String
func handle_movement():
	if player.is_stunned or player.is_attacking:
		player.velocity = Vector2.ZERO
		return
		
	var movement: Vector2 = Vector2.ZERO
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction.length() > 0:
		if input_direction.x > 0:
			direction = "right"
		elif input_direction.x < 0:
			direction = "left"
		elif input_direction.y < 0:
			direction = "up"
		elif input_direction.y > 0:
			direction = "down"
			
		player.direction = direction
		animated_sprite.play(direction)
		movement = input_direction * player.speed
	else:
		animated_sprite.stop()
	
	player.velocity = movement
