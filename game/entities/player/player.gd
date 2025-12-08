class_name Player extends CharacterBody2D

@export var speed = 300.0

var attacking: bool = false
	

func get_input():
	if attacking:
		return
		
	if Input.is_action_just_pressed("attack"):
		print("attackign")
		attacking = true
		%AnimationPlayer.play("attack_up")
		
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
	

func _physics_process(_delta):
	get_input()
	move_and_slide()


func _on_animation_player_current_animation_changed(_name):
	attacking = false
