extends Particles2D

var TEAM

var active = false

var active_for_peer = false

const fire_hitbox_load = preload("res://Magie/fire_hitbox.tscn")
#const fire_hitbox_load = preload("res://projectiles/tir_arcane.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if get_parent().is_in_group("Character_blue"):
		TEAM = "blue"
	else:
		TEAM = "red"


func _process(_delta):
	
	if active == true:
		
		rpc("_activate_timer_blue",active)
		#$Timer.start()
		
		"""
		if get_parent().is_in_group("Character_blue"):
			#$Timer.start()
			#rpc("_activate_timer_blue",active)
		else:
			#$Timer.start()
			#rpc("_activate_timer_red",active)
		"""
		active = false
	else:
		pass
	
	if self.emitting != true:
		$Timer.stop()
	
	if get_parent().is_in_group("Character_blue"):
		rpc("_updateStatus_blue",position,rotation,self.emitting)
	
	
	if is_network_master():
		if get_parent().is_in_group("Character_red"):
			rpc("_updateStatus_red",position,rotation,self.emitting)
			pass
	



func _on_Timer_timeout():
	var hit_box = fire_hitbox_load.instance()
	var hit_box_up = fire_hitbox_load.instance()
	var hit_box_down = fire_hitbox_load.instance()
	if TEAM == "blue":
		hit_box.TEAM = "blue"
		hit_box_up.TEAM = "blue"
		hit_box_down.TEAM = "blue"
	if TEAM == "red":
		hit_box.TEAM = "red"
		hit_box_up.TEAM = "red"
		hit_box_down.TEAM = "red"
	hit_box_up.mouv = 5
	hit_box_up.position = get_parent().position
	hit_box_up.mouv = Vector2(cos(get_parent().get_node("Wizard_arm").rotation-0.15),sin(get_parent().get_node("Wizard_arm").rotation-0.15)) * hit_box.spd
	get_parent().get_parent().add_child(hit_box_up,true)
	hit_box.mouv = 5
	hit_box.position = get_parent().position
	hit_box.mouv = Vector2(cos(get_parent().get_node("Wizard_arm").rotation),sin(get_parent().get_node("Wizard_arm").rotation)) * hit_box.spd
	get_parent().get_parent().add_child(hit_box,true)
	hit_box_down.mouv = 5
	hit_box_down.position = get_parent().position
	hit_box_down.mouv = Vector2(cos(get_parent().get_node("Wizard_arm").rotation+0.15),sin(get_parent().get_node("Wizard_arm").rotation+0.15)) * hit_box.spd
	get_parent().get_parent().add_child(hit_box_down,true)


func _on_Timer_quefree_timeout():
	#get_parent().has_fire = false
	rpc("_queue_free")
	#queue_free()
	pass


master func _updateStatus_blue(pos,rot,eme):
	position = pos
	rotation = rot
	emitting = eme

puppet func _updateStatus_red(pos,rot,eme):
	position = pos
	rotation = rot
	emitting = eme


sync func _activate_timer_blue(Activate):
	if Activate == true:
		$Timer.start()

"""
sync func _activate_timer_red(Activate):
	if Activate == true:
		$Timer.start()
"""


sync func _queue_free():
	_process(false)
	$Timer.stop()
	queue_free()

