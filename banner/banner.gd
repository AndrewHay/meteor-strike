extends CanvasLayer
class_name Banner

@onready var label: Label = $BannerPanel/Label
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(hide_banner)
	hide_banner()

func show_message(message: String, duration: float = 0.0) -> void:
	label.text = message
	$BannerPanel.visible = true
	timer.stop()
	if duration > 0.0:
		timer.start(duration)

func hide_banner() -> void:
	$BannerPanel.visible = false
