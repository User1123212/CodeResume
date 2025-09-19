extends TextureRect




# Called when the node enters the scene tree for the first time.
func _ready():
	#Connects inventory slot signals 
	for button in get_child(0).get_children():
		button.clicked.connect(_on_clicked.bind(button.get_index()))
	InventoryData.connect("update_inventory", update_display)



# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_clicked(index:int):
	#This needs to utilize the inventory built in methods
	var clicked_item = InventoryData.inventory_data[index]
	if InventoryData.inventory_data[index] != null and InventoryData.stored_item == null:
		InventoryData.store_item(InventoryData.inventory_data, clicked_item, index)
		InventoryData.remove_item(InventoryData.inventory_data, index)
		
	elif InventoryData.inventory_data[index] == null and InventoryData.stored_item != null:
		InventoryData.add_item(InventoryData.inventory_data, index, InventoryData.stored_item)
		InventoryData.store_item([], null, 0)
		
	elif InventoryData.inventory_data[index] != null and InventoryData.stored_item != null:
		InventoryData.swap_items(InventoryData.stored_list, InventoryData.stored_item, InventoryData.stored_index, InventoryData.inventory_data, InventoryData.inventory_data[index], index)
		InventoryData.store_item([], null, 0)
		
func update_display():
	for child in get_node("GridContainer").get_children():
		child.update_ui()
