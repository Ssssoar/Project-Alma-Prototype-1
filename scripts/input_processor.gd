extends Node
##This script's function is only to process controller inputs and store them as relevant variables
var directional_input : Vector2
var up_input : Enums.Button_State
var down_input : Enums.Button_State
var left_input : Enums.Button_State
var right_input : Enums.Button_State

func _physics_process(_delta: float) -> void:
	#record the right state for directional movement
	directional_input = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	#record the right state for input
	up_input = button_state("UP")
	down_input = button_state("DOWN")
	left_input = button_state("LEFT")
	right_input = button_state("RIGHT")

func button_state(action_name: String) -> Enums.Button_State:
	if (Input.is_action_just_pressed(action_name)):
		return Enums.Button_State.PRESSED
	elif(Input.is_action_just_released(action_name)):
		return Enums.Button_State.RELEASED
	elif(Input.is_action_pressed(action_name)):
		return Enums.Button_State.HELD
	else:
		return Enums.Button_State.OFF
