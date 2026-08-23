extends Sprite2D

@export var barrel : Sprite2D

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print("pew")
	elif event is InputEventMouseMotion:
		barrel.rotation = atan2(position.y - event.position.y, position.x - event.position.x)
