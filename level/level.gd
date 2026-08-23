extends Node2D

const SPAWN_BEYOND_MARGIN := 8.0
const METEOR_SPEED := 150.0

var meteor_scene = preload("res://meteor/meteor.tscn")

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_spawn_meteor)
	add_child(timer)

func _spawn_meteor() -> void:
	var bases = get_tree().get_nodes_in_group("base")
	if bases.is_empty():
		return

	var meteor = meteor_scene.instantiate()
	add_child(meteor)
	meteor.position = _random_right_position()
	var target = bases.pick_random()
	meteor.linear_velocity = (target.global_position - meteor.global_position).normalized() * METEOR_SPEED

func _random_right_position() -> Vector2:
	var viewport = get_viewport()
	var rect = viewport.get_visible_rect()
	var screen_pos = Vector2(
		rect.end.x + SPAWN_BEYOND_MARGIN,
		randf_range(rect.position.y, rect.end.y)
	)
	var world_pos = viewport.get_canvas_transform().affine_inverse() * screen_pos
	return to_local(world_pos)
