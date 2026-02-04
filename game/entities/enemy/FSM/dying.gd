extends EnemyTreeState

@export var hurt_shader: Material

@export var move_amplitude: float = 10
@export var move_duration: float = 1

@export var blink_duration: float = 2
@export var num_blinks: float = 3

@onready var timer: Timer = $DyingTimer

func enter():
	enemy.animated_sprite.material = hurt_shader
	var shader: Material = enemy.animated_sprite.material
	var dying_time = move_duration + blink_duration
	print(dying_time)
	timer.start(dying_time)
	
	# Set shader parameters
	shader.set_shader_parameter("amplitude", move_amplitude)
	shader.set_shader_parameter("move_duration", move_duration)
	shader.set_shader_parameter("blink_duration", blink_duration)
	shader.set_shader_parameter("num_blinks", num_blinks)
	
var _elapsed_time: float = 0
func update(delta):
	if not enemy.animated_sprite.material:
		return
		
	# update elapsed time for shader
	enemy.animated_sprite.material.set_shader_parameter("_elapsed", _elapsed_time)
	_elapsed_time += delta


func _on_dying_timer_timeout():
	print("DONE!")
	enemy.queue_free()
