extends HBoxContainer

@export var heart_scene: PackedScene

var num_hearts: int
var num_full: int
var final_heart_status: int

var hearts: Array[UIHeart]

func _ready():
	call_deferred("set_up")
	
func set_up():
	num_hearts = Global.player.max_health
	
	Global.player.health_changed.connect(_on_health_changed)
	
	create_hearts()
	
func create_hearts():
	@warning_ignore("integer_division")
	for i in range(num_hearts/4):
		var new_heart_scene: UIHeart = heart_scene.instantiate()
		add_child(new_heart_scene)
		hearts.append(new_heart_scene)
	
func _on_health_changed(new_value: int):
	new_value = clampi(new_value, 0, new_value)
		
	var health_to_distribute: int = new_value
	for heart in hearts:
		var health_for_this_heart = min(4, health_to_distribute)
		heart.value = health_for_this_heart
		health_to_distribute -= health_for_this_heart
	
