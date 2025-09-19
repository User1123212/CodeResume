extends Panel

signal clicked

var base_texture = preload("res://Assets/InvSlot.png")

# Called when the node enters the scene tree for the first time.



func _gui_input(event):
	if event.is_pressed() and event is InputEventMouseButton:
		emit_signal("clicked")


func update_ui():
	var held_item = InventoryData.inventory_data[self.get_index()]
	if held_item is Item:
		get_node("TextureRect").texture = held_item.item_sprite
	else:
		get_node("TextureRect").texture = base_texture
