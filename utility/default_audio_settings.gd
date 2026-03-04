extends Node

@export var master: int = 70
@export var music: int = 40
@export var sfx: int = 70

@onready var sound_settings: Dictionary[String, float] = {
	"Master": master,
	"Music": music,
	"SFX": sfx,
}
