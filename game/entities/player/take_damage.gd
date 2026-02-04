extends Node

# How long the player cannot take damage, as well as how long the color
# is applied to the player. After the duration, 10% of the color is applied.
@export var invincibility_time: float = 2.5
# Number of pixels the player is moved at the start
@export var shift_amplitude: float = 5.0
# How fast the player is moved from side to side. (pi -> moved to other side
# after one second)
@export var shift_frequency: float = 15
# How long the player cannot move, as well as how long the shift is applied to
# the player. After the duration, 10% of the shift is applied.
@export var stun_duration: float = 1

var player: Player
var animated_sprite: AnimatedSprite2D

var invincibility_timer: Timer
var stun_timer: Timer
var can_take_damage: bool = true
func _ready(): 
	invincibility_timer = $InvincibilityTimer
	stun_timer = $StunTimer

func connect_to_player(_player: Player, _animated_sprite: AnimatedSprite2D):
	player = _player
	animated_sprite = _animated_sprite
	
var _elapsed_time: float = 0
func _process(delta):
	if animated_sprite.material == player.damage_shader:
		# Keeps track of how long the shader has been active
		animated_sprite.material.set_shader_parameter("_elapsed", _elapsed_time)
		_elapsed_time += delta
	
func take_damage(amount: int):
	if not can_take_damage:
		return
		
	player.current_health -= amount
	if player.current_health <= 0:
		Global.game_over(GameState.LastGameStates.LOSS)
		return
	
	# Apply damage shader
	animated_sprite.material = player.damage_shader
	_elapsed_time = 0
	animated_sprite.material.set_shader_parameter("amplitude", shift_amplitude)
	animated_sprite.material.set_shader_parameter("frequecy", shift_frequency)
	animated_sprite.material.set_shader_parameter("move_duration", stun_duration)
	animated_sprite.material.set_shader_parameter("color_duration", invincibility_time)
	# Randomly decide whether to move the player left or right (or up or down)
	var move_sign: bool = bool(randi_range(0, 1))
	animated_sprite.material.set_shader_parameter("move_positive", move_sign)
	var move_horizontal = "right" in player.direction or "left" in player.direction
	animated_sprite.material.set_shader_parameter("move_horizontal", move_horizontal)
	
	can_take_damage = false
	player.is_stunned = true
	stun_timer.start(stun_duration)
	
	invincibility_timer.start(invincibility_time)
	await invincibility_timer.timeout
	# Reset shader material once invincibility wears off
	animated_sprite.material = Material.new()
	can_take_damage = true


func _on_stun_timer_timeout():
	player.is_stunned = false
