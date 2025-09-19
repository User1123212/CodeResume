extends Node2D


@export var item_resource: Item


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ItemTexture").texture = item_resource.item_sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Player"):
		InventoryData.pickup_item(InventoryData.inventory_data, item_resource)
		self.queue_free()
