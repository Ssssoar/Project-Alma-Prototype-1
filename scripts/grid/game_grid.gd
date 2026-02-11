class_name GameGrid extends TileMapLayer

@export var entity_tracker: GridEntityTracker
@export var attack_tracker: GridAttackTracker

func instantiate_at_grid_pos(to_instance: PackedScene, grid_spawn_pos: Vector2i) -> Node2D:
	var instantiated = to_instance.instantiate()
	var real_spawn_pos = to_global(map_to_local(grid_spawn_pos))
	instantiated.global_position = real_spawn_pos ##if this fails this isn't a Node2D; so we have bigger issues
	if instantiated is Attack:
		var attack = instantiated as Attack
		var bound_attack_at_grid_position = attack_tracker.attack_at_grid_position.bind(attack, grid_spawn_pos)
		attack.tree_entered.connect(bound_attack_at_grid_position)
	return instantiated

func get_grid_pos_from_node_pos(node_pos: Vector2) -> Vector2i:
	var local_pos = to_local(node_pos)
	return local_to_map(local_pos)

func is_grid_position_blocking_attacks(coords: Vector2i) -> bool:
	var entities_at_pos = entity_tracker.get_entities_at_grid_pos(coords)
	for entity: GridEntity in entities_at_pos:
		if entity.blocks_attacks:
			return true
	if get_cell_source_id(coords) == -1:
		return true
	return false
