class_name EnemyTreeStateMachine extends Node

@onready var player: Player = Global.player

@export var enemy: EnemyTree
@export var initial_state: EnemyTreeState

var current_state: EnemyTreeState

var states: Dictionary[String, EnemyTreeState]
func _ready():	
	for child in get_children():
		if child is EnemyTreeState:
			states[child.name.to_lower()] = child
			child.enemy = enemy
			child.transitioned.connect(_on_state_transission)
			
	
	current_state = initial_state
	current_state.enter.call_deferred()

func _process(delta):
	if not enemy or not player:
		return
	current_state.update(delta)

func _physics_process(delta):
	if not enemy or not player:
		return
	current_state.physics_update(delta)

func _on_state_transission(old_state: EnemyTreeState, new_state_name: String):
	if old_state != current_state:
		return
		
	var new_state: EnemyTreeState = states[new_state_name.to_lower()]
	
	old_state.exit()
	
	new_state.enter()
	
	current_state = new_state
