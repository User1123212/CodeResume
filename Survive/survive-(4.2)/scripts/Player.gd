extends CharacterBody3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 7
const ACCEL_DEFAULT = 7
const ACCEL_AIR = 1
@onready var accel = ACCEL_DEFAULT
var gravity = 9.8
var jump = 5

var cam_accel = 40
var mouse_sense = 0.1
var snap

var direction = Vector3()
var velocity = Vector3()
var gravity_direction = Vector3()
var movement = Vector3()

var Ammo = 8


@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var raycast = get_node("Head/Camera3D/RayCast3D")



func fire_bullet():
	var gun = get_node("Head/Camera3D/Weaponslot").get_child(0)
	print(raycast.get_collision_point())
	if raycast.is_colliding():
		var obj = raycast.get_collider()
		if obj.is_in_group("enemy"):
			print("hit")
			obj.free()
	gun.get_node("AnimationPlayer").play("Shooting")
	#get_node("Head/Camera/Weaponslot/M1911_V1/AnimationPlayer").play("Shooting")
	Ammo -= 1
	print(Ammo)
	

func _on_Delay_timeout():
	Ammo = 8
	print("reloaded")
		
		
	

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Replace with function body.
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89),deg_to_rad(89))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.get_frames_per_second() > Engine.physics_ticks_per_second:
		camera.set_as_top_level(true)
		camera.global_transform.origin = camera.global_transform.origin.lerp(head.global_transform.origin, cam_accel*delta)
		camera.rotation.y = rotation.y
		camera.rotation.x = head.rotation.x
	else:
		camera.set_as_top_level(false)
		camera.global_transform = head.global_transform
		
		
		
		
	if Input.is_action_pressed("fire"):
		var gun = get_node("Head/Camera3D/Weaponslot").get_child(0)
		if Ammo == 0 and get_node("Delay").time_left ==0:
			get_node("Delay").set_wait_time(4)
			get_node("Delay").start()
			gun.get_node("AnimationPlayer").play("Reload")
		if Ammo > 0 and get_node("Delay").time_left == 0 and gun.get_node("AttackSpeed").time_left == 0:
			fire_bullet()
			
		else:
			print("reloading")
			
			
			
			
	
		
		
		
func _physics_process(delta):
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	
	if is_on_floor():
		snap = -get_floor_normal()
		accel = ACCEL_DEFAULT
		gravity_direction = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		accel = ACCEL_AIR
		gravity_direction += Vector3.DOWN * gravity * delta
		
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap = Vector3.ZERO
		gravity_direction = Vector3.UP * jump
		
	velocity = velocity.lerp(direction * speed, accel * delta)
	movement = velocity + gravity_direction
	
	set_velocity(movement)
	# TODOConverter40 looks that snap in Godot 4.0 is float, not vector like in Godot 3 - previous value `snap`
	set_up_direction(Vector3.UP)
	move_and_slide()
	
	
	if get_parent().playerhp <= 0:
		var gameover = load("res://scenes/GameOver.tscn")
		get_tree().change_scene_to_packed(gameover)
		self.free()
		
		


