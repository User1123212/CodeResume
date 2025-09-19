extends Node3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Character = preload("res://scenes/Character.tscn").instantiate()


@export (PackedScene) var enemy_scene

var playerhp = 100


#Global Variables
var PlayerHP = 100
var PlayerLoc = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_child(Character)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	PlayerLoc = get_node("Player").global_position


func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = enemy_scene.instantiate()
	
	
	add_child(mob)
