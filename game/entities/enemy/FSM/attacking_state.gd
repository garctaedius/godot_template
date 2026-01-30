extends EnemyTreeState

var bubble_scene_name: String = "res://game/entities/enemy/projectile/bubble.tscn"

@onready var attack_cooldown_timer: Timer = $AttackCooldown

@export var reset_animation_cooldown: float = 0.4

var direction: String

func enter():
	direction = "null"
	enemy.animated_sprite.pause()
	enemy.velocity = Vector2.ZERO
	
	attack_cooldown_timer.wait_time = enemy.attack_cooldown
	attack_cooldown_timer.start()
		
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
		
		if "attacking" not in enemy.animated_sprite.animation:
			enemy.animated_sprite.frame = 0
			enemy.animated_sprite.frame_progress = 0
			
		enemy.animated_sprite.animation = "attacking_" + direction

func shoot_bubble():
	var bubble_scene: Bubble = load(bubble_scene_name).instantiate()
	bubble_scene.damage = enemy.damage
	bubble_scene.speed = enemy.projectile_speed
	bubble_scene.direction = player_vector
	
	SignalBus.spawn_projectile.emit(bubble_scene, enemy.global_position)

func _on_attack_cooldown_timeout():
	if state_machine.current_state != self:
		return
		
	shoot_bubble()
	attack_cooldown_timer.start()
	enemy.animated_sprite.frame = 1
	
	var reset_animation_timer: Timer = Timer.new()
	add_child(reset_animation_timer)
	reset_animation_timer.start(reset_animation_cooldown)
	await reset_animation_timer.timeout
	enemy.animated_sprite.frame = 0
	
