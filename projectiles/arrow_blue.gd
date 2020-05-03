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

onready var Body
onready var ARea


func _physics_process(delta):
	
	if get_parent() is Area2D:
		if get_parent().get_parent().get_parent().shield_on == true:
			pass
		else:
			queue_free()
	
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
				
				mouv = Body.mouv
				translate(tir_mouv)

	if(is_instance_valid(ARea)):
		if(overlaps_area(ARea)):
			
			"""
			if ARea.is_in_group("Shield"):
				if ARea.get_parent().get_parent().shield_on == true:
					pass
				else:
					queue_free()
			"""
			
			if(ARea is TileMap):
				spd=0
			else :
				if ARea.is_in_group("Shield"):
					
					spd = 0
					mouv = Vector2(0,0)
					#dontdelete = true
					
					var arrow = self
					
					var old_position = self.global_position
					get_parent().remove_child(self)
					ARea.add_child(arrow)
					arrow.global_position = old_position
					#arrow.global_position = Vector2(100,100)
					
					hit = true
					
					team_blue = false
					
					$Timer.start()
		else:
			if ARea.is_in_group("Shield"):
				pass
				
				#queue_free()
				
				#var old_position = self.global_position
				#ARea.remove_child(self)
				#ARea.get_tree().get_root().add_child(self)
				#self.global_position = old_position
				#spd = 500
				#mouv.y+=GRAVITY
				#translate(tir_mouv)
				#dontdelete = false




func _on_VisibilityNotifier2D_screen_exited():
	
	if dontdelete == false:
		pass
		#queue_free()
	"""
	if(is_instance_valid(self.get_parent())):
		queue_free()
	else:
		pass
	"""

func _on_arrow_body_entered(body):
	
	if team_blue == true:
		if body.is_in_group("Character_red"):
			if(stop==true):
				Body = body
				$Timer.start()
			else:
				if hit == false:
					Body = body
					$Timer.start()
					spd = 0
					body._take_damage(0.20,Vector2(-1,-1))
					hit = true
		elif body.is_in_group("Character_blue"):
			pass
		else:
			$Timer.start()
			spd = 0

	elif team_blue == false:
		if body.is_in_group("Character_blue"):
			if(stop==true):
				Body = body
				$Timer.start()
			else:
				if hit == false:
					Body = body
					$Timer.start()
					spd = 0
					body._take_damage(0.20,Vector2(1,-1))
					hit = true
		elif body.is_in_group("Character_red"):
			pass
		else:
			$Timer.start()
			spd = 0


func _on_Timer_timeout():
	queue_free()
	pass


func _on_arrow_body_exited(body):
	
	queue_free()
	
	if body.is_in_group("Character_red"):
		#pass
		queue_free()
		
		#spd = 500
		#stop=true


func _on_arrow_area_entered(area):
	if area.is_in_group("Shield"):
		
		ARea = area
		"""
		spd = 0
		
		dontdelete = true
		
		
		spd = 0
		dontdelete = true
		
		var arrow = self
		
		var old_position = self.global_position
		get_parent().remove_child(self)
		area.add_child(arrow)
		arrow.global_position = old_position
		
		hit = true
		
		team_blue = false
		
		$Timer.start()
		"""
		# DEFECT PROJECTILE
		#mouv = Vector2(spd/1.5, 0)
		#self.rotation_degrees=area.get_angle_to(self.position)
		#mouv = Vector2(spd/1.5, 0).rotated(area.get_angle_to(self.position))
		#mouv = Vector2(spd/1.5, 0).rotated(get_angle_to(area.position))
		#mouv = Vector2(spd/1.5, 0).rotated(area.global_rotation)


func _on_arrow_area_exited(area):
	if area.is_in_group("Shield"):
		
		pass
		#queue_free()
		
		"""
		#dontdelete = false
		pass
		
		area.remove_child(self)
		spd = 500
		dontdelete = false
		"""
