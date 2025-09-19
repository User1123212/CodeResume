extends Node3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PistolButton_pressed():
	if get_node("M1911_V1") != null:
		pass
	else:
		var Pistol = load("res://scenes/M1911_V1.tscn").instantiate()
		for child in self.get_children():
			child.queue_free()
		add_child(Pistol)




func _on_RifleButton_pressed():
	if get_node("AK47") != null:
		pass
	else:
		var AK47 = load("res://scenes/AK47.tscn").instantiate()
		for child in self.get_children():
			child.queue_free()
		add_child(AK47)
