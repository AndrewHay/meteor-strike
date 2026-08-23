extends RigidBody2D

func _ready() -> void:
	add_to_group("meteor");
	body_entered.connect(_on_body_entered);

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		if body.is_in_group("bullet"):
			print("meteor gone bye bye")
			body.queue_free()
			queue_free()
		if body.is_in_group("house"):
			body.queue_free()
			print("house gone bye bye");
