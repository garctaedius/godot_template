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
	animated_sprite = %AnimatedSprite2D
	
	animated_sprite.animation = "up"
	%Movement.connect_to_player(self, animated_sprite)	
	%Attack.connect_to_player(self, animated_sprite)	
	%TakeDamage.connect_to_player(self, animated_sprite)
	
	current_health = max_health
	
func teleport(pos: Vector2):
	velocity = Vector2.ZERO
	global_position = pos
	
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
		
		animated_sprite.animation = direction

func _on_hurt_box_area_entered(area):
	if area is Bubble:
		%TakeDamage.take_damage(area.damage)
