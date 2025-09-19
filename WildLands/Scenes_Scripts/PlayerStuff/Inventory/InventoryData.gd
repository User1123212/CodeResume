extends Node

signal update_inventory

var inventory_data = [null,null,null,null,null,null,null,null,null]
var inventory_size = 36

var toolbar_data = [null,null,null,null,null,null,null]
var toolbar_size = 7

var active_index = 0
var active_slot = toolbar_data[active_index]


var stored_item = null
var stored_index = 0
var stored_list = null

func swap_items(source_list:Array, item_1: Item, item_1_index:int, target_list: Array, item_2:Item, item_2_index: int):
	source_list.remove_at(item_1_index)
	source_list.insert(item_1_index, item_2)
	
	target_list.remove_at(item_2_index)
	target_list.insert(item_2_index, item_1)
	emit_signal("update_inventory")

	

func pickup_item(data_list:Array, item:Item):
	for n in range(len(data_list)):
		if data_list[n] != null:
			pass
		else:
			var location = n
			data_list.remove_at(location)
			data_list.insert(location, item)
			break
	emit_signal("update_inventory")
	
	
func add_item(target_list: Array, item_index:int, item:Item):
	target_list.remove_at(item_index)
	target_list.insert(item_index, item)
	emit_signal("update_inventory")
	
func remove_item(data_list:Array,item_index:int):
	data_list.remove_at(item_index)
	data_list.insert(item_index, null)
	emit_signal("update_inventory")
	
func store_item(data_list: Array, item: Item, item_index: int):
	stored_item = item
	stored_index = item_index
	stored_list = data_list
	emit_signal("update_inventory")
