extends Position2D


var stop = false
var mouse_in = false
var return_card = Vector2()
var card_position
var spawned = false
var retrograde
var card_just_played = false
#var card_just_played_stop = false
const spearman_card_playing_load = preload("res://interface/cards/spectral_spearman/spearman_card_playing.tscn")


func _process(_delta):

	if stop == false:
		if get_node("spearman_card"):
			get_parent().check_card_num = true
			spawned = true
			if get_parent().get_parent().card_number==1:
				$AnimationPlayer.play("navigate")
				stop = true
				card_position=1
			if get_parent().get_parent().card_number==2:
				$AnimationPlayer.play("navigate_2c")
				stop = true
				card_position=2
			if get_parent().get_parent().card_number==3:
				$AnimationPlayer.play("navigate_3c")
				stop = true
				card_position=3
			if get_parent().get_parent().card_number==4:
				$AnimationPlayer.play("navigate_4c")
				stop = true
				card_position=4
			if get_parent().get_parent().card_number==5:
				$AnimationPlayer.play("navigate_5c")
				stop = true
				card_position=5
			if get_parent().get_parent().card_number==6:
				$AnimationPlayer.play("navigate_6c")
				stop = true
				card_position=6

	if mouse_in == true:

		if Input.is_action_pressed("Souris_left"):
			global_position = get_global_mouse_position()
			get_parent().card_dragged = true

		if Input.is_action_just_released("Souris_left"):
			if global_position.y<700:
				#get_parent().get_parent().card_number-=1
				#get_parent().check_card_num = true
				#if card_position>1:
				#get_parent().retrograde = true
				if card_position != get_parent().get_parent().card_number:
					get_parent().retrograde = true
					#get_parent().get_parent().card_number-=1
				else :
					get_parent().card_just_played = true
				#get_parent().card_just_played = true
				get_parent().card_played = card_position
				#get_parent().card_just_played = true
				get_parent().get_parent().card_number-=1
				#print (get_parent().get_parent().card_number)
				get_parent().card_dragged = false
				queue_free()
				#warrior_card_playing = warrior_card_playing_load.instance()
				if get_parent().get_parent().get_node("Card_playing").has_node("spearman_card_playing"):
					get_parent().get_parent().get_node("Card_playing").get_node("spearman_card_playing").card_added = true
				else:
					get_parent().get_parent().get_node("Card_playing").add_child(spearman_card_playing_load.instance())
			else:
				get_parent().card_dragged = false
				set_global_position(return_card)

	if get_parent().check_card_num == true:

		if spawned == false:
			pass
		else:
			#if card_position ==1:
				#$AnimationPlayer.play("navigate")

			if get_parent().get_parent().card_number==2:
				if card_position ==1:
					$AnimationPlayer.play("slide_right_2c")

			if get_parent().get_parent().card_number==3:
				if card_position ==1:
					$AnimationPlayer.play("slide_right_3c")
				if card_position ==2:
					$AnimationPlayer.play("played_slide_1c_left")
				if card_position ==3:
					$AnimationPlayer.play("navigate_3c")

			if get_parent().get_parent().card_number==4:
				if card_position ==1:
					$AnimationPlayer.play("slide_right_4c")
				if card_position ==2:
					$AnimationPlayer.play("slide_right_2c")
				if card_position ==3:
					$AnimationPlayer.play("played_slide_2c_left")
				if card_position ==4:
					$AnimationPlayer.play("navigate_4c")

			if get_parent().get_parent().card_number==5:
				if card_position ==1:
					$AnimationPlayer.play("slide_right_5c")
				if card_position ==2:
					$AnimationPlayer.play("slide_right_3c")
				if card_position ==3:
					$AnimationPlayer.play("played_slide_1c_left")
				if card_position ==4:
					$AnimationPlayer.play("played_slide_3c_left")
				if card_position ==5:
					$AnimationPlayer.play("navigate_5c")

			if get_parent().get_parent().card_number==6:
				if card_position ==1:
					$AnimationPlayer.play("slide_right_6c")
				if card_position ==2:
					$AnimationPlayer.play("slide_right_4c")
				if card_position ==3:
					$AnimationPlayer.play("slide_right_2c")
				if card_position ==4:
					$AnimationPlayer.play("played_slide_2c_left")
				if card_position ==5:
					$AnimationPlayer.play("played_slide_4c_left")




	if card_just_played == true:


		if get_parent().get_parent().card_number == 1:
			if card_position>=get_parent().card_played:
				$AnimationPlayer.play("played_slide_1c_left")
				card_just_played = false
			if card_position<get_parent().card_played:
				$AnimationPlayer.play_backwards("slide_right_2c")
				card_just_played = false

		if get_parent().get_parent().card_number == 2:
			if card_position == 2:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_2c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("played_slide_1c_left")
					card_just_played = false

			if card_position == 1:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("slide_right_2c")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_3c")
					card_just_played = false

		if get_parent().get_parent().card_number == 3:
			if card_position == 3:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_3c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("played_slide_2c_left")
					card_just_played = false
			if card_position == 2:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_1c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_2c")
					card_just_played = false
			if card_position == 1:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("slide_right_3c")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_4c")
					card_just_played = false

		if get_parent().get_parent().card_number == 4:
			if card_position == 4:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_4c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("played_slide_3c_left")
					card_just_played = false
			if card_position == 3:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_2c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("played_slide_1c_left")
					card_just_played = false
			if card_position == 2:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("slide_right_2c")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_3c")
					card_just_played = false
			if card_position == 1:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("slide_right_4c")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_5c")
					card_just_played = false

		if get_parent().get_parent().card_number == 5:
			if card_position == 5:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_5c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("played_slide_4c_left")
					card_just_played = false
			if card_position == 4:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_3c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("played_slide_2c_left")
					card_just_played = false
			if card_position == 3:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("played_slide_1c_left")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_2c")
					card_just_played = false
			if card_position == 2:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("slide_right_3c")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_4c")
					card_just_played = false
			if card_position == 1:
				if card_position>=get_parent().card_played:
					$AnimationPlayer.play("slide_right_5c")
					card_just_played = false
				if card_position<get_parent().card_played:
					$AnimationPlayer.play_backwards("slide_right_6c")
					card_just_played = false




	if retrograde == true:

		if card_position>get_parent().card_played:
			card_position -=1
			retrograde = false
			get_parent().card_just_played = true
		else:
			retrograde = false
			get_parent().card_just_played = true



func _on_Area2D_mouse_entered():
	if get_parent().card_dragged == false:
		mouse_in = true


func _on_Area2D_mouse_exited():
	mouse_in = false


func _on_cards_navigate_animation_finished():
	stop = true
	return_card=get_global_position()
	get_parent().check_card_num = false
	#card_just_played = false
