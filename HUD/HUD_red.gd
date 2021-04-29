extends CanvasLayer

var crystal_num = 0
var exp_num = 0
var gain = 10
var first_digit
var second_digit
var third_digit
#var warrior_card
#var card_pos
var card_number = 0
var card_active = []
var card_not_activated = [0,1,2,3,4,100,101,102,103,104,105]
var perks_not_activated = [0,1]
var Spell_available = []
var card_picked
var perk_picked

var has_homing_missile = false
var has_bigger_shield = "shield"


var card_dragged = false
var mouse_in_card =false
var mouse_in = false

onready var card_magie_load = preload("res://interface/cards/card_magie.tscn")

func _ready():
	pass
	card_not_activated.shuffle()


func _process(delta):
	
	
	crystal_num += (gain*delta)
	
	
	first_digit=crystal_num
	
	
	while (first_digit >= 10 && first_digit < 100):
		first_digit /= 10;
	
	while (first_digit >= 100):
		first_digit /= 100;
	
	second_digit = crystal_num
	
	
	while (second_digit >= 10 && second_digit < 100):
		second_digit -= 10;
	
	while (second_digit >= 100):
		second_digit = (second_digit/10)
	while second_digit>=10:
		second_digit-=10
	
	
	third_digit = crystal_num
	
	while (third_digit >= 10):
		third_digit -= 10;
	
	
	if (crystal_num>=10):
		$number_crystal/number_l2.play("default")
		$number_crystal/number_l2.set_frame(second_digit)
	else:$number_crystal/number_l2.play("off")
	
	
	if (crystal_num>=100):
		$number_crystal/number_l3.play("default")
		$number_crystal/number_l3.set_frame(third_digit)
	else:$number_crystal/number_l3.play("off")
	
	
	$number_crystal/number_l1.set_frame(first_digit)

	
	if(mouse_in == true):
		if crystal_num>=5 && !Spell_available.empty():
			if card_number<6:
				if Input.is_action_just_pressed("Souris_left"):
					crystal_num -= 5
					change_exp(5)
					$number_crystal/number_exp/exp_barre.value = exp_num
					$number_crystal/number_exp/exp_text.set_text(String("/100"))
					card_number+=1
					_load_card()
					
					for card in card_active:
						card._navigate(card.number,card_number)
					#get_node("Card_borad").load_card = true
				
	
	if $life_portal_red/life.value <= 0 or $life_portal_blue/life.value <=0 :
		get_parent().rpc("_quit_game")
	
	


func _on_Area2D_mouse_entered():
	if crystal_num>=5:
		$number_crystal/chest.play("open")
	mouse_in = true
		

func _on_Area2D_mouse_exited():
	$number_crystal/chest.play("closed")
	mouse_in = false

func _load_card():
	var card_magie = card_magie_load.instance()
	add_child(card_magie,true)
	card_active.insert(card_active.size(),card_magie)
	card_magie._navigate(card_number,card_number)
	card_magie.number = card_number


func _retrograde(card_played):
	for card in card_active:
		if card.number > card_played:
			card.number -= 1
		card._navigate(card.number,card_number-1)


func change_exp(num):
	if exp_num + num < 100:
		exp_num += num*7
		$number_crystal/number_exp/exp_barre.value = exp_num
		$number_crystal/number_exp/exp_text.set_text(String("/100"))
	else:
		exp_num -= 100
		lvl_up(true,null)

func lvl_up(activation,type):
	
	if activation == true:
		
		card_picked = false
		perk_picked = false
		
		if card_not_activated.size() >= 3:
			$lvl_up/unlock_2.visible = true
			$lvl_up/unlock_1.visible = true
			$lvl_up/unlock_3.visible = true
			$lvl_up/unlock_1.set_frame(card_not_activated[0])
			$lvl_up/unlock_2.set_frame(card_not_activated[1])
			$lvl_up/unlock_3.set_frame(card_not_activated[2])
		elif card_not_activated.size() == 2:
			$lvl_up/unlock_1.visible = true
			$lvl_up/unlock_2.visible = false
			$lvl_up/unlock_3.visible = true
			$lvl_up/unlock_1.set_frame(card_not_activated[0])
			$lvl_up/unlock_3.set_frame(card_not_activated[1])
		elif card_not_activated.size() == 1:
			$lvl_up/unlock_2.visible = true
			$lvl_up/unlock_2.set_frame(card_not_activated[0])
			$lvl_up/unlock_1.visible = false
			$lvl_up/unlock_3.visible = false
		elif card_not_activated.size() == 0:
			card_picked = true
			$lvl_up/unlock_2.visible = false
			$lvl_up/unlock_1.visible = false
			$lvl_up/unlock_3.visible = false
		
		if perks_not_activated.size() >= 3:
			$lvl_up/perk_1.visible = true
			$lvl_up/perk_2.visible = true
			$lvl_up/perk_3.visible = true
			$lvl_up/perk_1.set_frame(perks_not_activated[0])
			$lvl_up/perk_2.set_frame(perks_not_activated[1])
			$lvl_up/perk_3.set_frame(perks_not_activated[2])
		elif perks_not_activated.size() == 2:
			$lvl_up/perk_1.visible = true
			$lvl_up/perk_3.visible = true
			$lvl_up/perk_2.visible = false
			$lvl_up/perk_1.set_frame(perks_not_activated[0])
			$lvl_up/perk_3.set_frame(perks_not_activated[1])
		elif perks_not_activated.size() == 1:
			$lvl_up/perk_2.visible = true
			$lvl_up/perk_2.set_frame(perks_not_activated[0])
			$lvl_up/perk_1.visible = false
			$lvl_up/perk_3.visible = false
		elif perks_not_activated.size() == 0:
			perk_picked = true
			$lvl_up/perk_1.visible = false
			$lvl_up/perk_2.visible = false
			$lvl_up/perk_3.visible = false
		
		if card_not_activated.size() == 0 && perks_not_activated.size() == 0:
			pass
		else:
			$lvl_up.visible = true
		
	else:
		
		if type == "card":
			card_picked = true
		if type == "perk":
			perk_picked = true
		
		if card_picked == true:
			$lvl_up/unlock_2.visible = false
			$lvl_up/unlock_1.visible = false
			$lvl_up/unlock_3.visible = false
		if perk_picked == true:
			$lvl_up/perk_1.visible = false
			$lvl_up/perk_2.visible = false
			$lvl_up/perk_3.visible = false
		
		if card_picked == true && perk_picked == true:
			$lvl_up.visible = false


func _on_Button_unlock_1_pressed():
	activate_unit($lvl_up/unlock_1.get_frame())
	#card_not_activated.remove(0)
	card_not_activated.remove(card_not_activated.find($lvl_up/unlock_1.get_frame()))
	lvl_up(false,"card")


func _on_Button_unlock_2_pressed():
	activate_unit($lvl_up/unlock_2.get_frame())
	#card_not_activated.remove(1)
	card_not_activated.remove(card_not_activated.find($lvl_up/unlock_2.get_frame()))
	lvl_up(false,"card")


func _on_Button_unlock_3_pressed():
	activate_unit($lvl_up/unlock_3.get_frame())
	#card_not_activated.remove(2)
	card_not_activated.remove(card_not_activated.find($lvl_up/unlock_3.get_frame()))
	lvl_up(false,"card")


func activate_unit(id):
	match id:
		0:
			$number_crystal/icon_warrior.visible = true
		1:
			$number_crystal/icon_spear.visible = true
		2:
			$number_crystal/icon_ranger.visible = true
		3:
			$number_crystal/icon_bat.visible = true
		4:
			$number_crystal/icon_eye.visible = true
		100:
			Spell_available.insert(Spell_available.size(),0)
		101:
			Spell_available.insert(Spell_available.size(),1)
		102:
			Spell_available.insert(Spell_available.size(),2)
		103:
			Spell_available.insert(Spell_available.size(),3)
		104:
			Spell_available.insert(Spell_available.size(),4)
		105:
			Spell_available.insert(Spell_available.size(),5)


func activate_perk(id):
	match id:
		0:
			get_parent().get_node(str(globals.playerHostId)).has_homing_missile = true
			has_homing_missile = true
		1:
			#get_parent().get_node(str(globals.playerHostId)).has_bigger_shield = true
			get_parent().get_node(str(globals.playerHostId)).Shield = "bigger_shield"
			has_bigger_shield = "bigger_shield"





func _on_Button_perk_1_pressed():
	activate_perk($lvl_up/perk_1.get_frame())
	perks_not_activated.remove(perks_not_activated.find($lvl_up/perk_1.get_frame()))
	lvl_up(false,"perk")


func _on_Button_perk_2_pressed():
	activate_perk($lvl_up/perk_2.get_frame())
	perks_not_activated.remove(perks_not_activated.find($lvl_up/perk_2.get_frame()))
	lvl_up(false,"perk")

func _on_Button_perk_3_pressed():
	activate_perk($lvl_up/perk_3.get_frame())
	perks_not_activated.remove(perks_not_activated.find($lvl_up/perk_3.get_frame()))
	lvl_up(false,"perk")


func _on_grimoire_mouse_entered():
	$grimoire/AnimationPlayer.play("hover")


func _on_grimoire_mouse_exited():
	$grimoire/AnimationPlayer.play_backwards("hover")
