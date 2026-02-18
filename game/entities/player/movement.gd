extends Node

var player: Player
var animated_sprite: AnimatedSprite2D

func connect_to_player(_player: Player, _animated_sprite: AnimatedSprite2D):
	player = _player
	animated_sprite = _animated_sprite

var direction: Utils.Direction
func handle_movement():
	if player.is_stunned or player.is_attacking:
		player.velocity = Vector2.ZERO
		return
		
	var movement: Vector2 = Vector2.ZERO
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction.length() > 0:
		direction = Utils.get_cardinal_direction(input_direction)
			
		player.direction = direction
		animated_sprite.play(Utils.direction_to_string(direction))
		movement = input_direction * player.speed  # input_direction is normalized automatically
	else:
		animated_sprite.stop()
	
	player.velocity = movement
