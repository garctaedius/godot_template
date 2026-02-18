class_name EnemyTree extends CharacterBody2D

var player: Player = Global.player
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var player_ray: RayCast2D = %PlayerRay
@onready var base_pos: Vector2 = global_position
@onready var nav_agent: NavigationAgent2D = %NavigationAgent2D
@onready var collision_shape: CollisionShape2D = %CollisionShape2D

@onready var state_machine: EnemyTreeStateMachine = %StateMachine

@export var wake_up_distance: float = 75
@export var follow_distance: float = 125
@export var move_speed: float = 50

@export var attack_range: float = 50
@export var damage: int = 3
@export var projectile_speed: float = 150.0
@export var attack_cooldown: float = 2.0
	
func _physics_process(_delta):
	move_and_slide()

func take_damage():
	$HurtBox.set_deferred("monitorable", false)
	state_machine.change_state("dying")
	
var damage_direction: Utils.Direction
func _on_hurt_box_area_entered(area):
	damage_direction = Utils.get_cardinal_direction(area.global_position - global_position)
	take_damage()
