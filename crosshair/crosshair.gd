extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		pass
	elif event is InputEventMouseMotion:
		# print("Mouse Motion at: ", event.position)
		position = event.position
