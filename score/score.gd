extends CanvasLayer
class_name Score

@onready var label: Label = $PanelContainer/Label

var resources := 0

func _ready() -> void:
	add_to_group("score")
	_update_label()

func add_resource(amount: int = 1) -> void:
	resources += amount
	_update_label()
	var level = get_parent()
	if level.has_method("check_victory"):
		level.check_victory(resources)

func _update_label() -> void:
	label.text = "Resources: %d" % resources
