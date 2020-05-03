extends Area2D

#var resp_timer = 30
#var first_digit
#var second_digit
#var gain = 1
var body_char 
var HEALTH = 100

func _ready():
	$portal/Light2D/vortex/AnimationPlayer.play("vortex")


func _process(_delta):
	"""
	resp_timer -= (gain*delta)
	
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
	"""
	body_char = get_overlapping_bodies()
	
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
		
		pass
	
	
	get_parent().get_node("HUD").get_node("life_portal_blue").get_node("life").value = HEALTH
	
	
	if HEALTH == 0:
		#do smth
		pass
	
	pass
	