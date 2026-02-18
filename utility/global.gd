extends Node

var _main: Main

var player: Player

var current_level: Level

var _game: Game

func game_over(new_game_state: GameState.LastGameStates):
	_game.game_over(new_game_state)
	
func toggle_pause():
	_game.toggle_pause()

func go_to_main_menu():
	get_tree().paused = false
	#TODO: save state here
	_main.load_main_menu()
