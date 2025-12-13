extends Node

var player: Player
var animated_sprite: AnimatedSprite2D

func connect_to_player(_player: Player, _animated_sprite: AnimatedSprite2D):
	player = _player
	animated_sprite = _animated_sprite

func handle_movement():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction.length() > 0:
		var animation: String
		if input_direction.x > 0:
			animation = "right"
		elif input_direction.x < 0:
			animation = "left"
		elif input_direction.y < 0:
			animation = "up"
		elif input_direction.y > 0:
			animation = "down"
			
		animated_sprite.play(animation)
	else:
		animated_sprite.stop()
		
	player.velocity = input_direction * player.speed
