class_name DirectionSpriteSwitcher extends Sprite2D

@export var up_sprite_num: int
@export var down_sprite_num: int
@export var left_sprite_num: int
@export var right_sprite_num: int

func set_sprite(direction: Vector2i):
	match(direction):
		Vector2i.UP:
			self.frame = up_sprite_num
		Vector2i.DOWN:
			self.frame = down_sprite_num
		Vector2i.LEFT:
			self.frame = left_sprite_num
		Vector2i.RIGHT:
			self.frame = right_sprite_num
