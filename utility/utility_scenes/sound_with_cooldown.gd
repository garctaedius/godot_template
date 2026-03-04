class_name SoundWithCooldown extends AudioStreamPlayer2D

@export var cooldown: float

var _can_play_sound: bool = true
func play_sound_with_cooldown():
	if _can_play_sound:
		_can_play_sound = false
		
		play()
		
		$Timer.start(cooldown)
		
func _on_timer_timeout():
	_can_play_sound = true
