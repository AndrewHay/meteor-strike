extends RigidBody2D

const EXPLOSION = preload("res://explosion/explosion.tscn")

func _ready() -> void:
	add_to_group("base");

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D and body.is_in_group("meteor"):
		var boom = EXPLOSION.instantiate()
		boom.position = position
		get_parent().add_child(boom)
		Game.instance.game_over()
		queue_free()
