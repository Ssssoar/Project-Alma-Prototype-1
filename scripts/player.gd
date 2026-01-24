class_name Player extends GridEntity

@export_range(1,2) var player_number: int
@export var sprite_node: DirectionSpriteSwitcher

func _process(_delta: float) -> void:
	movement()

func movement():
	var movement_vector = get_input()
	if movement_vector == Vector2i.ZERO: return
	sprite_node.set_sprite(movement_vector)
	move_in_direction(movement_vector)

func get_input() -> Vector2i:
	##copy input dictionary from InputProcessor
	var input_dict: Dictionary
	if player_number == 1:
		input_dict = InputProcessor.p1_input
	else:
		input_dict = InputProcessor.p2_input
	##actually fetch relevant input
	if input_dict.up == Enums.Button_State.PRESSED:
		return Vector2i.UP
	if input_dict.down == Enums.Button_State.PRESSED:
		return Vector2i.DOWN
	if input_dict.left == Enums.Button_State.PRESSED:
		return Vector2i.LEFT
	if input_dict.right == Enums.Button_State.PRESSED:
		return Vector2i.RIGHT
	return Vector2i.ZERO
