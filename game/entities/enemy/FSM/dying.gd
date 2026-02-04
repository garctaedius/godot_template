extends EnemyTreeState

func enter():
	print("ENEMY DYING")
	enemy.queue_free()
