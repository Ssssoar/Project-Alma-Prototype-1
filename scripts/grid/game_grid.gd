class_name GameGrid extends TileMapLayer

@export var entity_tracker: GridEntityTracker

func spawn_at_grid_pos(to_spawn: PackedScene, grid_spawn_pos: Vector2i):
	var instantiated = to_spawn.instantiate()
	var real_spawn_pos = to_global(map_to_local(grid_spawn_pos))
	instantiated.global_position = real_spawn_pos ##if this fails this isn't a Node2D; so we have bigger issues
	get_tree().get_root().add_child(instantiated)
