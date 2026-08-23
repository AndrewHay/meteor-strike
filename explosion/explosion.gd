extends Node2D

@export var animation : AnimationPlayer
@export var particles : GPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("BOOM")
	particles.emitting = true
	await animation.animation_finished
	queue_free()
