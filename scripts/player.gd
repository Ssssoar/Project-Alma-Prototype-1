class_name Player extends GridEntity

@export var sprite_node: Sprite2D
@export var up_sprite_num: int
@export var down_sprite_num: int
@export var left_sprite_num: int
@export var right_sprite_num: int

func _process(_delta: float) -> void:
	movement()

func movement():
	var movement_vector = process_input()
	if movement_vector == Vector2i.ZERO: return
	set_sprite(movement_vector)
	move_in_direction(movement_vector)

func process_input() -> Vector2i:
	if Input.is_action_just_pressed("UP"):
		return Vector2i.UP
	if Input.is_action_just_pressed("DOWN"):
		return Vector2i.DOWN
	if Input.is_action_just_pressed("LEFT"):
		return Vector2i.LEFT
	if Input.is_action_just_pressed("RIGHT"):
		return Vector2i.RIGHT
	return Vector2i.ZERO

func set_sprite(direction: Vector2i):
	match(direction):
		Vector2i.UP:
			sprite_node.frame = up_sprite_num
		Vector2i.DOWN:
			sprite_node.frame = down_sprite_num
		Vector2i.LEFT:
			sprite_node.frame = left_sprite_num
		Vector2i.RIGHT:
			sprite_node.frame = right_sprite_num
