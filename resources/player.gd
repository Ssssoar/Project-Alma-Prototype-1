class_name Player extends Node2D

@export var floor_tile_map: TileMapLayer
@export var sprite_node: Sprite2D
@export var up_sprite_num: int
@export var down_sprite_num: int
@export var left_sprite_num: int
@export var right_sprite_num: int
var current_grid_pos: Vector2i 

func _ready() -> void:
	current_grid_pos = get_current_grid_position()

func _process(_delta: float) -> void:
	movement()

func get_current_grid_position() -> Vector2i:
	var local_pos = floor_tile_map.to_local(global_position)
	return floor_tile_map.local_to_map(local_pos)

func movement():
	var movement_vector = process_input()
	if movement_vector == Vector2i.ZERO: return
	set_sprite(movement_vector)
	if can_move_in_direction(movement_vector):
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

func can_move_in_direction(direction: Vector2i) -> bool:
	var target_grid_pos = current_grid_pos + direction
	var target_tile_data = floor_tile_map.get_cell_tile_data(target_grid_pos)
	if target_tile_data == null: return false
	return target_tile_data.get_custom_data("passable")

func move_in_direction(direction: Vector2i):
	current_grid_pos = current_grid_pos + direction
	var position_as_local_to_map = floor_tile_map.map_to_local(current_grid_pos)
	global_position = floor_tile_map.to_global(position_as_local_to_map)
