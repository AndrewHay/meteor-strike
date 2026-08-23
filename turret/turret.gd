extends Sprite2D

const BULLET = preload("res://bullet/bullet.tscn")

@export var barrel : Sprite2D

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var b = BULLET.instantiate()
		b.position = position
		b.rotation = barrel.rotation
		get_parent().add_child(b)
	elif event is InputEventMouseMotion:
		barrel.rotation = atan2(position.y - event.position.y, position.x - event.position.x)
