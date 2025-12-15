class_name Game extends TopLevelNode

signal game_finished

@onready var level_holder: Node = %LevelHolder

@export var player: Player

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
	Global.player = player
	
	load_current()

func load_current():
	if current_level_scene:
		current_level_scene.queue_free()
		
	current_level_scene = load(level_sequence[current_level_index]).instantiate()
	
	# Place player character
	player.teleport(current_level_scene.spawn_pos.position)
	
	# Connect signals
	call_deferred("_connect_level_to_game")
	
	level_holder.add_child.call_deferred(current_level_scene)
	
func _connect_level_to_game():
	# The player only gets moved during physics processing, meaning we have to
	# wait one physics frame to move the player, so that the signals from the
	# level are based on the new position of the player, and not the old one.
	await get_tree().physics_frame
	current_level_scene.connect_to_game(self)
	
func _on_level_finished():
	print("level finished")
	current_level_index += 1
	
	if current_level_index >= len(level_sequence):
		game_finished.emit()
		return
		
	load_current()
	
