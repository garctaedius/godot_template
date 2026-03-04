extends HBoxContainer

@export var bus_name: String

@onready var bus_id = AudioServer.get_bus_index(bus_name)

@onready var label: Label = $Label
@onready var volume_slider: HSlider = $VolumeSlider
@onready var value_updater: Timer = $ValueUpdater

var volume: float
func _ready():
	volume = db_to_linear(AudioServer.get_bus_volume_db(bus_id))
	label.text = str(int(volume * 100))
	volume_slider.value = volume
	
func update_value():
	var level: float = volume_slider.value
	label.text = str(int(level * 100))
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(level))

var can_change_value: bool = true
func _on_volume_slider_value_changed(_value):
	if can_change_value:
		can_change_value = false
		value_updater.start()
		
		update_value()

func _on_value_updater_timeout():
	can_change_value = true
	update_value()
