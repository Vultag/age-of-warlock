extends Node2D

var Spell
var new_spell
var charge

var number
var mouse_in = false

onready var Hud = get_parent()
onready var Main = get_parent().get_parent()

#var Pair_board = [Vector2(825,820),Vector2(975,820),Vector2(675,820),Vector2(1125,820),Vector2(1275,820),Vector2(525,820)]
var Pair_board = [Vector2(525,820),Vector2(675,820),Vector2(825,820),Vector2(975,820),Vector2(1125,820),Vector2(1275,820)]
var Impair_board = [Vector2(600,820),Vector2(750,820),Vector2(900,820),Vector2(1050,820),Vector2(1200,820)]

const card_magie_playing_red_load = preload("res://interface/cards/card_magie_playing_red.tscn")
const card_magie_playing_blue_load = preload("res://interface/cards/card_magie_playing_blue.tscn")
const fire_load = preload("res://Magie/fire.tscn")
const frost_load = preload("res://Magie/frost.tscn")


func _ready():
	
	position = Vector2(900,250)
	
	randomize()
	#new_spell = randi() % 6
	Hud.Spell_available.shuffle()
	new_spell = Hud.Spell_available[0]
	
	#_navigate(Vector2(400,400))
	
	match new_spell:
		0:
			Spell = "fire"
			$icons.play("fire")
			self.add_to_group("fire")
		1:
			Spell = "frost"
			$icons.play("frost")
			self.add_to_group("frost")
		2:
			Spell = "fireball"
			$icons.play("fireball")
			self.add_to_group("fireball")
		3:
			Spell = "frostball"
			$icons.play("frostball")
			self.add_to_group("frostball")
		4:
			Spell = "shield"
			$icons.play("shield")
			self.add_to_group("shield")
		5:
			Spell = "mass_shield"
			$icons.play("mass_shield")
			self.add_to_group("mass_shield")
		
	

func _process(_delta):
	
	if mouse_in == true:
		if Input.is_action_pressed("Souris_left"):
			global_position = get_global_mouse_position()
			Hud.card_dragged = true
			$Tween.stop_all()
		if Input.is_action_just_released("Souris_left"):
			if global_position.y<700 && Hud.get_node("Card_playing").get_child_count()>=1 && Main.has_node(str(globals.playerHostId)):
				if !Hud.get_node("Card_playing").spell_active.has(self.get_node("icons").get_animation()):
					
					Hud.mouse_in_card = false
					
					if number != Hud.card_number:
						Hud._retrograde(number)
					else :
						pass
					
					Hud.card_active.remove(Hud.card_active.find(self))
					
					var card_magie_playing
					
					if get_parent().get_network_master() != 1:
						card_magie_playing = card_magie_playing_blue_load.instance()
					else:
						card_magie_playing = card_magie_playing_red_load.instance()
					
					
					Hud.card_number-=1
					Hud.card_dragged = false
					card_magie_playing.add_to_group(self.get_node("icons").get_animation())
					card_magie_playing.Spell = (self.get_node("icons").get_animation())
					Hud.get_node("Card_playing").add_child(card_magie_playing,true)
					card_magie_playing.get_node("icon").play(self.get_node("icons").get_animation())
					Hud.get_node("Card_playing").spell_active.insert( Hud.get_node("Card_playing").spell_active.size(), self.get_node("icons").get_animation() )
					_activate_spell(card_magie_playing,get_parent().get_network_master())
					queue_free()
				else:
					Hud.mouse_in_card = false
					mouse_in = false
					Hud.card_dragged = false
					_navigate(number,Hud.card_number)
			elif global_position.y<700 && Hud.get_node("Card_playing").get_child_count()==0  && Main.has_node(str(globals.playerHostId)):
				#if get_parent().get_parent().get_node("Card_playing").get_node("card_magie_playing").get_node("icon").get_animation() != self.get_node("icons").get_animation():
				
					Hud.mouse_in_card = false
					
					if number != Hud.card_number:
						Hud._retrograde(number)
					else :
						pass
					
					var card_magie_playing
					
					if get_parent().get_network_master() != 1:
						card_magie_playing = card_magie_playing_blue_load.instance()
					else:
						card_magie_playing = card_magie_playing_red_load.instance()
					
					Hud.card_active.remove(Hud.card_active.find(self))
					
					Hud.card_number-=1
					Hud.card_dragged = false
					card_magie_playing.add_to_group(self.get_node("icons").get_animation())
					card_magie_playing.Spell = (self.get_node("icons").get_animation())
					Hud.get_node("Card_playing").add_child(card_magie_playing,true)
					card_magie_playing.get_node("icon").play(self.get_node("icons").get_animation())
					Hud.get_node("Card_playing").spell_active.insert( Hud.get_node("Card_playing").spell_active.size(), self.get_node("icons").get_animation() )
					Hud.get_node("Card_playing").card_selected = card_magie_playing
					Hud.get_node("Card_playing").card_selected.scale = Vector2(1.5,1.5)
					card_magie_playing.selected = true # cause nodes rpc to break 
					_activate_spell(card_magie_playing,get_parent().get_network_master())
					queue_free()
			else:
				Hud.card_dragged = false
				Hud.mouse_in_card = false
				mouse_in = false
				_navigate(number,Hud.card_number)
	
	
	pass


func _navigate(num_card,nb_card):
	
	
	if nb_card % 2 == 0:
		if nb_card == 6:
			$Tween.interpolate_property(self, "global_position",global_position,Pair_board[num_card-(nb_card-5)], 1.8,$Tween.TRANS_LINEAR ,$Tween.EASE_OUT_IN )
		else:
			$Tween.interpolate_property(self, "global_position",global_position,Pair_board[num_card-((nb_card-5)/2)], 1.8,$Tween.TRANS_LINEAR ,$Tween.EASE_OUT_IN )
	else:
		if nb_card == 5:
			$Tween.interpolate_property(self, "global_position",global_position,Impair_board[num_card-(nb_card-4)], 1.8,$Tween.TRANS_LINEAR ,$Tween.EASE_OUT_IN)
		else:
			$Tween.interpolate_property(self, "global_position",global_position,Impair_board[num_card-((nb_card-4)/2)], 1.8,$Tween.TRANS_LINEAR ,$Tween.EASE_OUT_IN)
	
	$Tween.start()


func _on_Area2D_mouse_entered():
	if Hud.mouse_in_card == false && mouse_in == false:
		Hud.mouse_in_card = true
		mouse_in = true
		z_index = 1
	$AnimationPlayer.play("mouse_over",-1,1,false)


func _on_Area2D_mouse_exited():
	if Hud.mouse_in_card == true && mouse_in == true:
		Hud.mouse_in_card = false
		mouse_in = false
		z_index = 0
	$AnimationPlayer.play("mouse_over",-1,-1,true)



func _activate_spell(spell_card,wiz_id):
	
	
	if spell_card.is_in_group("fire"):
		"""
		var Wizard = Main.get_node(str(wiz_id))
		var fire = fire_load.instance()
		Wizard.add_child(fire)
		Wizard.get_node("fire").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("fire").set_emitting(false)
		Wizard.get_node("fire").active = false
		Wizard.has_fire = true
		Wizard.switch_fire == 0
		"""
		if wiz_id == 1:
			Main.rpc("_add_fire_red")
		else:
			Main.rpc("_add_fire_blue")
		
		
		#Main.rpc("_add_fire_red")
	if spell_card.is_in_group("frost"):
		"""
		var Wizard = Main.get_node(str(wiz_id))
		var frost = frost_load.instance()
		Wizard.add_child(frost)
		Wizard.get_node("frost").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("frost").set_emitting(false)
		Wizard.get_node("frost").active = false
		Wizard.has_frost = true
		Wizard.switch_frost == 0
		Wizard.fire = Wizard.get_node("frost")
		"""
		if wiz_id == 1:
			Main.rpc("_add_frost_red")
		else:
			Main.rpc("_add_frost_blue")
		
		




