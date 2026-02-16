class_name CooldownTimer extends Timer

@export var cooldown_time: float
@export var chatty: bool
var on_cooldown: bool
var multiplier: float

func _ready() -> void:
	on_cooldown = false
	multiplier = 1

func start_cooldown():
	if chatty: 
		print("[COOLDOWN TIMER] began cooldown")
	start(cooldown_time * multiplier)
	on_cooldown = true

func _on_timeout() -> void:
	if chatty:
		print("[COOLDOWN TIMER] ended cooldown")
	on_cooldown = false
