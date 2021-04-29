extends Area2D

var resp_timer = 5
var first_digit
var second_digit
var gain = 1
var count = false
var body_char 
#var sucking = false
const playerRed_preload = preload("res://Character/Wizard.tscn")
var HEALTH = 100

var respawn_with_fire_red
var respawn_with_frost_red

func _ready():
	$portal/Light2D/vortex/AnimationPlayer.play("vortex")
	$PJ_respawn_spr.visible = false


func _physics_process(delta):
	
	if count == true:
		resp_timer -= (gain*delta)
	
	if resp_timer <= 0:
		resp_timer = 5
		count = false
		$PJ_respawn_spr.visible = false
		if is_network_master():
			rpc("_wiz_respawn")
		#playerRed.position = Vector2(900,586)
	
	first_digit = resp_timer
	
	
	while (first_digit >= 10 ):
		first_digit -= 10;
	
	
	second_digit = resp_timer
	
	
	while (second_digit >= 10):
		second_digit /= 10;
	
	
	$PJ_respawn_spr/num_1.set_frame(first_digit)
	
	
	if (resp_timer>=10):
		$PJ_respawn_spr/num_2.play("default")
		$PJ_respawn_spr/num_2.set_frame(second_digit)
	else:$PJ_respawn_spr/num_2.play("off")
	
	#body_char = get_overlapping_bodies()
	"""
	if(body_char.size() != 0):
		#body_char.back().position.y -=  1
		for Node in body_char:
			if!Node.is_in_group("Character_red"):
				if!Node.is_in_group("Hero"):
					#Node._stuned()
					pass
				if !(Node.global_position.x <= ($center.global_position.x+1) && Node.global_position.x >= ($center.global_position.x-1)):
					Node.mouv.x = ((25*sign(Node.global_position.x-$center.global_position.x))*-1)+(Node.mouv.x*0.84)
					Node.mouv.y = (25*sign($center.global_position.y-Node.global_position.y))+(Node.mouv.y*0.85)
					Node.GRAVITY = 0
				elif !(Node.global_position.y <= ($center.global_position.y+1) && Node.global_position.y >= ($center.global_position.y-1)):
					#Node.mouv.y = (25*sign($center.global_position.y-Node.global_position.y))+(Node.mouv.y*0.75)
					Node.GRAVITY = 0
				else:#if!Node.is_in_group("Hero"):
					pass
					Node.queue_free()
					#Node.local_scene.free()
					HEALTH -= 5
		
		pass
	
	"""
	
	
	if HEALTH == 0:
		#get_tree().change_scene("res://path/to/scene.tscn")
		pass


sync func _wiz_respawn():
	var playerRed = playerRed_preload.instance()
	playerRed.set_name(str(globals.playerHostId))
	playerRed.set_network_master(globals.playerHostId)
	get_parent().add_child(playerRed)
	get_parent().wiz_red = playerRed
	playerRed.position = get_parent().get_node("Portal_red").get_node("spawn_point_red").global_position
	if respawn_with_fire_red == true:
		var fire = preload("res://Magie/fire.tscn").instance()
		playerRed.add_child(fire)
		playerRed.get_node("fire").global_position = playerRed.get_node("Wizard_arm").get_node("Position2D").global_position
		playerRed.get_node("fire").set_emitting(false)#a changer
		playerRed.get_node("fire").active = false
		respawn_with_fire_red = false
	if respawn_with_frost_red == true:
		var frost = preload("res://Magie/frost.tscn").instance()
		playerRed.add_child(frost)
		playerRed.get_node("frost").global_position = playerRed.get_node("Wizard_arm").get_node("Position2D").global_position
		playerRed.get_node("frost").set_emitting(false)#a changer
		playerRed.get_node("frost").active = false
		respawn_with_frost_red = false
	playerRed.has_homing_missile = get_parent().get_node("HUD").has_homing_missile
	#has_bigger_shield = get_parent().get_node("HUD").has_homing_missile
	playerRed.Shield = get_parent().get_node("HUD").has_bigger_shield





func _on_Portal_red_body_entered(body):
	if !body.is_in_group("Character"):
		body._take_damage(10,Vector2(0,0))
		rpc("_damage_portal")


sync func _damage_portal():
	#get_parent().get_node("HUD").get_node("life_portal_blue").get_node("life").visible = false
	get_parent().get_node("HUD").get_node("life_portal_red").get_node("life").value -= 5
