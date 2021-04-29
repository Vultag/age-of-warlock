extends AnimatedSprite


var selected
var team
var Remote


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Remote == true:
		$arrow_line.queue_free()
		$arrow_end.queue_free()	
		pass
	
	if get_parent().get_parent().get_parent().is_in_group("Character_red"):
		team = "red"
	else:
		team = "blue"



func _physics_process(_delta):
	
	if Remote == true:
		
		pass
		
	else:
		
		if team == "red":
			
			rpc_unreliable("setPositionRed",Vector2(global_position.x , global_position.y))
			
			var angle_mouse = get_global_mouse_position().angle_to_point(global_position)
			
			$arrow_line.set_point_position(1,(to_local(get_global_mouse_position())/1.5))
			
			$arrow_end.global_position = get_global_mouse_position()
			
			$arrow_end.global_rotation = angle_mouse-PI
		
		else:
			
			rpc_unreliable("setPositionBlue",Vector2(global_position.x , global_position.y))
			
			var angle_mouse = get_global_mouse_position().angle_to_point(global_position)
			
			$arrow_line.set_point_position(1,(to_local(get_global_mouse_position())/1.5))
			
			$arrow_end.global_position = get_global_mouse_position()
			
			$arrow_end.global_rotation = angle_mouse-PI
		
	pass


func _on_spell_shield_hitbox_body_exited(Body):
	Body.modulate = Color(1,1,1)
	selected = null



func _on_spell_shield_hitbox_body_entered(body):
	if team == "red":
		if body.is_in_group("Character_red") && selected == null:
			var Body = body
			selected = body
			body.modulate = Color(1.4,1.4,1.4)
	else:
		if body.is_in_group("Character_blue") && selected == null:
			var Body = body
			selected = body
			body.modulate = Color(1.4,1.4,1.4)	



puppet func setPositionRed(pos):
	global_position = pos

master func setPositionBlue(pos):
	global_position = pos

sync func _queue_free():
	queue_free()

