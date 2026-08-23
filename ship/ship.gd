extends Node2D

func _ready() -> void:
	add_to_group("ship")
	$Hitbox.body_entered.connect(_on_hitbox_body_entered)

func _on_hitbox_body_entered(body: Node) -> void:
	if body.is_in_group("resource"):
		print("gathered resource")
		body.queue_free()
