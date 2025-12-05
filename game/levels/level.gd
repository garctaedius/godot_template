class_name Level extends Node

signal finished

var game_scene: Game

func connect_to_game(game: Game):
	game_scene = game
	finished.connect(game._on_level_finished)
	
func _ready():
	pass
	# $NextLevel.connect("pressed", level_over)
	
func level_over():
	finished.emit()
