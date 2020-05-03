extends Area2D

# Declare member variables here. Examples:
# var a = 2
var point_progress = Vector2(50,0)
var point_progress_2 = Vector2(50,0)
var body_char = null
var mouv = Vector2(1,0)
var reflect
var hit = false


var test = -1


func _ready():
	pass


func _process(delta):
	
	#$CollisionShape2D.position = Vector2((self.get_point_position(1).x-self.get_point_position(0).x)/2,2)
	$CollisionShape2D.position.x = ($Line2D.get_point_position(0).x)#+(($Line2D.get_point_position(1).x-$Line2D.get_point_position(0).x))/2)#+($Area2D/CollisionShape2D.get_shape().get_extents())
	$CollisionShape2D.get_shape().set_length($Line2D.get_point_position(1).x-$Line2D.get_point_position(0).x)#-500)
	#$CollisionShape2D.get_shape().set_extents((($Line2D.get_point_position(1)-$Line2D.get_point_position(0))/2)+Vector2(50,0))
	#$Area2D/CollisionShape2D.get_shape().set_extents(Vector2(((self.get_point_position(1).x)/2),0)+Vector2(50,0))
	#$Area2D/CollisionShape2D.get_shape().set_extents(value)  = self.get_point_position(1).x
	
	
	
	if hit != true:
		point_progress += mouv 
	else:
		#point_progress += mouv
		pass
		#get_parent().rotation = 90
	
	if hit != true:
		pass
	else:
		if point_progress_2 <= point_progress:
			point_progress_2 += mouv 
		else:
			queue_free()
	
	
	#$Area2D.position = self.get_point_position(get_point_count()-1)
	
	
	if hit != true:
		$Line2D.set_point_position(1,point_progress)
	else:
		$Line2D.set_point_position(1,point_progress)
		#self.set_point_position(self.get_point_count()-1,point_progress)


	
	#if body_char == null:
	if $Line2D.get_point_position(0).x-500+$Line2D.get_point_position(1).x < 0:
		$Line2D.set_point_position(0,Vector2(50,0))
	else:
		if point_progress_2 <= point_progress:
			point_progress_2 += mouv 
			$Line2D.set_point_position(0,point_progress_2)
		else:
			queue_free()
	


func _on_beam_body_entered(body):
	
	if body.is_in_group("Character_red"):
		hit = true
		body_char =  body
		body_char._take_damage(0.30,Vector2(1,-1))
		test *=-1
	#reflect =  mouv.rotated(angle_to_point(get_collision_normal()))
	#reflect = Vector2(to_local((to_global(mouv.x))).x,to_local((to_global(mouv.y*-1))).x)                    #Vector2(cos(body.rotation_degrees), sin(body.rotation_degrees))
	#self.add_point(self.get_point_position(1)+Vector2(0,0))
	
	
	if !body.is_in_group("Character_blue") && !body.is_in_group("Character_red"):
		pass
	
	
	if body.is_in_group("obstacle"):
		body_char = null
		test *=-1
		pass
		#hit = true














