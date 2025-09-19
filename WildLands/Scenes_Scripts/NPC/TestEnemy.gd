#Here is the script for the enemy character
extends CharacterBody2D


const speed = 150
var target = null

var hp = 100

#Moves the enemy towards the target
func _physics_process(delta):
	if target != null:
		position = position.move_toward(target.get_parent().position,delta*speed)
	

	move_and_slide()

#Checks if enemy is dead and removes from main scene
func _process(delta):
	if hp <= 0:
		self.queue_free()

#Sets player as target when it enters the enemy's "Attention Zone" and removes the player as the target when outside of zone
func _on_attention_zone_area_entered(area):
	if area.is_in_group("Player"):
		target = area
func _on_attention_zone_area_exited(area):
	if area.is_in_group("Player"):
		target = null

#Adds knockback from attacks (Work in progress)
func _on_hitbox_area_entered(area):
	if area.is_in_group("Attack"):
		hp -= 20
		self.position.x -= 200*cos(area.get_rotation())
		print(self.position.x)
		self.position.y -= 200*sin(area.get_rotation())
		print(self.position.y)
