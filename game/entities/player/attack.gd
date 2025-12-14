extends Node

var player: Player
var animated_sprite: AnimatedSprite2D

func connect_to_player(_player: Player, _animated_sprite: AnimatedSprite2D):
	player = _player
	animated_sprite = _animated_sprite
	
func handle_attack(direction: String) -> bool:
	if Input.is_action_just_pressed("attack"):
		player.velocity = Vector2.ZERO
		
		var animation: String = "attack_" + direction
		animated_sprite.play(animation)
		
		player.hitboxes.activate(direction)
		
		return true
	
	return false
