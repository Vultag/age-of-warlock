extends Area2D

var spd = 500
var mouv = Vector2()
var tir_mouv = Vector2()
var flip_v
var stop
var hit = false
const GRAVITY = 4
const FLOOR = Vector2(0,-1)

#onready var body = get_groups("Character")
#onready var body = get_parent().get_node("Wizard")
onready var Body


func _physics_process(delta):
	
	if stop==true:
		pass
	else:
		if(flip_v==0):
			#$arrow_spr.flip_v = false
			set_global_scale(Vector2(1,1)) 
	
		if(flip_v==1):
			set_global_scale(Vector2(1,-1)) 
			#$arrow_spr.flip_v = true
	
	if(spd==500):look_at(get_global_position()+tir_mouv)

	tir_mouv = mouv* delta
	
	if(spd==500):
		translate(tir_mouv)
		mouv.y+=GRAVITY
	else:
		pass
	
	#if(overlaps_body(TileMap)):
		#spd=0
	
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
				#position = Body.global_position
				mouv = Body.mouv
				translate(tir_mouv)


func _on_VisibilityNotifier2D_screen_exited():
	pass
	#queue_free()

func _on_arrow_body_entered(body):
	if body.is_in_group("Character_blue"):
		if(stop==true):
			Body = body
			$Timer.start()
		else:
			if body.is_in_group("Shield"):
				spd = 0
			else:
				if hit == false:
					Body = body
					$Timer.start()
					spd = 0
					body._take_damage(0.20,Vector2(2,-1))
					hit = true
	elif body.is_in_group("Character_red"):
		pass
	else:
		$Timer.start()
		spd = 0

func _on_Timer_timeout():
	queue_free()


func _on_arrow_body_exited(body):
	
	queue_free()
	
	if body.is_in_group("Character_blue"):
		
		queue_free()
		pass
		#spd = 500
		#stop=true
