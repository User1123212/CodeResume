extends Node


static func use(Player,mouse_position):
	var hurtbox = load("res://Scenes_Scripts/PlayerStuff/PlayerMeleeHurtBox.tscn").instantiate()
	hurtbox.look_at(mouse_position)
	Player.add_child(hurtbox)
	
