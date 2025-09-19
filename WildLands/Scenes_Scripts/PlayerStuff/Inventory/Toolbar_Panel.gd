extends TextureRect


var active_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#Connects inventory slot signals 
	for button in get_child(0).get_children():
		button.clicked.connect(_on_clicked.bind(button.get_index()))
	InventoryData.connect("update_inventory", update_display)

#Inventory functionality
func _on_clicked(index:int):
	var clicked_item = InventoryData.toolbar_data[index]
	if InventoryData.toolbar_data[index] != null and InventoryData.stored_item == null:
		InventoryData.store_item(InventoryData.toolbar_data, clicked_item, index)
		InventoryData.remove_item(InventoryData.toolbar_data, index)
		
	elif InventoryData.toolbar_data[index] == null and InventoryData.stored_item != null:
		InventoryData.add_item(InventoryData.toolbar_data, index, InventoryData.stored_item)
		InventoryData.store_item([], null, 0)
		
	elif InventoryData.toolbar_data[index] != null and InventoryData.stored_item != null:
		InventoryData.swap_items(InventoryData.stored_list, InventoryData.stored_item, InventoryData.stored_index, InventoryData.toolbar_data, InventoryData.toolbar_data[index], index)
		InventoryData.store_item([], null, 0)
		
		
		
func update_display():
	for child in get_node("GridContainer").get_children():
		child.update_ui()



#Toolbar Functionality
func _process(_delta):
	if Input.is_action_just_pressed("scroll_up"):
		active_index += 1
		if active_index > 6:
			active_index = 0
		InventoryData.active_index = active_index
		InventoryData.active_slot = InventoryData.toolbar_data[active_index]
		update_display()
	if Input.is_action_just_pressed("scroll_down"):
		active_index -= 1
		if active_index < 0:
			active_index = 6
		InventoryData.active_index = active_index
		InventoryData.active_slot = InventoryData.toolbar_data[active_index]
		update_display()
