extends Area2D

#var spd = 230 when shoot
var mouv = Vector2()
var tir_mouv = Vector2()
var tir_power 

func _physics_process(delta):
	
	"""
	if(tir_power == 0):
		$AnimatedSprite.play("tir_faible")
	if(tir_power == 1):
		$AnimatedSprite.play("tir_fort")
	"""
	
	$AnimatedSprite.play("tir_fort")
	
	if $AnimatedSprite.get_frame() == 1:
		mouv = mouv*1.02
	if $AnimatedSprite.get_frame() == 2:
		mouv = mouv*1.02
		
		
	
	
	"""
	
	if mouv<Vector2(800,0):
		mouv = mouv*1.01
	else:
		if mouv<Vector2(1200,0):
			mouv = mouv*1.004
	
	if (sign(mouv.x)*mouv.x)>(sign(mouv.y)*mouv.y):
		self.scale.y = (230/(mouv.x))/1
	else:
		self.scale.y = (230/(mouv.y))/1
	"""

	look_at(get_global_position()+tir_mouv)
	
	tir_mouv = mouv* delta
	translate(tir_mouv)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	

func _on_tir_arcane_body_entered(body):
	
	var dir
	
	if position.x<body.position.x:
		dir = 3
	else:
		dir = -3
	
	if body.is_in_group("Character_blue"):
		if(tir_power == 0):
			if body.is_in_group("Character"):
				body.global_position+=Vector2((sign(self.position.x-body.position.x)*-2),-1)
			queue_free()
		if(tir_power == 1):
			if body.is_in_group("Character"):
				body.global_position+=Vector2((sign(self.position.x-body.position.x)*-4),-2)
			body._take_damage(0.25,Vector2(dir,-1.5))
			queue_free()
	else:
		if body.is_in_group("Character_red"):
			pass
		else:
			queue_free()
