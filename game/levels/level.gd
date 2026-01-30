class_name Level extends Node

signal finished

var game_scene: Game

@export var goal: Goal
@export var spawn_pos: Marker2D

@onready var navigation_region: NavigationRegion2D = %NavigationRegion2D
@onready var level_outline: Polygon2D = %LevelOutline
@onready var projectile_holder: Node = $ProjectileHolder


func connect_to_game(game: Game):
	game_scene = game
	finished.connect(game._on_level_finished)
	
func _ready():
	goal.connect("reached", level_over)
	
	create_navigation_mesh()
	
	SignalBus.spawn_projectile.connect(_on_projectile_spawned)
	
func create_navigation_mesh():
	var navigation_mesh = navigation_region.navigation_polygon
	# Create an outline of the level before baking
	navigation_mesh.add_outline(level_outline.polygon)
	navigation_region.bake_navigation_polygon()
	
func level_over():
	finished.emit()
	
func _on_projectile_spawned(projectile: Node, position: Vector2):
	projectile.position = position
	projectile_holder.add_child(projectile)
