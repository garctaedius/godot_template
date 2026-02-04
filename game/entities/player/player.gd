class_name Player extends CharacterBody2D

@export_group("Settings")
@export var speed: float = 100.0
@export var hitboxes: PlayerHitboxes
@export var max_health: int = 12

var direction: String = "up"
var is_stunned: bool = false
var is_attacking: bool = false

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
	%Attack.handle_attack()
	%Movement.handle_movement()
	move_and_slide()

func _on_hurt_box_area_entered(area):
	if area is Bubble:
		%TakeDamage.take_damage(area.damage)
