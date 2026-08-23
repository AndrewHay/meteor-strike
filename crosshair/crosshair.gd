extends Sprite2D

const BULLET = preload("res://bullet/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var b = BULLET.instantiate()
		b.position = position
		get_parent().add_child(b)
	elif event is InputEventMouseMotion:
		# print("Mouse Motion at: ", event.position)
		position = event.position
