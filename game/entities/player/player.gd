class_name Player extends CharacterBody2D

@export var speed = 300.0

var attacking: bool = false
var direction: String#

func _ready():
	%AnimatedSprite2D.animation = "up"

func get_input():
	if attacking:
		return
		
	if Input.is_action_just_pressed("attack"):
		# TODO: maybe move to it's own function, and move the hitbox
		# FOR EXAMPLE: Could have multiple collision shapes, and just
		# activate the appropriate one when attacking (using direction var)
		direction = %AnimatedSprite2D.animation
		
		attacking = true
		%HitBox.monitorable = true
		%HitBox.monitoring = true
		velocity = Vector2.ZERO
		
		var animation: String = "attack_" + direction
		%AnimatedSprite2D.play(animation)
		
		return
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction.length() > 0:
		var animation: String
		if input_direction.x > 0:
			animation = "right"
		elif input_direction.x < 0:
			animation = "left"
		elif input_direction.y < 0:
			animation = "up"
		elif input_direction.y > 0:
			animation = "down"
			
		%AnimatedSprite2D.play(animation)
	else:
		%AnimatedSprite2D.stop()
		
	velocity = input_direction * speed
	
func teleport(pos: Vector2):
	velocity = Vector2.ZERO
	global_position = pos
	

func _physics_process(_delta):
	get_input()
	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if attacking:
		attacking = false
		%HitBox.monitorable = false
		%HitBox.monitoring = false
		
		%AnimatedSprite2D.animation = direction
