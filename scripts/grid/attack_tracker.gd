class_name GridAttackTracker extends Node

@export var grid: GameGrid
var attack_timers: Dictionary[Attack, Timer]

@export var chatty: bool

func attack_at_position(attack: Attack, attack_position: Vector2):
	var grid_position = grid.get_grid_pos_from_node_pos(attack_position)
	attack_at_grid_position(attack, grid_position)

func attack_at_grid_position(attack: Attack, attack_grid_position: Vector2i):
	attack.grid_position = attack_grid_position ##defined here since this'll be the only module that uses it REMEMBER THAT OTHERWISE WE GOTTA GO AND DEFINE THIS IN THE ATTACK CLASS
	var attacked_entities = grid.entity_tracker.get_entities_at_grid_pos(attack_grid_position)
	for entity: GridEntity in attacked_entities:
		entity.receive_attack(attack.attack_strength, attack.attacker)
	register_attack(attack)

func register_attack(attack: Attack):
	var timer = Timer.new()
	timer.autostart = true
	timer.wait_time = attack.time_active
	attack_timers[attack] = timer
	var bound_unregister_attack = unregister_attack.bind(attack)
	timer.timeout.connect(bound_unregister_attack)
	add_child(timer)
	timer.start()
	if chatty:
		print("[ATTACK_TRACKER]: attack registered at position", attack.grid_position)

func unregister_attack(attack: Attack):
	attack_timers[attack].queue_free()
	attack_timers.erase(attack)
	if chatty:
		print("[ATTACK_TRACKER]: attack de-registered at position", attack.grid_position)


func _on_entity_tracker_entity_movement_registered(entity: GridEntity, new_grid_position: Vector2i) -> void:
	var active_attacks_in_position = get_all_active_attacks_in_grid_position(new_grid_position)
	for attack in active_attacks_in_position:
		entity.receive_attack(attack.attack_strength, attack.attacker)

func get_all_active_attacks_in_grid_position(grid_pos: Vector2i) -> Array[Attack]:
	var retArray: Array[Attack]
	for attack in attack_timers:
		if attack.grid_position == grid_pos:
			retArray.append(attack)
	return retArray
