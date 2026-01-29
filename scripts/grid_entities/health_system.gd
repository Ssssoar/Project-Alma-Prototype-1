class_name Health extends Node

@export var starting_health: float
var max_health: float
var current_health: float

signal health_depleted()

func _ready() -> void:
	current_health = starting_health
	max_health = starting_health

func hurt(ammount_lost: float):
	current_health -= ammount_lost
	if current_health <= 0.0:
		health_depleted.emit()

func heal(ammount_healed: float):
	current_health += ammount_healed
	if current_health > max_health:
		current_health = max_health
