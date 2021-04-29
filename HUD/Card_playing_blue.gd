extends Node2D


var pos_card = [Vector2(1250,110),Vector2(1400,110),Vector2(1550,110),Vector2(1700,110),Vector2(1850,110)]


var slot_free = [true,true,true,true,true]


var slot = [null,null,null,null,null]


var card_selected
var card_selected_bool

var Wizard

var spell_active = []

func _ready():
	pass

func _process(_delta):
	
	if get_parent().get_parent().has_node(str(globals.playerJoinId)):
		Wizard = get_parent().get_parent().get_node(str(globals.playerJoinId))
	
	
	if Input.is_action_just_pressed("e"):
		if  card_selected == slot[0]: 
			if slot[1] != null:
				_reatrubute_slot(1)
			elif slot[2] != null:
				_reatrubute_slot(2)
			elif slot[3] != null:
				_reatrubute_slot(3)
			elif slot[4] != null:
				_reatrubute_slot(4)
		elif  card_selected == slot[1]: 
			if slot[2] != null:
				_reatrubute_slot(2)
			elif slot[3] != null:
				_reatrubute_slot(3)
			elif slot[4] != null:
				_reatrubute_slot(4)
		elif  card_selected == slot[2]: 
			if slot[3] != null:
				_reatrubute_slot(3)
			elif slot[4] != null:
				_reatrubute_slot(4)
		elif  card_selected == slot[3]: 
			if slot[4] != null:
				_reatrubute_slot(4)

	
	if Input.is_action_just_pressed("a"):
		if  card_selected == slot[0]: 
			pass
		elif  card_selected == slot[1]: 
			if slot[0] != null:
				_reatrubute_slot(0)
		elif  card_selected == slot[2]: 
			if slot[1] != null:
				_reatrubute_slot(1)
			elif slot[0] != null:
				_reatrubute_slot(0)
		elif  card_selected == slot[3]: 
			if slot[2] != null:
				_reatrubute_slot(2)
			elif slot[1] != null:
				_reatrubute_slot(1)
			elif slot[0] != null:
				_reatrubute_slot(0)
		elif  card_selected == slot[4]: 
			if slot[3] != null:
				_reatrubute_slot(3)
			elif slot[2] != null:
				_reatrubute_slot(2)
			elif slot[1] != null:
				_reatrubute_slot(1)
			elif slot[0] != null:
				_reatrubute_slot(0)


func _reatrubute_slot(Slot):
	
	card_selected.selected = false
	card_selected.scale = Vector2(1,1)
	Wizard.switch_fire = 0
	Wizard.switch_frost = 0
	Wizard.casting = false
	Wizard.get_node("Wizard_arm").play("static")
	var Wizard_spells = Wizard.Spell_spawn_point.get_children()
	
	if Wizard.has_node("fire"):
		Wizard.get_node("fire").active = false
		Wizard.get_node("fire").set_emitting(false)
	if Wizard.has_node("frost"):
		Wizard.get_node("frost").active = false
		Wizard.get_node("frost").set_emitting(false)
		
	for Node2D in Wizard_spells:
		#print(Node2D.get_groups())
		if Node2D.is_in_group("Spell"):
			Node2D.rpc("_queue_free")
	
	
	slot[Slot].selected = true
	slot[Slot].scale = Vector2(1.5,1.5)
	card_selected = slot[Slot]


func update_card_sprite(Spell):
	
	match Spell:
		"fireball":
			card_selected.get_node("icon").frame += 1
		"frostball":
			card_selected.get_node("icon").frame += 1
		"shield":
			card_selected.get_node("icon").frame += 1




func _card_just_used(card_just_used_pos):
	if has_node("card_magie_playing"):
		for Node2D in get_children():
			if card_just_used_pos < Node2D.card_order:
				Node2D._retrograde()
