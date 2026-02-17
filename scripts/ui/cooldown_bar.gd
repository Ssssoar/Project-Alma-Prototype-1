class_name CooldownBar extends TextureProgressBar

@export var timer: CooldownTimer
var updating: bool

func _ready() -> void:
	hide()
	updating = false

func _process(_delta: float) -> void:
	if !updating: return
	max_value = timer.wait_time
	value = max_value - timer.time_left

func _on_cooldown_timer_cooldown_started() -> void:
	show()
	updating = true

func _on_cooldown_timer_cooldown_ended() -> void:
	hide()
	updating = false
