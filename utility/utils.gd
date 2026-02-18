extends Node

enum Direction {UP, DOWN, RIGHT, LEFT, NONE}

func get_cardinal_direction(dir: Vector2) -> Direction:
	if dir == Vector2.ZERO:
		return Direction.NONE

	if abs(dir.x) > abs(dir.y):
		return Direction.RIGHT if dir.x > 0 else Direction.LEFT
	else:
		return Direction.DOWN if dir.y > 0 else Direction.UP

func direction_to_vector(dir: Direction) -> Vector2:
	var translator = {
		Direction.UP: Vector2.UP,
		Direction.DOWN: Vector2.DOWN,
		Direction.LEFT: Vector2.LEFT,
		Direction.RIGHT: Vector2.RIGHT,
		Direction.NONE: Vector2.ZERO
	}
	return translator[dir]

func direction_to_string(dir: Direction) -> String:
	var translator = {
		Direction.UP: "up",
		Direction.DOWN: "down",
		Direction.LEFT: "left",
		Direction.RIGHT: "right",
		Direction.NONE: "none"
	}
	return translator[dir]
