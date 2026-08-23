extends Node2D

const SPAWN_ABOVE_MARGIN := 48.0

var meteor_scene = preload("res://meteor/meteor.tscn")

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_spawn_meteor)
	add_child(timer)

func _spawn_meteor() -> void:
	var meteor = meteor_scene.instantiate()
	meteor.position = _random_top_position()
	add_child(meteor)

func _random_top_position() -> Vector2:
	var camera = get_viewport().get_camera_2d()
	var viewport_size = get_viewport().get_visible_rect().size
	var half_size = viewport_size / 2 / camera.zoom
	var top_left = camera.get_screen_center_position() - half_size
	var world_pos = Vector2(
		randf_range(top_left.x, top_left.x + viewport_size.x / camera.zoom.x),
		top_left.y - SPAWN_ABOVE_MARGIN
	)
	return to_local(world_pos)
