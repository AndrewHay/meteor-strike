extends Node2D

const SPAWN_BEYOND_MARGIN := 8.0
const METEOR_SPEED := 150.0
const BASE_SPAWN_INTERVAL := 1.0
const DIFFICULTY_INTERVAL := 20.0
const METEOR_RATE_MULTIPLIER := 1.2
const WARNING_DURATION := 3.0

var meteor_scene = preload("res://meteor/meteor.tscn")

var _difficulty_level := 0
var _meteor_timer: Timer
var _difficulty_timer: Timer

func _ready() -> void:
	_meteor_timer = Timer.new()
	_meteor_timer.wait_time = BASE_SPAWN_INTERVAL
	_meteor_timer.autostart = true
	_meteor_timer.timeout.connect(_spawn_meteor)
	add_child(_meteor_timer)

	_difficulty_timer = Timer.new()
	_difficulty_timer.wait_time = DIFFICULTY_INTERVAL
	_difficulty_timer.autostart = true
	_difficulty_timer.timeout.connect(_increase_difficulty)
	add_child(_difficulty_timer)

func stop() -> void:
	_meteor_timer.stop()
	_difficulty_timer.stop()
	for node in get_tree().get_nodes_in_group("meteor"):
		if node is RigidBody2D:
			node.freeze = true
	for node in get_tree().get_nodes_in_group("bullet"):
		if node is RigidBody2D:
			node.freeze = true

func hide_banner() -> void:
	$Banner.hide_banner()

func show_banner(message: String, duration: float = 0.0) -> void:
	$Banner.show_message(message, duration)

func _increase_difficulty() -> void:
	_difficulty_level += 1
	_meteor_timer.wait_time = BASE_SPAWN_INTERVAL / pow(METEOR_RATE_MULTIPLIER, _difficulty_level)
	show_banner("WARNING! Meteors increasing!", WARNING_DURATION)

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
