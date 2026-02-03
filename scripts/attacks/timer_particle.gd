class_name TimerParticle extends Node2D

@export var timer: Timer

func ready(): 
	timer.timeout.connect(self.queue_free)
