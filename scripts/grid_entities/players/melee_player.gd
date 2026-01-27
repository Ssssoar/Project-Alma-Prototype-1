class_name MeleePlayer extends Player

@export var attack_scene: PackedScene

func handle_action_input(input: Enums.Button_State):
	if input == Enums.Button_State.PRESSED:
		execute_attack()

func execute_attack():
	var slots = get_affected_slots_from_facing(facing)
	for slot in slots:
		print("[MELEE PLAYER] spawning attack instance")
		(floor_tile_map as GameGrid).spawn_at_grid_pos(attack_scene, slot)
	##debug
	if chatty:
		print("[MELEE PLAYER] Executed melee attack")
	pass

func get_affected_slots_from_facing(effective_facing: Enums.Facing) -> Array:
	print(effective_facing)
	if effective_facing == Enums.Facing.NONE:
		printerr("[MELEE PLAYER] Tried to attack but there's no facing")
		return []
	var direction_vector = Enums.facing_to_vector2i(effective_facing)
	var attack_spots: Array[Vector2i]
	##TODO make a standardized way to create attack shapes without them being hardcoded
	attack_spots.append(current_grid_pos + direction_vector)
	attack_spots.append(attack_spots[0] + Enums.facing_to_vector2i(Enums.clockwise_turn(effective_facing)))
	attack_spots.append(attack_spots[0] + Enums.facing_to_vector2i(Enums.counterclockwise_turn(effective_facing)))
	return attack_spots
