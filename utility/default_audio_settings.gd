extends Node

@export var master: int
@export var music: int
@export var sfx: int

@onready var sound_settings: Dictionary[String, float] = {
	"Master": master,
	"Music": music,
	"SFX": sfx,
}
