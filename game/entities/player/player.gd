class_name Player extends CharacterBody2D

@export var speed: float = 100.0
@export var hitboxes: PlayerHitboxes
@export var max_health: int = 12

var attacking: bool = false
var direction: String

signal health_changed(new_health: int)
var current_health: int:
	set(value):
		current_health = value
		health_changed.emit(value)
		

func _ready():
	%AnimatedSprite2D.animation = "up"
	%Movement.connect_to_player(self, %AnimatedSprite2D)	
	%Attack.connect_to_player(self, %AnimatedSprite2D)	
	
	current_health = max_health
	
func teleport(pos: Vector2):
	velocity = Vector2.ZERO
	global_position = pos
	
func take_damage(amount: int):
	current_health -= amount
	#TODO: play animation here
	if current_health <= 0:
		Global.game_over(GameState.LastGameStates.LOSS)
	
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
