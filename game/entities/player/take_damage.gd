extends Node

var player: Player
var animated_sprite: AnimatedSprite2D

var invincibility_timer: Timer
var can_take_damage: bool = true
func _ready(): 
	invincibility_timer = $InvincibilityTimer

func connect_to_player(_player: Player, _animated_sprite: AnimatedSprite2D):
	player = _player
	animated_sprite = _animated_sprite
	
var _elapsed_time: float = 0
func _process(delta):
	if animated_sprite.material == player.damage_shader:
		animated_sprite.material.set_shader_parameter("elapsed", _elapsed_time)
		_elapsed_time += delta
	else:
		_elapsed_time = 0
	
func take_damage(amount: int):
	if not can_take_damage:
		return
		
	player.current_health -= amount
	
	if player.current_health <= 0:
		Global.game_over(GameState.LastGameStates.LOSS)
		return
		
	animated_sprite.material = player.damage_shader
	can_take_damage = false
	invincibility_timer.start()
	await invincibility_timer.timeout
	animated_sprite.material = Material.new()
	can_take_damage = true
