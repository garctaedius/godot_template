class_name EnemyTree extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	%AnimatedSprite2D.play("sleeping")
	
func _process(_delta):
	pass
