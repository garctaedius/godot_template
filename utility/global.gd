extends Node

var player: Player

var current_level: Level

var _game: Game

func game_over(new_game_state: GameState.LastGameStates):
	_game.game_over(new_game_state)
	
