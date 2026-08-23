extends CanvasLayer

@onready var start_button: Button = $CenterContainer/PanelContainer/VBoxContainer/StartButton

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func update_start_button(can_resume: bool) -> void:
	start_button.text = "Resume" if can_resume else "Start"

func _on_start_pressed() -> void:
	if Game.instance.can_resume():
		Game.instance.resume_game()
	else:
		Game.instance.start_game()

func _on_settings_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
