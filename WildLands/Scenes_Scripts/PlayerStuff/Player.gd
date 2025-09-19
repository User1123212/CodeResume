extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func get_input():
	#Read directional input for movement
	var input_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * SPEED
	
	
	#Show inventory
	if Input.is_action_just_pressed("Inventory") and get_node("Camera2D/InventoryPanel").visible == false:
		get_node("Camera2D/InventoryPanel").visible = true
	elif Input.is_action_just_pressed("Inventory") and get_node("Camera2D/InventoryPanel").visible == true:
		get_node("Camera2D/InventoryPanel").visible = false
		
	#Click
	if Input.is_action_just_pressed("Action") and get_node("Camera2D/InventoryPanel").visible == false:
		var active_item = InventoryData.active_slot
		if active_item is Item:
			InventoryData.active_slot.item_script.use(self,get_local_mouse_position())

func _physics_process(delta):
	get_input()
	move_and_slide()
	

