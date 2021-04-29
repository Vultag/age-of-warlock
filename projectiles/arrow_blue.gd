extends Area2D

var spd = 500
var mouv = Vector2()
var tir_mouv = Vector2()
var flip_v
var stop
var hit = false
var team_blue = true
var dontdelete = false
const GRAVITY = 4
const FLOOR = Vector2(0,-1)

var dead

onready var Body
onready var ARea

func _ready():
	
	if is_network_master():
		if(flip_v==0):
			set_global_scale(Vector2(1,1)) 
			#rpc_unreliable("_set_scale",Vector2(1,-1))
		elif(flip_v==1):
			set_global_scale(Vector2(1,-1)) 
			#rpc_unreliable("_set_scale",Vector2(1,-1))
	else:
		#$CollisionShape2D.disabled = true
		if(flip_v==0):
			set_global_scale(Vector2(1,1)) 
			#rpc_unreliable("_set_scale",Vector2(1,-1))
		elif(flip_v==1):
			set_global_scale(Vector2(1,-1)) 
		#$CollisionShape2D.disabled = true



func _physics_process(delta):
	#print(flip_v)
	#rpc("_queue_free") 
	#if is_network_master():
		
		"""
		if stop==true:
			pass
		else:
			if(flip_v==0):
				#$arrow_spr.flip_v = false
				set_global_scale(Vector2(1,1)) 
			if(flip_v==1):
				set_global_scale(Vector2(1,-1)) 
				#$arrow_spr.flip_v = true
		"""
		
		if(spd==500):look_at(get_global_position()+tir_mouv)
	
		tir_mouv = mouv* delta
		
		if(spd==500):
			translate(tir_mouv)
			mouv.y+=GRAVITY
		else:
			pass
		
		if(is_instance_valid(Body)):
			if(overlaps_body(Body)):
			
				if(Body is TileMap):
					spd=0
				else :
				#if Body.has_node("Wizard_spr"):
					#var obj_spr = Body.get_node("Wizard_spr")
					#if (obj_spr.is_in_group("Character_sprite")):
						#angle=get_angle_to(Body.position)
						#self.scale.x=obj_spr.scale.x
						#if(obj_spr.scale.x==-1):
							#self.position.x-=8
							#self.flip_h=true
							#self.scale.x=-1 #obj_spr.scale.y
							#self.rotation_degrees*=-1
							#global_rotation_degrees=angle
							#self.scale.x=-1 #obj_spr.scale.y
						#else:
							#self.position.x+=16
				#$CollisionShape2D.disabled=true
					"""
					mouv = Body.mouv
					translate(tir_mouv)
					"""
		#rpc_unreliable("setPos",self.global_position)
		#rpc_unreliable("setRot",self.rotation)
		
		#if dead == true:
			#rpc("_queue_free") 



func _on_VisibilityNotifier2D_screen_exited():
	
	if dontdelete == false:
		pass
		#queue_free()
		##dead = true
	"""
	if(is_instance_valid(self.get_parent())):
		queue_free()
	else:
		pass
	"""

func _on_arrow_body_entered(body):
	if body.is_in_group("Character_red"):
		if is_network_master():
			Body = body
			$Timer.start()
			spd = 0
			body._take_damage(0.20,Vector2(-5,-5))
			hit = true
			#queue_free()
			#dead = true
		queue_free()
	elif body.is_in_group("Character_blue"):
		pass
	else:
		queue_free()
		#queue_free()
		#$Timer.start()
		spd = 0




func _on_arrow_body_exited(body):
	
	
	if body.is_in_group("Character_red"):
		#dead = true
		pass
		#queue_free()
		
		#spd = 500
		#stop=true


func _on_Timer_timeout():
	pass
	#dead = true
	#queue_free()
	#rpc("_queue_free")

puppet func _set_scale(scale):
	set_global_scale(scale) 

puppet func setPos(pos):
	position = pos

puppet func setRot(rot):
	rotation = rot


sync func _queue_free():
	set_physics_process(false)
	queue_free()
