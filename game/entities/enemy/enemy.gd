class_name EnemyTree extends CharacterBody2D

var player: Player = Global.player
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var player_ray: RayCast2D = %PlayerRay
@onready var base_pos: Vector2 = global_position

@export var wake_up_distance = 75
@export var follow_distance = 125
@export var attack_range = 50
@export var move_speed = 50
	
func _physics_process(_delta):
	move_and_slide()
