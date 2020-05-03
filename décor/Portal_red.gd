extends Area2D

var resp_timer = 5
var first_digit
var second_digit
var gain = 1
var count = false
var body_char 
#var sucking = false
var HEALTH = 100
const wizard_red_load = preload("res://Character/Wizard.tscn")

func _ready():
	$portal/Light2D/vortex/AnimationPlayer.play("vortex")
	$PJ_respawn_spr.visible = false


func _process(delta):
	
	if count == true:
		resp_timer -= (gain*delta)
	
	if resp_timer <= 0:
		resp_timer = 5
		count = false
		$PJ_respawn_spr.visible = false
		var wizard = wizard_red_load.instance()
		get_parent().add_child(wizard)
		wizard.position = get_parent().get_node("Portal_red").get_node("spawn_point_red").global_position
	
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
	
	body_char = get_overlapping_bodies()
	
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
	
	
	get_parent().get_node("HUD").get_node("life_portal_red").get_node("life").value = HEALTH
	
	
	if HEALTH == 0:
		#get_tree().change_scene("res://path/to/scene.tscn")
		pass
	
	
	
	
	
	
	
	"""
	if sucking==true:
		if(is_instance_valid(body_char)):
			if(overlaps_body(body_char)):
				if!body_char.is_in_group("Hero"):
					body_char._stuned()
				else:
					pass
				#body_char.global_position = $center.global_position
				#if !(body_char.global_position <= ($center.global_position+Vector2(1,0)) && body_char.global_position >= ($center.global_position+Vector2(-1,0))):
				if !(body_char.global_position.x <= ($center.global_position.x+1) && body_char.global_position.x >= ($center.global_position.x-1)):
					if !(body_char.global_position.y <= ($center.global_position.y+1) && body_char.global_position.y >= ($center.global_position.y-1)):
					
					
						body_char.mouv.x -= 0.5*sign(body_char.global_position.x-$center.global_position.x)
						body_char.mouv.y += 0.7*sign($center.global_position.y-body_char.global_position.y)
						pass
					elif!body_char.is_in_group("Hero"):
						pass
						body_char.queue_free()
	"""

	"""
func _on_Portal_red_body_entered(body):
	
	body_char = body
	sucking = true
	#_portal_suck(body_char)
	
	pass
	"""
	"""
	if(is_instance_valid(body)):
		if(overlaps_body(body)):
			if!body.is_in_group("Hero"):
				body._stuned()
			else:
				pass
			#body_char.global_position = $center.global_position
			#if !(body_char.global_position <= ($center.global_position+Vector2(1,0)) && body_char.global_position >= ($center.global_position+Vector2(-1,0))):
			if !(body.global_position.x <= ($center.global_position.x+1) && body.global_position.x >= ($center.global_position.x-1)):
				if !(body.global_position.y <= ($center.global_position.y+1) && body.global_position.y >= ($center.global_position.y-1)):
				
				
					body.mouv.x -= 0.5*sign(body.global_position.x-$center.global_position.x)
					body.mouv.y += 0.7*sign($center.global_position.y-body.global_position.y)
					pass
				elif!body.is_in_group("Hero"):
					pass
					body.queue_free()
	"""
	
	
	"""
	#if !body.is_in_group("Hero"):
	if body.is_in_group("Character_red"):
		#body._portal_suck()
		body_char = body
	if body.is_in_group("Character_blue"):
		#body._portal_suck()
		body_char = body
	"""
	

	"""
func _portal_suck(body):
	
	#body_char = body
	sucking = true
	"""
	"""
	
	body_char._stuned()
	body_char.mouv.y += 100
	"""
	
	
	"""
	if(overlaps_body(body_char)):
				if!body_char.is_in_group("Hero"):
					body_char._stuned()
				else:
					pass
				#body_char.global_position = $center.global_position
				#if !(body_char.global_position <= ($center.global_position+Vector2(1,0)) && body_char.global_position >= ($center.global_position+Vector2(-1,0))):
				if !(body_char.global_position.x <= ($center.global_position.x+1) && body_char.global_position.x >= ($center.global_position.x-1)):
					if !(body_char.global_position.y <= ($center.global_position.y+1) && body_char.global_position.y >= ($center.global_position.y-1)):
					
					
						body_char.mouv.x -= 0.5*sign(body_char.global_position.x-$center.global_position.x)
						body_char.mouv.y += 0.7*sign($center.global_position.y-body_char.global_position.y)
						pass
					elif!body_char.is_in_group("Hero"):
						pass
						body_char.queue_free()
	"""


