class_name Level extends Node

signal finished

var game_scene: Game

@export var goal: Goal
@export var spawn_pos: Marker2D


func connect_to_game(game: Game):
	game_scene = game
	finished.connect(game._on_level_finished)
	
func _ready():
	goal.connect("reached", level_over)
	
func level_over():
	finished.emit()
