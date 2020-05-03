extends Position2D


var stop = false
var mouse_in = false
var return_card = Vector2()


func _process(delta):
	
	if stop == false:
		if get_node("warrior_card"):
			$AnimationPlayer.play("navigate_2c")
			stop = true
	
	if mouse_in == true:
		if Input.is_action_pressed("Souris_left"):
			global_position = get_global_mouse_position()
		
		if Input.is_action_just_released("Souris_left"):
			if global_position.y<700:
				$warrior_card.queue_free()
				get_parent().get_parent().card_number-=1
				get_parent().check_card_num = true
			else:
				set_global_position(return_card)
	
	
	if get_parent().check_card_num == true:
		
		#if get_parent().get_parent().card_number==2:
			#$AnimationPlayer.play("navigate_2c")
			#get_parent().check_card_num = false
		
		if get_parent().get_parent().card_number==3:
			$AnimationPlayer.play("slide_right_2c")
			#get_parent().check_card_num = false
		
		if get_parent().get_parent().card_number==4:
			$AnimationPlayer.play("slide_right_3c")
			#get_parent().check_card_num = false
		
		if get_parent().get_parent().card_number==5:
			$AnimationPlayer.play("slide_right_4c")
			#get_parent().check_card_num = false
		
		if get_parent().get_parent().card_number==6:
			$AnimationPlayer.play("slide_right_5c")
			#get_parent().check_card_num = false
	

func _on_AnimationPlayer_animation_finished(any):
	stop = true
	return_card=get_global_position()
	get_parent().check_card_num = false


func _on_Area2D_mouse_entered():
	mouse_in = true


func _on_Area2D_mouse_exited():
	mouse_in = false
