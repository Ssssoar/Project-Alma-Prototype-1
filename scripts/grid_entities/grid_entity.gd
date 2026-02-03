class_name GridEntity extends Node2D

@export var floor_tile_map: TileMapLayer
@export_range(0,3) var team: int ##where 0 means no team
@export var has_facing: bool
@export var health_node: Health ##OPTIONAL
@export var blocks_attacks: bool
var current_grid_pos: Vector2i 
var facing: Enums.Facing

signal moved_to_tile(GridEntity,Vector2i)

func _ready() -> void:
	if floor_tile_map is GameGrid:
		current_grid_pos = (floor_tile_map as GameGrid).get_grid_pos_from_node_pos(global_position)
		floor_tile_map.entity_tracker.start_tracking_entity(self)
	else:
		current_grid_pos = set_current_grid_pos_from_transform()
	if has_facing:
		facing = Enums.Facing.DOWN
	else:
		facing = Enums.Facing.NONE

func set_current_grid_pos_from_transform() -> Vector2i: ##kept for insurance but likely won't be necessary
	var local_pos = floor_tile_map.to_local(global_position)
	return floor_tile_map.local_to_map(local_pos)

func can_move_in_vector(vector: Vector2i) -> bool:
	var target_grid_pos = current_grid_pos + vector
	return can_move_to_tile(target_grid_pos)

func can_move_to_tile(tile_pos: Vector2i) -> bool:
	var target_tile_data = floor_tile_map.get_cell_tile_data(tile_pos)
	if target_tile_data == null: return false
	var is_target_tile_passable = target_tile_data.get_custom_data("passable")
	var target_tile_team = target_tile_data.get_custom_data("team")
	var is_target_tile_compatible_team = (target_tile_team == team) || (target_tile_team == 0) || (team == 0)
	return is_target_tile_passable && is_target_tile_compatible_team

func move_in_direction(direction: Vector2i, ignore_impassable_terrain: bool = false):
	var target_position = current_grid_pos + direction
	move_to_pos(target_position, ignore_impassable_terrain)

func move_to_pos(target_grid_position: Vector2i, ignore_impassable_terrain: bool = false):
	if (!ignore_impassable_terrain) && (!can_move_to_tile(target_grid_position)):
		return
	current_grid_pos = target_grid_position
	var position_as_local_to_map = floor_tile_map.map_to_local(current_grid_pos)
	global_position = floor_tile_map.to_global(position_as_local_to_map)
	moved_to_tile.emit(self,target_grid_position)

func set_facing(direction: Vector2i):
	if !has_facing:
		facing = Enums.Facing.NONE
		return
	else:
		match(direction):
			Vector2i.UP:
				facing = Enums.Facing.UP
			Vector2i.DOWN:
				facing = Enums.Facing.DOWN
			Vector2i.LEFT:
				facing = Enums.Facing.LEFT
			Vector2i.RIGHT:
				facing = Enums.Facing.RIGHT
			_:
				facing = Enums.Facing.NONE
				printerr("[GRID ENTITY] invalid direction given to set facing to. Facing defaulted to NONE")

func rotation_from_current_facing() -> float: ##in degrees
	match facing:
		Enums.Facing.UP:
			return -90
		Enums.Facing.DOWN:
			return 90
		Enums.Facing.LEFT:
			return 180
		Enums.Facing.RIGHT:
			return 0
		_:
			printerr("[GRID ENTITY] tried to get a rotation from a NONE facing")
			return -25 ##just to make the error noticeable

func receive_attack(damage_ammount: float, attacker: GridEntity):
	if health_node == null: return
	if attacker.team != team:
		health_node.hurt(damage_ammount)
