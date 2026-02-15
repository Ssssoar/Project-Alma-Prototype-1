class_name TimerParticle extends Node2D

@export var timer: Timer
@export var lifetime: float

func _ready(): 
	timer.start(lifetime)
	timer.timeout.connect(self.queue_free)
