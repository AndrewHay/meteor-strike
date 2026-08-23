extends RigidBody2D

func _ready() -> void:
	add_to_group("base");

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D and body.is_in_group("meteor"):
		print("BOOM")
		Game.instance.game_over()
		queue_free()
