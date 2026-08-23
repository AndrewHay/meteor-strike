extends Sprite2D

func _input(event: InputEvent) -> void:
	if not Game.instance.playing: return
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
