class_name UserSettings extends Resource

@export var master_volume: float = 0.7
@export var music_volume: float = 0.4
@export var sfx_volume: float = 0.7

const SETTINGS_PATH: String = "user://user_settings.tres"

func save():
	ResourceSaver.save(self, SETTINGS_PATH)

static func load_or_create() -> UserSettings:
	var res: UserSettings
	if FileAccess.file_exists(SETTINGS_PATH):
		res = load(SETTINGS_PATH)
	else:
		res = UserSettings.new()
		
	return res
	
