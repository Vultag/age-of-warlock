extends Area2D


var tir_mouv= Vector2()
var team



func _ready():
	if team == "red":
		$AnimatedSprite.play("red")
		set_collision_mask_bit(2,true)
		
	else:
		$AnimatedSprite.play("blue")
		set_collision_mask_bit(1,true)
		





func _physics_process(delta):
	
	
	look_at(get_global_position()+tir_mouv)
	
	translate(tir_mouv)
	
	pass



func _on_tir_tour_body_entered(body):
	if is_network_master():
		if team == "red":
			if body.is_in_group("Character_blue"):
				body._take_damage(0.4,Vector2(0,0))
				rpc("_queue_free")
			else:
				rpc("_queue_free")
		else:
			if body.is_in_group("Character_red"):
				body._take_damage(0.4,Vector2(0,0))
				rpc("_queue_free")
			else:
				rpc("_queue_free")



sync func _queue_free():
	queue_free()



