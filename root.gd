extends Node2D
class_name Game

static var instance : Game
@export var ui : UI

var playing = true

func _enter_tree() -> void:
	instance = self

func _exit_tree() -> void:
	instance = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func game_over():
	playing = false
	print("Game over")
	ui.game_over()
