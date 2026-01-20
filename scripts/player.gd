class_name Player extends GridEntity

@export var sprite_node: DirectionSpriteSwitcher

func _process(_delta: float) -> void:
	movement()

func movement():
	var movement_vector = get_input()
	if movement_vector == Vector2i.ZERO: return
	sprite_node.set_sprite(movement_vector)
	move_in_direction(movement_vector)

func get_input() -> Vector2i:
	if InputProcessor.up_input == Enums.Button_State.PRESSED:
		return Vector2i.UP
	if InputProcessor.down_input == Enums.Button_State.PRESSED:
		return Vector2i.DOWN
	if InputProcessor.left_input == Enums.Button_State.PRESSED:
		return Vector2i.LEFT
	if InputProcessor.right_input == Enums.Button_State.PRESSED:
		return Vector2i.RIGHT
	return Vector2i.ZERO
