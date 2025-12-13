class_name Player extends CharacterBody2D

@export var speed = 100.0
@export var hitboxes: PlayerHitboxes

var attacking: bool = false
var direction: String

func _ready():
	%AnimatedSprite2D.animation = "up"
	%Movement.connect_to_player(self, %AnimatedSprite2D)	
	%Attack.connect_to_player(self, %AnimatedSprite2D)	
	
func teleport(pos: Vector2):
	velocity = Vector2.ZERO
	global_position = pos
	
func _physics_process(_delta):
	if not attacking:
		attacking = %Attack.handle_attack()
	if not attacking:
		%Movement.handle_movement()
	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if attacking:
		attacking = false
		hitboxes.deactivate()
		
		%AnimatedSprite2D.animation = %Attack.direction
