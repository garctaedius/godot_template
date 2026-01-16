extends EnemyTreeState

var bubble_scene_name: String = "res://game/entities/enemy/projectile/bubble.tscn"

var direction: String

func enter():
	direction = "null"
	enemy.animated_sprite.pause()
	enemy.velocity = Vector2.ZERO
		
var player_vector: Vector2
func physics_update(_delta):		
	# Check distance to player
	player_vector = player.position - enemy.position
	enemy.player_ray.target_position = player_vector
	if player_vector.length() > enemy.attack_range:
		transitioned.emit(self, "hunting")
		return

func update(_delta):
	update_animation()
	
func update_animation():
	# Find direction towards player
	var to_player: Vector2 = enemy.position.direction_to(player.global_position).normalized()
	var direction_diff: Dictionary[String, float] = {
		"up": (to_player - Vector2.UP).length(),
		"down": (to_player - Vector2.DOWN).length(),
		"left": (to_player - Vector2.LEFT).length(),
		"right": (to_player - Vector2.RIGHT).length(),
	}
	var min_value = direction_diff.values().min()
	var new_direction: String = direction_diff.find_key(min_value)
	
	# Update animation if needed
	if not direction or new_direction != direction:
		direction = new_direction
		
		enemy.animated_sprite.play("attacking_" + direction)
		


func _on_animated_sprite_2d_frame_changed():
	if "attacking" in enemy.animated_sprite.animation and enemy.animated_sprite.frame == 1:
		shoot_bubbble()

func shoot_bubbble():
	var bubble_scene = load(bubble_scene_name)
	Global.spawn_projectile(bubble_scene, enemy.position,  player_vector, 3)
