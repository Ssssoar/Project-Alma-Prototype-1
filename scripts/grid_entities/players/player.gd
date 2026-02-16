class_name Player extends GridEntity

@export_range(1,2) var player_number: int
@export var sprite_node: DirectionSpriteSwitcher
@export var chatty: bool
@export var cooldown_node: CooldownTimer

func _process(_delta: float) -> void:
	if !cooldown_node.on_cooldown:
		var input_map = get_input()
		var movement_vector = movement_vector_from_input_map(input_map)
		handle_movement_input(movement_vector)
		handle_action_input(input_map.action)

func get_input() -> Dictionary: ##determines which input map to return depending on the player being assigned
	##copy input dictionary from InputProcessor
	var input_dict: Dictionary
	if player_number == 1:
		input_dict = InputProcessor.p1_input
	else:
		input_dict = InputProcessor.p2_input
	return input_dict

func handle_action_input(input: Enums.Button_State): ##to be overridden in derived classes
	if input == Enums.Button_State.PRESSED:
		if chatty:
			print("[PLAYER] Executed generic base class action.")
		cooldown_node.start_cooldown()

func handle_movement_input(vector: Vector2i):
	if vector != Vector2i.ZERO:
		move_in_direction(vector) ##base class function
		sprite_node.set_sprite(vector)
		set_facing(vector)

func movement_vector_from_input_map(input_map: Dictionary) -> Vector2i:
	##actually fetch relevant input
	if input_map.up == Enums.Button_State.PRESSED:
		return Vector2i.UP
	if input_map.down == Enums.Button_State.PRESSED:
		return Vector2i.DOWN
	if input_map.left == Enums.Button_State.PRESSED:
		return Vector2i.LEFT
	if input_map.right == Enums.Button_State.PRESSED:
		return Vector2i.RIGHT
	return Vector2i.ZERO
