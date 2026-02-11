class_name GridEntityTracker extends Node

@export var grid_spaces: GameGrid
@export var chatty: bool

var entity_positions: Dictionary[GridEntity, Vector2i]

signal entity_movement_registered(entity: GridEntity, new_position: Vector2i)

func get_entities_at_grid_pos(grid_pos: Vector2i) -> Array[GridEntity]:
	var ret: Array[GridEntity]
	for entity in entity_positions:
		var position = entity_positions[entity]
		if position == grid_pos:
			ret.append(entity)
	return ret
		

func start_tracking_entity(entity: GridEntity):
	entity.moved_to_tile.connect(on_entity_moved)
	entity_positions[entity] = entity.current_grid_pos
	change_tile_to_team(entity.current_grid_pos, entity.team)

func on_entity_moved(entity: GridEntity,grid_position: Vector2i):
	if entity_positions[entity] == null:
		if chatty:
			printerr("[GRID ENTITY TRACKER] received entity notification of an untracked entity")
		return
	var abandoned_position = entity_positions[entity]
	var position_left_empty = true
	for entity_to_check in entity_positions:
		if (entity_to_check != entity) && (entity_positions[entity_to_check] == abandoned_position):
			position_left_empty = false
	if position_left_empty:
		change_tile_to_team(abandoned_position,0)
	change_tile_to_team(grid_position,entity.team)
	entity_positions[entity] = grid_position
	entity_movement_registered.emit(entity, grid_position)

func change_tile_to_team(coords: Vector2i, team: int):
	var atlas_coords: Vector2i
	match team:
		0:
			atlas_coords = Vector2i(0,0)
		1:
			atlas_coords = Vector2i(1,0)
		2:
			atlas_coords = Vector2i(0,1)
		3:
			atlas_coords = Vector2i(1,1)
	grid_spaces.set_cell(coords,0,atlas_coords,0)
