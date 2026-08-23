extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("bullet");
	linear_velocity = -Vector2.from_angle(rotation) * 1200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
