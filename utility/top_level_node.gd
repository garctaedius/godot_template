class_name TopLevelNode extends Node

@export var music_player: AudioStreamPlayer

var main_scene: Main

func _ready():
	music_player.bus = "Music"

func connect_to_main(main: Main):
	main_scene = main
