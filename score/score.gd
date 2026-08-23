extends CanvasLayer
class_name Score

@onready var label: Label = $PanelContainer/Label
@onready var warning_label: Label = $WarningPanel/WarningLabel
@onready var warning_timer: Timer = $WarningTimer

var resources := 0

func _ready() -> void:
	add_to_group("score")
	warning_timer.timeout.connect(_hide_warning)
	_update_label()

func add_resource(amount: int = 1) -> void:
	resources += amount
	_update_label()

func show_warning(message: String, duration: float = 3.0) -> void:
	warning_label.text = message
	$WarningPanel.visible = true
	warning_timer.start(duration)

func _hide_warning() -> void:
	$WarningPanel.visible = false

func _update_label() -> void:
	label.text = "Resources: %d" % resources
