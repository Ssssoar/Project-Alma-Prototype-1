class_name GridEntity extends Node2D

@export var floor_tile_map: TileMapLayer
@export_range(0,3) var team: int ##where 0 means no team
var current_grid_pos: Vector2i 

signal moved_to_tile(GridEntity,Vector2i)

func _ready() -> void:
	current_grid_pos = set_current_grid_pos_from_transform()
	if floor_tile_map is GridEntityTracker:
		floor_tile_map.start_tracking_entity(self)

func set_current_grid_pos_from_transform() -> Vector2i:
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
