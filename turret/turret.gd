extends RigidBody2D

const BULLET = preload("res://bullet/bullet.tscn")
const EXPLOSION = preload("res://explosion/explosion.tscn")

@export var spawn_point : Node2D
@export var barrel : Sprite2D

func _get_fire_direction() -> Vector2:
	return (get_global_mouse_position() - barrel.global_position).normalized()

func _input(event: InputEvent) -> void:
	if not Game.instance.playing: return
	if event is InputEventMouseButton and event.is_pressed():
		var direction := _get_fire_direction()
		var b = BULLET.instantiate()
		b.global_position = spawn_point.global_position
		b.global_rotation = spawn_point.global_rotation
		get_parent().add_child(b)
	elif event is InputEventMouseMotion:
		var mouse_local := to_local(get_global_mouse_position()) - barrel.position
		barrel.rotation = mouse_local.angle() + BARREL_VISUAL_OFFSET

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D and body.is_in_group("meteor"):
		var boom = EXPLOSION.instantiate()
		boom.position = position
		get_parent().add_child(boom)
		queue_free()
