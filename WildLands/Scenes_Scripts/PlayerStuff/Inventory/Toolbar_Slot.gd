extends Panel

signal clicked

var base_texture = preload("res://Assets/InvSlot.png")



func _gui_input(event):
	if event.is_pressed() and event is InputEventMouseButton:
		emit_signal("clicked")
		
		


func update_ui():
	var held_item = InventoryData.toolbar_data[self.get_index()]
	if held_item is Item:
		get_node("HoldingTexture").texture = held_item.item_sprite
	else:
		get_node("HoldingTexture").texture = base_texture
	if self.get_index() == InventoryData.active_index:
		get_node("OutlineTexture").set_visible(true)
	else:
		get_node("OutlineTexture").hide()
