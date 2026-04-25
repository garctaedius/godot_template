class_name OptionsMenu extends Menu

@onready var basic_options: Control = %BasicOptions

@onready var back_button: Button = %BackButton

@onready var control_menu_button: Button = %ControlsButton
@onready var control_menu: ControlsMenu = %ControlsMenu

var user_settings: UserSettings

func _ready():
	control_menu.hide()
	control_menu_button.connect("pressed", show_controls_menu)
	control_menu.back_button.connect("pressed", show_basic_options)
	
	user_settings = UserSettings.load_or_create()
	update_from_user_settings()
	
	%MasterVolumeController.slider_value_changed.connect(_update_saved_volume)
	%MusicVolumeController.slider_value_changed.connect(_update_saved_volume)
	%SFXVolumeController.slider_value_changed.connect(_update_saved_volume)
	
func update_from_user_settings():
	%MasterVolumeController.set_value(user_settings.master_volume)
	%MusicVolumeController.set_value(user_settings.music_volume)
	%SFXVolumeController.set_value(user_settings.sfx_volume)

func show_controls_menu():
	control_menu.show()
	basic_options.hide()

func show_basic_options():
	control_menu.hide()
	basic_options.show()

func _update_saved_volume(bus: String, level: float):
	if bus.to_lower() == "master":
		user_settings.master_volume = level
	elif bus.to_lower() == "music":
		user_settings.music_volume = level
	elif bus.to_lower() == "sfx":
		user_settings.sfx_volume = level
	user_settings.save()
	
