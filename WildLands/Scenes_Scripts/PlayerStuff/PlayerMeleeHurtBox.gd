extends Node2D

func _ready():
	get_node("LifeTimer").start()

func _on_life_timer_timeout():
	self.queue_free()
