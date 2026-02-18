extends EnemyTreeState

@export var hurt_shader: Material

@export var move_amplitude: float = 10
@export var move_duration: float = 1

@export var blink_duration: float = 2
@export var num_blinks: float = 3

@onready var timer: Timer = $DyingTimer

var dust_cloud_scene_name: String = "res://game/entities/enemy/dust_cloud/dust_cloud.tscn"
var death_position: Vector2

func enter():
	# Disable enemy collision
	enemy.collision_shape.set_deferred("disabled", true)
	
	# Set the death shader
	enemy.animated_sprite.material = hurt_shader
	var shader: Material = enemy.animated_sprite.material
	
	# Start timer that will kill the enemy once the shader finishes
	timer.start(move_duration + blink_duration)
	
	# Find direction of attack
	var direction: Utils.Direction = enemy.damage_direction
	if direction == Utils.Direction.NONE:
		direction = Utils.Direction.UP
		
	# Find where the enemy will end up when it disappears
	death_position = enemy.global_position + move_amplitude * -1*Utils.direction_to_vector(direction)
		
	# Set shader parameters
	shader.set_shader_parameter("amplitude", move_amplitude)
	shader.set_shader_parameter("move_duration", move_duration)
	shader.set_shader_parameter("blink_duration", blink_duration)
	shader.set_shader_parameter("num_blinks", num_blinks)
	
	# Determine which way to move the sprite based on where it was attacked
	var move_sign = direction in [Utils.Direction.UP, Utils.Direction.LEFT]
	shader.set_shader_parameter("move_positive", move_sign)
	var move_horizontal = direction in [Utils.Direction.RIGHT, Utils.Direction.LEFT]
	shader.set_shader_parameter("move_horizontal", move_horizontal)
	
var _elapsed_time: float = 0
func update(delta):
	if not enemy.animated_sprite.material:
		return
		
	# update elapsed time for shader
	enemy.animated_sprite.material.set_shader_parameter("_elapsed", _elapsed_time)
	_elapsed_time += delta
	
func create_dust_cloud():
	var dust_cloud: AnimatedSprite2D = load(dust_cloud_scene_name).instantiate()
	
	dust_cloud.global_position = death_position
	Global.current_level.add_child(dust_cloud)

func _on_dying_timer_timeout():
	create_dust_cloud()
	enemy.queue_free()
