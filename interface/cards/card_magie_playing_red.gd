extends Node2D

var Spell

var charge_fireball = 3
var charge_frostball = 3
var charge_shield = 3
var charge_mass_shield = 1
var charge_num_fire = 100
var charge_num_frost = 100
var selected
var slot = 0  
var card_order
var retrograde = false

var first_digit
var second_digit
var third_digit

var Wizard

onready var Hud_playing = get_parent()


func _ready():
	
	if is_in_group("fire") or is_in_group("frost"):
		$number_down_1.visible = true
		$number_down_2.visible = true
		$number_down_3.visible = true
		$Label.visible = true
	
	
	#Spell = $icon.get_animation()
	
	slot = Hud_playing.slot.find(null,0)
	
	Hud_playing.slot[slot] = self
	
	card_order = slot
	
	position = Hud_playing.pos_card[slot]
	
	Hud_playing.slot_free[slot] = false
	


# warning-ignore:unused_argument
func _process(delta):
	
	if get_parent().get_parent().get_parent().has_node(str(globals.playerHostId)):
		Wizard = get_parent().get_parent().get_parent().get_node(str(globals.playerHostId))
	
	
	
	if selected == true :
		
		if charge_fireball == 0:
			_remove_spell("fireball")
		if charge_frostball == 0:
			_remove_spell("frostball")
		if charge_shield == 0:
			_remove_spell("shield")
		if charge_mass_shield == 0:
			_remove_spell("mass_shield")
		if charge_num_fire <= 0:
			_remove_spell("fire")
		if charge_num_frost <= 0:
			_remove_spell("frost")
		
		


func _remove_spell(spell):
	
	
	Hud_playing.slot[slot] = null
	
	
	#print (get_parent().slot)
	
	if get_parent().slot[0] != null:
		get_parent().slot[0].selected = true
		get_parent().slot[0].scale = Vector2(1.5,1.5)
		get_parent().card_selected = get_parent().slot[0]
	elif get_parent().slot[1] != null:
		get_parent().slot[1].selected = true
		get_parent().slot[1].scale = Vector2(1.5,1.5)
		get_parent().card_selected = get_parent().slot[1]
	elif get_parent().slot[2] != null:
		get_parent().slot[2].selected = true
		get_parent().slot[2].scale = Vector2(1.5,1.5)
		get_parent().card_selected = get_parent().slot[2]
	elif get_parent().slot[3] != null:
		get_parent().slot[3].selected = true
		get_parent().slot[3].scale = Vector2(1.5,1.5)
		get_parent().card_selected = get_parent().slot[3]
	elif get_parent().slot[4] != null:
		get_parent().slot[4].selected = true
		get_parent().slot[4].scale = Vector2(1.5,1.5)
		get_parent().card_selected = get_parent().slot[4]
	
	
	
	Hud_playing.slot_free[slot] = true
	
	Wizard.casting = false
	
	Wizard.get_node("Wizard_arm").play("static")
	
	
	if spell == "fire" or spell == "frost":
		
		print(Wizard.get_node(spell))
		
		Wizard.get_node(spell).get_node("Timer_quefree").start()
		Wizard.get_node(spell).emitting = false
		
		if spell == "fire":
			Wizard.has_fire = false
			Wizard.switch_fire = 0
		else:
			Wizard.has_frost = false
			Wizard.switch_frost = 0
		
		Hud_playing._card_just_used(self.slot)
		
		#self.remove_from_group(spell)
		
		Hud_playing.spell_active.remove(Hud_playing.spell_active.find($icon.get_animation(),0))
		
		Wizard.rpc("_remove_child",spell,Wizard.get_node(spell).global_position)
		
		queue_free()
	
	else:
		
		#self.remove_from_group(spell)
		
		Hud_playing._card_just_used(self.slot)
		
		queue_free()
		
		get_parent().spell_active.remove(get_parent().spell_active.find($icon.get_animation(),0))



func _retrograde():
	card_order -=1
	#slot -= 1











