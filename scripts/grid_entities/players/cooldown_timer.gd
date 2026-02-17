class_name CooldownTimer extends Timer

@export var cooldown_time: float
@export var chatty: bool
var on_cooldown: bool
var multiplier: float

signal cooldown_started()
signal cooldown_ended()

func _ready() -> void:
	on_cooldown = false
	multiplier = 1

func start_cooldown():
	if chatty: 
		print("[COOLDOWN TIMER] began cooldown")
	start(cooldown_time * multiplier)
	on_cooldown = true
	cooldown_started.emit()

func _on_timeout() -> void:
	if !on_cooldown: return
	if chatty:
		print("[COOLDOWN TIMER] ended cooldown")
	on_cooldown = false
	cooldown_ended.emit()
