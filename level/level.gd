extends Node2D

const SPAWN_ABOVE_MARGIN := 48.0
const METEOR_SPEED := 150.0

var meteor_scene = preload("res://meteor/meteor.tscn")

@onready var background: Sprite2D = $Parallax2D/Sprite2D
@onready var parallax: Parallax2D = $Parallax2D

func _ready() -> void:
	get_viewport().size_changed.connect(_center_background)
	_center_background()

	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_spawn_meteor)
	add_child(timer)

func _center_background() -> void:
	var camera = get_viewport().get_camera_2d()
	if camera == null or background.texture == null:
		return

	var viewport_size = get_viewport().get_visible_rect().size
	var visible_size = viewport_size / camera.zoom
	var texture_size = background.texture.get_size()
	var scale_factor = maxf(visible_size.x / texture_size.x, visible_size.y / texture_size.y)

	background.scale = Vector2(scale_factor, scale_factor)
	background.position = parallax.to_local(camera.get_screen_center_position())

func _spawn_meteor() -> void:
	var houses = get_tree().get_nodes_in_group("house")
	if houses.is_empty():
		return

	var meteor = meteor_scene.instantiate()
	meteor.position = _random_top_position()
	var target = houses.pick_random()
	meteor.linear_velocity = (target.position - meteor.position).normalized() * METEOR_SPEED
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
