class_name Main extends Node

@onready var scene_holder: Node = %SceneHolder

@export var start_in_game: bool = false

var current_scene: TopLevelNode = null

func _ready():	
	Global._main = self
	
	GameState.LastGameState = GameState.LastGameStates.NONE
	
	if start_in_game:
		call_deferred("load_game")
	else:
		call_deferred("load_main_menu")
	
	set_default_audio()
	

func load_main_menu():
	load_scene("res://ui/menus/main_menu/main_menu.tscn")
	
	
func load_game():
	load_scene("res://game/game.tscn")
	
func load_scene(path: String):
	# Remove the previous scene
	if current_scene:
		current_scene.queue_free()
		
	# Load the new one
	var scene = load(path)
	current_scene = scene.instantiate()
	scene_holder.add_child(current_scene)
	
	current_scene.connect_to_main(self)
	
func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		swap_fullscreen_mode()
	
func swap_fullscreen_mode():
	# TODO: fix for new game window
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func set_default_audio():
	for bus in $DefaultAudioSettings.sound_settings.keys():
		var level: float = $DefaultAudioSettings.sound_settings[bus] / 100
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db(level))
