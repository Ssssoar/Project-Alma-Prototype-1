extends Node
##This script's function is only to process controller inputs and store them as relevant variables
var p1_input : Dictionary
var p2_input : Dictionary

func _physics_process(_delta: float) -> void:
	p1_input = {
		vector = Input.get_vector("P1LEFT", "P1RIGHT", "P1UP", "P1DOWN"),
		up = button_state("P1UP"),
		down = button_state("P1DOWN"),
		left = button_state("P1LEFT"),
		right = button_state("P1RIGHT"),
	}
	p2_input = {
		vector = Input.get_vector("P2LEFT", "P2RIGHT", "P2UP", "P2DOWN"),
		up = button_state("P2UP"),
		down = button_state("P2DOWN"),
		left = button_state("P2LEFT"),
		right = button_state("P2RIGHT"),
	}

func button_state(action_name: String) -> Enums.Button_State:
	if (Input.is_action_just_pressed(action_name)):
		return Enums.Button_State.PRESSED
	elif(Input.is_action_just_released(action_name)):
		return Enums.Button_State.RELEASED
	elif(Input.is_action_pressed(action_name)):
		return Enums.Button_State.HELD
	else:
		return Enums.Button_State.OFF
