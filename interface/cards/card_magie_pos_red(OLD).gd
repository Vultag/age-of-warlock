extends Position2D


var stop = false
var mouse_in = false
var return_card = Vector2()
var card_position
var spawned = false
var retrograde
var card_just_played = false
#var card_just_played_stop = false
#var Main = get_parent().get_parent()
const card_magie_playing_load = preload("res://interface/cards/card_magie_playing_red.tscn")
const fire_load = preload("res://Magie/fire.tscn")
const frost_load = preload("res://Magie/frost.tscn")

"""
func _process(_delta):
	
	if stop == false:
		if get_node("card_magie"):
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
			if global_position.y<700 && get_parent().get_parent().get_node("Card_playing").get_child_count()>=1 && get_parent().get_parent().get_parent().has_node(str(globals.playerHostId)):
				if !get_parent().get_parent().get_node("Card_playing").spell_active.has(get_node("card_magie").get_node("icons").get_animation()):
					
					if card_position != get_parent().get_parent().card_number:
						get_parent().retrograde = true
					else :
						get_parent().card_just_played = true
					
					var card_magie_playing = card_magie_playing_load.instance()
					get_parent().card_played = card_position
					get_parent().get_parent().card_number-=1
					get_parent().card_dragged = false
					get_parent().get_parent().get_node("Card_playing").add_child(card_magie_playing,true)
					card_magie_playing.get_node("icon").play(get_node("card_magie").get_node("icons").get_animation())
					get_parent().get_parent().get_node("Card_playing").spell_active.insert( get_parent().get_parent().get_node("Card_playing").spell_active.size(), get_node("card_magie").get_node("icons").get_animation() )
					card_magie_playing.add_to_group(get_node("card_magie").get_node("icons").get_animation())
					_activate_spell(card_magie_playing)
					queue_free()
				else:
					get_parent().card_dragged = false
					set_global_position(return_card)
			elif global_position.y<700 && get_parent().get_parent().get_node("Card_playing").get_child_count()==0  && get_parent().get_parent().get_parent().has_node(str(globals.playerHostId)):
				#if get_parent().get_parent().get_node("Card_playing").get_node("card_magie_playing").get_node("icon").get_animation() != get_node("card_magie").get_node("icons").get_animation():
				
					#get_parent().get_parent().card_number-=1
					#get_parent().check_card_num = true
					#if card_position>1:
					#get_parent().retrograde = true
					if card_position != get_parent().get_parent().card_number:
						get_parent().retrograde = true
						#get_parent().get_parent().card_number-=1
					else :
						get_parent().card_just_played = true
					var card_magie_playing = card_magie_playing_load.instance()
					get_parent().card_played = card_position
					get_parent().get_parent().card_number-=1
					get_parent().card_dragged = false
					get_parent().get_parent().get_node("Card_playing").add_child(card_magie_playing,true)
					card_magie_playing.get_node("icon").play(get_node("card_magie").get_node("icons").get_animation())
					card_magie_playing.add_to_group(get_node("card_magie").get_node("icons").get_animation())
					get_parent().get_parent().get_node("Card_playing").spell_active.insert( get_parent().get_parent().get_node("Card_playing").spell_active.size(), get_node("card_magie").get_node("icons").get_animation() )
					card_magie_playing.selected = true # cause nodes rpc to break 
					_activate_spell(card_magie_playing)
					queue_free()
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
	if get_parent().card_dragged == false:
		mouse_in = false



func _on_AnimationPlayer_animation_finished(any):
	stop = true
	return_card=get_global_position()
	get_parent().check_card_num = false
	#card_just_played = false

func _activate_spell(spell_card):
	if spell_card.is_in_group("fire"):
		var Wizard = get_parent().get_parent().get_parent().get_node(str(globals.playerHostId))
		var fire = fire_load.instance()
		Wizard.add_child(fire)
		Wizard.get_node("fire").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("fire").set_emitting(false)
		Wizard.get_node("fire").active = false
		Wizard.has_fire = true
		Wizard.switch_fire == 0
		Wizard.fire = Wizard.get_node("fire")
		get_parent().get_parent().get_parent().rpc("_add_fire_red")
	if spell_card.is_in_group("frost"):
		var Wizard = get_parent().get_parent().get_parent().get_node(str(globals.playerHostId))
		var frost = frost_load.instance()
		Wizard.add_child(frost)
		Wizard.get_node("frost").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("frost").set_emitting(false)
		Wizard.get_node("frost").active = false
		Wizard.has_frost = true
		Wizard.switch_frost == 0
		Wizard.fire = Wizard.get_node("frost")
		get_parent().get_parent().get_parent().rpc("_add_frost_red")



"""
