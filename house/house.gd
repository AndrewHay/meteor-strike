extends RigidBody2D

func _ready() -> void:
	add_to_group("house");
	body_entered.connect(_on_body_entered);

func _on_body_entered(body):
	print("house has hit a body");
