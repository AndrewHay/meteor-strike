extends RigidBody2D

const METEOR_TINY = preload("res://meteor/meteor_tiny.tscn")

func _ready() -> void:
	add_to_group("meteor");
	body_entered.connect(_on_body_entered);
	angular_velocity = randf_range(-4.0, 4.0);

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		if body.is_in_group("bullet"):
			body.queue_free()
			var t : Node2D = METEOR_TINY.instantiate()
			t.position = position
			for c in t.get_children():
				c.linear_velocity = linear_velocity
				c.angular_velocity = angular_velocity
				get_parent().add_child(t)
			queue_free()
