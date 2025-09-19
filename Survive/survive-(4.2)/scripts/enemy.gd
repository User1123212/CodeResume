extends CharacterBody3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var direction = Vector3(0,0,0)
var ENEMY_SPEED= 1
var spawn1 = Vector3(20,0,10)
var spawn2 = Vector3(-20,0,-10)
var spawn3 = Vector3(20,0,-10)
var spawnpoint = [spawn1, spawn2, spawn3]

func choose_random(array):
		return spawnpoint[randi() % spawnpoint.size()]


# Called when the node enters the scene tree for the first time.
func _ready():
	self.translate(choose_random(spawnpoint))
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var target = get_parent().PlayerLoc
	var direction_to_target = (target - global_transform.origin).normalized() # We normalize the vector because we only care about the direction
	set_velocity(direction_to_target * ENEMY_SPEED)
	move_and_slide() # We multiply the direction by the speed
	
	
	


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		get_parent().playerhp -= 10
		print(get_parent().playerhp)
		 # Replace with function body.
