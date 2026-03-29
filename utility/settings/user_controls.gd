class_name UserControls extends Resource

@export var action_mappings: Dictionary[String, Array]

const CONTORLS_PATH: String = "user://user_controls.tres"

func save():
	ResourceSaver.save(self, CONTORLS_PATH)

static func load_or_create() -> UserControls:
	var res: UserControls
	if FileAccess.file_exists(CONTORLS_PATH):
		res = load(CONTORLS_PATH)
	else:
		res = UserControls.new()
		
	return res
