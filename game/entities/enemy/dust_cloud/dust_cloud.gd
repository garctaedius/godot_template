class_name DustCloud extends AnimatedSprite2D


func _ready():
	play("poof")

func set_sound_and_play(sound: AudioStream):
	$Player.stream = sound
	$Player.play()

func _on_animation_finished():
	queue_free()
