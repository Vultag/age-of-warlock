extends Area2D

var resp_timer = 5
var first_digit
var second_digit
var gain = 1
var count = false
var body_char 
const playerBlue_preload = preload("res://Character/Wizard_blue.tscn")
var HEALTH = 100

var respawn_with_fire_blue
var respawn_with_frost_blue

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
			if!Node.is_in_group("Character_blue"):
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
	"""
	pass
	
	
	
	if HEALTH == 0:
		#do smth
		pass
	
	pass



sync func _wiz_respawn():
	var playerBlue = playerBlue_preload.instance()
	playerBlue.set_name(str(globals.playerJoinId))
	playerBlue.set_network_master(globals.playerJoinId)
	get_parent().add_child(playerBlue)
	get_parent().wiz_blue = playerBlue
	playerBlue.position = get_parent().get_node("Portal_blue").get_node("spawn_point_blue").global_position
	if respawn_with_fire_blue == true:
		var fire = preload("res://Magie/fire.tscn").instance()
		playerBlue.add_child(fire)
		playerBlue.get_node("fire").global_position = playerBlue.get_node("Wizard_arm").get_node("Position2D").global_position
		playerBlue.get_node("fire").set_emitting(false)#a changer
		playerBlue.get_node("fire").active = false
		respawn_with_fire_blue = false
	if respawn_with_frost_blue == true:
		var frost = preload("res://Magie/frost.tscn").instance()
		playerBlue.add_child(frost)
		playerBlue.get_node("frost").global_position = playerBlue.get_node("Wizard_arm").get_node("Position2D").global_position
		playerBlue.get_node("frost").set_emitting(false)#a changer
		playerBlue.get_node("frost").active = false
		respawn_with_frost_blue = false



func _on_Portal_blue_body_entered(body):
	if !body.is_in_group("Character"):
		body._take_damage(10,Vector2(0,0))
		rpc("_damage_portal")


sync func _damage_portal():
	#get_parent().get_node("HUD").get_node("life_portal_blue").get_node("life").visible = false
	get_parent().get_node("HUD").get_node("life_portal_blue").get_node("life").value -= 5

