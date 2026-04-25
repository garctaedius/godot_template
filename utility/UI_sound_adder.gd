extends Node


var playback: AudioStreamPlaybackPolyphonic

@export var button_hover_volume: float = -20
@export var button_hover_pitch_range: Array = [0.5, 0.52]

@export var button_press_volume: float = -15

func _enter_tree():
	# Create an audio player
	var player = AudioStreamPlayer.new()
	player.max_polyphony = 32
	player.bus = "SFX"
	player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(player)

	# Create a polyphonic stream so we can play sounds directly from it
	var stream = AudioStreamPolyphonic.new()
	player.stream = stream
	player.play()
	
	# Get the polyphonic playback stream to play sounds
	playback = player.get_stream_playback()

	get_tree().node_added.connect(_on_node_added)


func _on_node_added(node:Node):
	if node is Button:
		# If the added node is a button we connect to its mouse_entered and 
		# pressed signals and play a sound
		node.mouse_entered.connect(_play_hover)
		node.pressed.connect(_play_pressed)


func _play_hover():
	var sound = preload("res://general_assets/sound_effects/bleep_retro.wav")
	var pitch = randf_range(
		button_hover_pitch_range[0], button_hover_pitch_range[1]
	)
	playback.play_stream(sound, 0, button_hover_volume, pitch)


func _play_pressed():
	var sound = preload("res://general_assets/sound_effects/bleep_retro.wav")
	playback.play_stream(sound, 0, button_press_volume, 1)
