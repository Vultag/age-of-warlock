extends Node2D

var pos_card_1 = Vector2(1250,110)
var pos_card_2 = Vector2(1400,110)
var pos_card_3 = Vector2(1550,110)
var pos_card_4 = Vector2(1700,110)
var pos_card_5 = Vector2(1850,110)

var slot1_free = true
var slot2_free = true
var slot3_free = true
var slot4_free = true
var slot5_free = true

var slot1
var slot2
var slot3
var slot4
var slot5

var card_just_used_pos
var card_just_used
var card_selected
var card_selected_bool

var spell_active = []

func _ready():
	pass

func _process(_delta):
	
	if card_just_used != null:
		if has_node("card_magie_playing"):
			get_child(0).retrograde = true
		else:
			card_just_used = null
	
	if Input.is_action_just_pressed("e"):
		if  card_selected == slot1 && slot2 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				slot2.selected = true
			if card_selected == slot2:
				slot3.selected = true
			if card_selected == slot3:
				slot4.selected = true
			if card_selected == slot4:
				slot5.selected = true
		if  card_selected == slot2 && slot3 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				slot2.selected = true
			if card_selected == slot2:
				slot3.selected = true
			if card_selected == slot3:
				slot4.selected = true
			if card_selected == slot4:
				slot5.selected = true
		if  card_selected == slot3 && slot4 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				slot2.selected = true
			if card_selected == slot2:
				slot3.selected = true
			if card_selected == slot3:
				slot4.selected = true
			if card_selected == slot4:
				slot5.selected = true
		if  card_selected == slot4 && slot5 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				slot2.selected = true
			if card_selected == slot2:
				slot3.selected = true
			if card_selected == slot3:
				slot4.selected = true
			if card_selected == slot4:
				slot5.selected = true


	
	if Input.is_action_just_pressed("a"):
		if  card_selected == slot2 && slot1 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				pass
			if card_selected == slot2:
				slot1.selected = true
			if card_selected == slot3:
				slot2.selected = true
			if card_selected == slot4:
				slot3.selected = true
			if card_selected == slot5:
				slot4.selected = true
		if  card_selected == slot3 && slot2 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				pass
			if card_selected == slot2:
				slot1.selected = true
			if card_selected == slot3:
				slot2.selected = true
			if card_selected == slot4:
				slot3.selected = true
			if card_selected == slot5:
				slot4.selected = true
		if  card_selected == slot4 && slot3 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				pass
			if card_selected == slot2:
				slot1.selected = true
			if card_selected == slot3:
				slot2.selected = true
			if card_selected == slot4:
				slot3.selected = true
			if card_selected == slot5:
				slot4.selected = true
		if  card_selected == slot5 && slot4 != null :
			card_selected.selected = false
			get_parent().get_parent().get_node("Wizard").switch_fire = 0
			get_parent().get_parent().get_node("Wizard").switch_frost = 0
			get_parent().get_parent().get_node("Wizard").casting = false
			get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fire")):
				get_parent().get_parent().get_node("Wizard").get_node("fire").active = false
				get_parent().get_parent().get_node("Wizard").get_node("fire").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("fire").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("fireball")):
				get_parent().get_parent().get_node("Wizard").get_node("fireball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frost")):
				get_parent().get_parent().get_node("Wizard").get_node("frost").active = false
				get_parent().get_parent().get_node("Wizard").get_node("frost").set_emitting(false)
				#get_parent().get_parent().get_node("Wizard").get_node("frost").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("frostball")):
				get_parent().get_parent().get_node("Wizard").get_node("frostball").queue_free()
			if is_instance_valid(get_parent().get_parent().get_node("Wizard").get_node("spell_shield")):
				get_parent().get_parent().get_node("Wizard").get_node("spell_shield").queue_free()
			if card_selected == slot1:
				pass
			if card_selected == slot2:
				slot1.selected = true
			if card_selected == slot3:
				slot2.selected = true
			if card_selected == slot4:
				slot3.selected = true
			if card_selected == slot5:
				slot4.selected = true
		
	
	pass





