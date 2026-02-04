extends Node

var player: Player
var animated_sprite: AnimatedSprite2D

func connect_to_player(_player: Player, _animated_sprite: AnimatedSprite2D):
	player = _player
	animated_sprite = _animated_sprite
	
func handle_attack():
	if player.is_stunned or player.is_attacking:
		return
		
	if Input.is_action_just_pressed("attack"):
		player.velocity = Vector2.ZERO
		
		var animation: String = "attack_" + player.direction
		animated_sprite.play(animation)
		
		player.hitboxes.activate(player.direction)
		
		player.is_attacking = true

func _on_animated_sprite_2d_animation_finished():
	if "attack" in animated_sprite.animation:
		player.is_attacking = false
		player.hitboxes.deactivate()
		animated_sprite.animation = player.direction
	
