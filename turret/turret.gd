extends Sprite2D

const BULLET = preload("res://bullet/bullet.tscn")

@export var barrel : Sprite2D

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if not Game.instance.playing: return
	if event is InputEventMouseButton and event.is_pressed():
		var b = BULLET.instantiate()
		b.global_position = barrel.global_position
		b.global_rotation = barrel.global_rotation
		get_parent().add_child(b)
	elif event is InputEventMouseMotion:
		var mouse_local := to_local(get_global_mouse_position()) - barrel.position
		barrel.rotation = (-mouse_local).angle()
