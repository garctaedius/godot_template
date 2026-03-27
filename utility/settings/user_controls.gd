class_name UserControls extends Resource

@export var up_button: InputEvent

func save():
	ResourceSaver.save(self, "user://user_controls.tres")

static func load_or_create() -> UserControls:
	var res: UserControls = load("user://user_controls.tres") as UserControls
	if !res:
		res = UserControls.new()
	return res
