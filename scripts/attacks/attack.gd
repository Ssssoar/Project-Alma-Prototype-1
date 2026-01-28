class_name Attack extends Node2D

@export var timer: Timer
@export var lifetime: float

func _ready() -> void:
	timer.start(lifetime)

func _on_timer_timeout() -> void:
	self.queue_free()
