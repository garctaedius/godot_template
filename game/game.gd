class_name Game extends TopLevelNode

signal game_finished

@onready var level_holder: Node = %LevelHolder

var level_sequence = [
	"res://game/levels/level_1/level_1.tscn",
	"res://game/levels/level_2/level_2.tscn"
]

var current_level_index: int = 0
var current_level_scene: Level = null

func connect_to_main(main: Main):
	super(main)
	game_finished.connect(main.load_main_menu)

func _ready():
	load_current()

func load_current():
	if current_level_scene:
		current_level_scene.queue_free()
		
	current_level_scene = load(level_sequence[current_level_index]).instantiate()
	current_level_scene.connect_to_game(self)
	
	level_holder.add_child.call_deferred(current_level_scene)
	
	
func _on_level_finished():
	current_level_index += 1
	
	if current_level_index >= len(level_sequence):
		game_finished.emit()
		return
		
	load_current()
	
