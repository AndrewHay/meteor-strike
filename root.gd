extends Node2D
class_name Game

static var instance : Game

var playing = true

const GAME_OVER_MESSAGE := "SHIP DESTROYED\nALL LIVES LOST\nTHE END OF HUMANITY"

func _enter_tree() -> void:
	instance = self

func _exit_tree() -> void:
	instance = null

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func game_over() -> void:
	playing = false
	$Level.show_banner(GAME_OVER_MESSAGE)

func game_victory() -> void:
	playing = false
	$Level.show_banner("SUCCESS")
