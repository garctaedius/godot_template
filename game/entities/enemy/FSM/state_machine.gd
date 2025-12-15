class_name EnemyTreeStateMachine extends Node

@export var enemy: EnemyTree
@export var initial_state: EnemyTreeState

var current_state: EnemyTreeState

var states: Dictionary[String, EnemyTreeState]
func _ready():
	current_state = initial_state
	
	for child in enemy.get_children():
		if child is EnemyTreeState:
			states[child.name.to_lower()] = child
			child.enemy = enemy
			child.transitioned.connect(_on_state_transission)

func _process(delta):
	current_state.Update(delta)

func _physics_process(delta):
	current_state.PhysicsUpdate(delta)

func _on_state_transission(old_state: EnemyTreeState, new_state_name: String):
	if old_state != current_state:
		return
		
	var new_state: EnemyTreeState = states[new_state_name]
	
	old_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
