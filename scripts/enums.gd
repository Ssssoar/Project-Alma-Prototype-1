extends Node

enum Button_State {PRESSED, HELD, RELEASED, OFF} 
#as in, pressed this frame, held, released this frame, not being pressed
enum Player_Actions {MELEE, RANGED, BLOCK, FLEX}

enum Facing {UP,DOWN,LEFT,RIGHT,NONE}

func facing_to_vector2i(facing: Facing) -> Vector2i:
	match facing:
		Facing.UP:
			return Vector2i.UP
		Facing.DOWN:
			return Vector2i.DOWN
		Facing.LEFT:
			return Vector2i.LEFT
		Facing.RIGHT:
			return Vector2i.RIGHT
		_:
			return Vector2i.ZERO

func vector2i_to_facing(vector: Vector2i) -> Facing:
	match vector:
		Vector2i.UP:
			return Facing.UP
		Vector2i.DOWN:
			return Facing.DOWN
		Vector2i.LEFT:
			return Facing.LEFT
		Vector2i.RIGHT:
			return Facing.RIGHT
		_:
			return Facing.NONE

func clockwise_turn(facing: Facing) -> Facing:
	match facing:
		Facing.UP:
			return Facing.RIGHT
		Facing.DOWN:
			return Facing.LEFT
		Facing.LEFT:
			return Facing.UP
		Facing.RIGHT:
			return Facing.DOWN
		_:
			return Facing.NONE

func counterclockwise_turn(facing: Facing) -> Facing:
	match facing:
		Facing.UP:
			return Facing.LEFT
		Facing.DOWN:
			return Facing.RIGHT
		Facing.LEFT:
			return Facing.DOWN
		Facing.RIGHT:
			return Facing.UP
		_:
			return Facing.NONE
