class_name Attack extends Node2D

@export var timer: Timer
@export var lifetime: float
@export var attack_strength: float ##exported for default ammount but settable by attacker
var attacker: GridEntity

func _ready() -> void:
	timer.start(lifetime)
	get_tree().call_group("grid","attack_at_position",attack_strength, attacker, position)

func _on_timer_timeout() -> void:
	self.queue_free()
