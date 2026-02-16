class_name RangedPlayer extends Player

@export var attack_scene: PackedScene
@export var attack_strength: float

func handle_action_input(input: Enums.Button_State):
	super(input)
	if input == Enums.Button_State.PRESSED:
		execute_attack()

func execute_attack():
	var slots = get_affected_slots_from_facing(facing)
	for slot in slots:
		if chatty:
			print("[RANGED PLAYER] spawning attack instance")
		var attack = (floor_tile_map as GameGrid).instantiate_at_grid_pos(attack_scene, slot) as Attack
		attack.attacker = self
		attack.attack_strength = attack_strength
		attack.rotation_degrees = rotation_from_current_facing()
		get_tree().get_root().add_child(attack)
	##debug
	if chatty:
		print("[RANGED PLAYER] Executed melee attack")
	pass

func get_affected_slots_from_facing(effective_facing: Enums.Facing) -> Array:
	if effective_facing == Enums.Facing.NONE:
		printerr("[RANGED PLAYER] Tried to attack but there's no facing")
		return []
	var direction_vector = Enums.facing_to_vector2i(effective_facing)
	var attack_spots: Array[Vector2i]
	##TODO make a standardized way to create attack shapes without them being hardcoded
	var last_position_found = current_grid_pos + direction_vector
	while true:
		attack_spots.append(last_position_found)
		if floor_tile_map.is_grid_position_blocking_attacks(last_position_found):
			break
		last_position_found = last_position_found + direction_vector
	return attack_spots
