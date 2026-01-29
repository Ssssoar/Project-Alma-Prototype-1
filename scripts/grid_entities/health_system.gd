class_name Health extends Control

@export var starting_health: float
@export var bar: ProgressBar
var max_health: float
var current_health: float

signal health_depleted()

func _ready() -> void:
	current_health = starting_health
	max_health = starting_health
	update_bar()

func hurt(ammount_lost: float):
	current_health -= ammount_lost
	if current_health <= 0.0:
		health_depleted.emit()
	update_bar()

func heal(ammount_healed: float):
	current_health += ammount_healed
	if current_health > max_health:
		current_health = max_health
	update_bar()

func update_bar():
	bar.max_value = max_health
	bar.min_value = 0
	bar.value = current_health
