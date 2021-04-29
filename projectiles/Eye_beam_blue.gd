extends Area2D



var point_progress = Vector2(50,0)
var point_progress_2 = Vector2(50,0)
var body_char = null
var mouv = Vector2(1400,0)
#var reflect
var hit = false
var hit_once = false


func _ready():
	pass


func _physics_process(delta):
	
	
	#if is_network_master():
		#$CollisionShape2D.position = Vector2((self.get_point_position(1).x-self.get_point_position(0).x)/2,2)
		"""
		$CollisionShape2D.position.x = ($Line2D.get_point_position(0).x)#+(($Line2D.get_point_position(1).x-$Line2D.get_point_position(0).x))/2)#+($Area2D/CollisionShape2D.get_shape().get_extents())
		$CollisionShape2D.get_shape().set_length(($Line2D.get_point_position(1).x-$Line2D.get_point_position(0).x)+50)
		"""
		$VisibilityNotifier2D.position = $Line2D.get_point_position(0)
		
		#$CollisionShape2D.get_shape().set_extents((($Line2D.get_point_position(1)-$Line2D.get_point_position(0))/2)+Vector2(50,0))
		#$Area2D/CollisionShape2D.get_shape().set_extents(Vector2(((self.get_point_position(1).x)/2),0)+Vector2(50,0))
		#$Area2D/CollisionShape2D.get_shape().set_extents(value)  = self.get_point_position(1).x
		
		$CollisionShape2D.position.x = $Line2D.get_point_position(1).x+10
		##$RayCast2D.set_cast_to(Vector2(0,($Line2D.get_point_position(1).x-$Line2D.get_point_position(0).x)+20)/2)
		##$RayCast2D.position.x = $Line2D.get_point_position(0).x
		
		"""
		if $RayCast2D.is_colliding():
			if $RayCast2D.get_collider() != null:
				pass
				if $RayCast2D.get_collider().is_in_group("obstacle"):
					hit = true
				if $RayCast2D.get_collider().is_in_group("Shield"):
					if hit_once == false:
						hit_once = true
					hit = true
				if $RayCast2D.get_collider().is_in_group("Character_red"):
					if hit_once == false:
						if is_network_master():
							$RayCast2D.get_collider()._take_damage(0.10,Vector2(-1,-1))
						hit_once = true
					hit = true
		"""
		
		$Line2D.set_point_position(1,point_progress)
		
		if hit != true:
			point_progress += mouv*delta
		else:
			if point_progress_2 <= point_progress:
				point_progress_2 += mouv*delta
			else:
				queue_free()
				#if is_network_master():
					#rpc("_queue_free")
		
	
		
		#if body_char == null:
		if $Line2D.get_point_position(0).x-500+$Line2D.get_point_position(1).x < 0 && hit != true:
			$Line2D.set_point_position(0,Vector2(30,0))
		else:
			if point_progress_2 <= point_progress:
				point_progress_2 += mouv*delta
				$Line2D.set_point_position(0,point_progress_2)
			else:
				#rpc("_queue_free")
				pass
				#queue_free()
		
		#rpc("_display_line",$Line2D.get_point_position(0),$Line2D.get_point_position(1))
		
		pass



func _on_VisibilityNotifier2D_screen_exited():
	pass
	#queue_free()

puppet func _display_line(point0,point1):
	$Line2D.set_point_position(0,point0)
	$Line2D.set_point_position(1,point1)


sync func _queue_free():
	set_physics_process(false)
	queue_free()





func _on_Eye_beam_blue_body_entered(body):
	hit = true
	if is_network_master():
		if body.is_in_group("Character_red"):
			body._take_damage(0.10,Vector2(-1,-1))
			#$CollisionShape2D.disabled = true
		#if body.is_in_group("obstacle"):
			#pass
		else:
			pass
		
	#match body.is_in_group():
		#"Character_red":
			#pass

