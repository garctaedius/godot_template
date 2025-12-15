class_name EnemyTree extends Node2D

var player: Player = Global.player

@export var detection_distance = 100

func _ready():
	%AnimatedSprite2D.play("sleeping")
	
func _physics_process(_delta):
	var player_vector: Vector2 = player.position - position
	%PlayerRay.target_position = player_vector
	if player_vector.length() < detection_distance and !%PlayerRay.is_colliding():
		%AnimatedSprite2D.play("waking")
		
	
func _move_to_attack():
	pass
