class_name Player extends CharacterBody2D

@export_group("Settings")
@export var speed: float = 100.0
@export var hitboxes: PlayerHitboxes
@export var max_health: int = 12

@export_group("Resources")
@export var damage_shader: Material

var attacking: bool = false
var direction: String

var animated_sprite: AnimatedSprite2D

signal health_changed(new_health: int)
var current_health: int:
	set(value):
		current_health = value
		health_changed.emit(value)
		

func _ready():
	%AnimatedSprite2D.animation = "up"
	%Movement.connect_to_player(self, %AnimatedSprite2D)	
	%Attack.connect_to_player(self, %AnimatedSprite2D)	
	
	animated_sprite = %AnimatedSprite2D
	invincibility_timer = $InvincibilityTimer
	
	current_health = max_health
	
func teleport(pos: Vector2):
	velocity = Vector2.ZERO
	global_position = pos
	
var invincibility_timer: Timer
var can_take_damage: bool = true
func take_damage(amount: int):
	if not can_take_damage:
		return
		
	current_health -= amount
	
	if current_health <= 0:
		Global.game_over(GameState.LastGameStates.LOSS)
		return
		
	%AnimatedSprite2D.material = damage_shader
	can_take_damage = false
	invincibility_timer.start()
	await invincibility_timer.timeout
	%AnimatedSprite2D.material = Material.new()
	can_take_damage = true

var _elapsed_time: float = 0
func _process(delta):
	if animated_sprite.material == damage_shader:
		animated_sprite.material.set_shader_parameter("elapsed", _elapsed_time)
		_elapsed_time += delta
	else:
		_elapsed_time = 0
	
func _physics_process(_delta):
	if not attacking:
		attacking = %Attack.handle_attack(direction)
	if not attacking:
		direction = %Movement.handle_movement()
	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if attacking:
		attacking = false
		hitboxes.deactivate()
		
		%AnimatedSprite2D.animation = direction

func _on_hurt_box_body_entered(body):
	if body is Bubble:
		take_damage(body.damage)
		body.queue_free()


func _on_hurt_box_area_entered(area):
	if area is Bubble:
		take_damage(area.damage)
