extends Node2D
class_name Game

static var instance : Game

const LEVEL_SCENE := preload("res://level/level.tscn")
const GAME_OVER_MESSAGE := "SHIP DESTROYED\nALL LIVES LOST\nTHE END OF HUMANITY"
const GAME_OVER_DURATION := 6.0
const VICTORY_DURATION := 6.0

var playing := false
var _level: Node2D
var _game_over := false
var _victory := false

func _enter_tree() -> void:
	instance = self
	process_mode = Node.PROCESS_MODE_ALWAYS

func _exit_tree() -> void:
	instance = null

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	$Crosshair.visible = false
	$Menu.update_start_button(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		handle_escape()

func handle_escape() -> void:
	if $Menu.visible:
		if can_resume():
			resume_game()
	else:
		show_menu()

func show_menu() -> void:
	$Menu.update_start_button(can_resume())
	$Menu.visible = true
	$Crosshair.visible = false
	playing = false
	get_tree().paused = true
	if _level:
		_level.hide_banner()

func resume_game() -> void:
	$Menu.visible = false
	$Crosshair.visible = true
	playing = true
	get_tree().paused = false

func start_game() -> void:
	if _level:
		_level.queue_free()
		_level = null

	_level = LEVEL_SCENE.instantiate()
	add_child(_level)
	move_child(_level, 0)
	_game_over = false
	_victory = false
	resume_game()

func victory(message: String) -> void:
	if _victory or _game_over:
		return
	playing = false
	_victory = true
	$Crosshair.visible = false
	if _level:
		_level.stop()
		_level.show_banner(message)
	get_tree().paused = true
	await get_tree().create_timer(VICTORY_DURATION).timeout
	if _level:
		_level.hide_banner()
	show_menu()

func game_over() -> void:
	playing = false
	_game_over = true
	$Crosshair.visible = false
	if _level:
		_level.stop()
		_level.show_banner(GAME_OVER_MESSAGE)
	get_tree().paused = true
	await get_tree().create_timer(GAME_OVER_DURATION).timeout
	if _level:
		_level.hide_banner()
	show_menu()

func can_resume() -> bool:
	return _level != null and not _game_over and not _victory
