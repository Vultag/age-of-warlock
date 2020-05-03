extends AnimatedSprite

var selected_group = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	var angle_mouse = get_global_mouse_position().angle_to_point(global_position)
	
	$arrow_line.set_point_position(1,(to_local(get_global_mouse_position())/1.5))
	
	$arrow_end.global_position = get_global_mouse_position()
	
	$arrow_end.global_rotation = angle_mouse-3.14159
	
	pass


func _on_hitbox_click_body_entered(body):
	body._get_divine_shield()
	queue_free()


func _on_spell_shield_hitbox_body_entered(body):
	if body.is_in_group("Character_red"):
		var Body = body
		selected_group = Body
		#Body.spell_mass_shield_selected = true
		body.modulate = Color(1.6,1.6,1.6)


func _on_spell_shield_hitbox_body_exited(body):
	body.modulate = Color(1,1,1)
