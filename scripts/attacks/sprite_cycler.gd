class_name AttackSpriteCycler extends Node

@export var total_sprites_list: Array[int]
@export var starting_sprites_list: Array[int]
@export var sprite_nodes: Array[Sprite2D]
@export var timer: Timer

func _process(_delta: float) -> void:
	var starting_sprites_iterator = 0
	var total_sprites_iterator = 0
	for sprite_node in sprite_nodes:
		set_sprite_node(sprite_node, starting_sprites_list[starting_sprites_iterator], total_sprites_list[total_sprites_iterator])
		starting_sprites_iterator += 1
		total_sprites_iterator += 1
		if starting_sprites_iterator == starting_sprites_list.size():
			starting_sprites_iterator = 0
		if total_sprites_iterator == total_sprites_list.size():
			total_sprites_iterator = 0

func set_sprite_node(sprite_node: Sprite2D, starting_sprite: int, total_sprites: int):
	var time_between_frames = timer.wait_time / total_sprites
	var animation_frame_to_draw = ((timer.wait_time - timer.time_left)/time_between_frames) as int
	sprite_node.frame = starting_sprite + animation_frame_to_draw
