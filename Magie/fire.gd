extends Particles2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false

const fire_hitbox_load = preload("res://Magie/fire_hitbox.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	
	
	if active == true:
		$Timer.start()
		active = false
	else:
		pass
	
	if self.emitting != true:
		$Timer.stop()



func _on_Timer_timeout():
	var hit_box = fire_hitbox_load.instance()
	var hit_box_up = fire_hitbox_load.instance()
	var hit_box_down = fire_hitbox_load.instance()
	hit_box_up.mouv = 5
	hit_box_up.position = get_parent().position
	hit_box_up.mouv = Vector2(cos(get_parent().get_node("Wizard_arm").rotation-0.15),sin(get_parent().get_node("Wizard_arm").rotation-0.15)) * hit_box.spd
	get_parent().get_parent().add_child(hit_box_up)
	hit_box.mouv = 5
	hit_box.position = get_parent().position
	hit_box.mouv = Vector2(cos(get_parent().get_node("Wizard_arm").rotation),sin(get_parent().get_node("Wizard_arm").rotation)) * hit_box.spd
	get_parent().get_parent().add_child(hit_box)
	hit_box_down.mouv = 5
	hit_box_down.position = get_parent().position
	hit_box_down.mouv = Vector2(cos(get_parent().get_node("Wizard_arm").rotation+0.15),sin(get_parent().get_node("Wizard_arm").rotation+0.15)) * hit_box.spd
	get_parent().get_parent().add_child(hit_box_down)
	


func _on_Timer_quefree_timeout():
	queue_free()
