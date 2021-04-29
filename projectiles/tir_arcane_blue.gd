extends Area2D

#var spd = 230 when shoot
var mouv = Vector2()
var tir_mouv = Vector2()
var tir_power

var dead

func _ready():
	if is_network_master():
		pass
	else:
		#set_collision_mask_bit(2,false)
		#$CollisionShape2D.disabled = true
		pass

func _physics_process(delta):
		
	if is_network_master():
		$AnimatedSprite.play("tir_fort")
		
		if $AnimatedSprite.get_frame() == 1:
			mouv = mouv*1.02
		if $AnimatedSprite.get_frame() == 2:
			mouv = mouv*1.02
		
		
		
		look_at(get_global_position()+tir_mouv)
		
		tir_mouv = mouv* delta
		
		translate(tir_mouv)
		
		rpc_unreliable("setPosRot",global_position,global_rotation)
		
		


func _on_VisibilityNotifier2D_screen_exited():
	if is_network_master():
		#rpc_unreliable("_queue_free")
		#queue_free()
		pass
	#rpc("_queue_free")
	#queue_free()
	pass

func _on_tir_arcane_body_entered(body):
	
	if is_network_master():
		var dir 
		
		if position.x<body.position.x:
			dir = 3
		else:
			dir = -3
			
		if body.is_in_group("Character_red"):
			#body.global_position+=Vector2((sign(self.position.x-body.position.x)*-4),-2)
			body._take_damage(0.25,Vector2(dir,-1.5))
			rpc("_queue_free")
		elif body.is_in_group("shield"):
			rpc("_queue_free")
		elif body.is_in_group("Crystal_spawn"):
			if body.crystal_type == "ball":
				body.mouv += Vector2(cos(self.rotation)*100,sin(self.rotation)*100)
				rpc("_queue_free")
			if body.crystal_type == "soul":
				body.rpc_unreliable("setColor",Color(1,0,0,1))
				body.get_node("Area2D").get_node("CollisionShape2D").set_deferred("disabled",false)
				rpc("_queue_free")
			if body.crystal_type == "money":
				body._take_damage(1,Vector2(0,0))
				rpc("_queue_free")
		else:
			if body.is_in_group("Character_blue"):
				pass
			else:
				rpc("_queue_free")
	pass


puppet func setPosRot(pos,rot):
	position = pos
	rotation = rot



sync func _queue_free():
	set_physics_process(false)
	queue_free()


