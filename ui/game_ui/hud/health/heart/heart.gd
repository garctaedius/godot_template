class_name UIHeart extends TextureRect

var value: set = change_value

var value_to_texture: Dictionary[int, String] = {
	4: "res://ui/game_ui/hud/health/heart/assets/full.png",
	3: "res://ui/game_ui/hud/health/heart/assets/three_quarters.png",
	2: "res://ui/game_ui/hud/health/heart/assets/half.png",
	1: "res://ui/game_ui/hud/health/heart/assets/quarter.png",
	0: "res://ui/game_ui/hud/health/heart/assets/empty.png",
}

func _ready():
	value = 4

func change_value(new_value: int):
	assert(new_value in value_to_texture)
	
	if new_value != value:
		texture = load(value_to_texture[new_value])
	
	value = new_value
