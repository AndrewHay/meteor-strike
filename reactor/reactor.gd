extends RigidBody2D

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		print("BOOM")
		Game.instance.game_over()
		queue_free()
