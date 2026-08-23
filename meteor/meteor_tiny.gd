extends RigidBody2D

func _ready() -> void:
	add_to_group("resource")
	body_entered.connect(_on_body_entered);
	angular_velocity += randf_range(-4.0, 4.0);
	linear_velocity += position

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		if body.is_in_group("bullet"):
			body.queue_free()
			queue_free()
