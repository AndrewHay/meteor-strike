extends StaticBody2D

const BULLET = preload("res://bullet/bullet.tscn")

const BARREL_VISUAL_OFFSET := PI
const MUZZLE_OFFSET := 40.0
const BULLET_SPEED := 1200.0

@export var barrel : Sprite2D

func _get_fire_direction() -> Vector2:
	return (get_global_mouse_position() - barrel.global_position).normalized()

func _input(event: InputEvent) -> void:
	if not Game.instance.playing: return
	if event is InputEventMouseButton and event.is_pressed():
		var direction := _get_fire_direction()
		var b = BULLET.instantiate()
		get_parent().add_child(b)
		b.global_position = barrel.global_position + direction * MUZZLE_OFFSET
		b.global_rotation = direction.angle()
		b.linear_velocity = direction * BULLET_SPEED
	elif event is InputEventMouseMotion:
		var mouse_local := to_local(get_global_mouse_position()) - barrel.position
		barrel.rotation = mouse_local.angle() + BARREL_VISUAL_OFFSET
