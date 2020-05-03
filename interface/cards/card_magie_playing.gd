extends Node2D

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

func _ready():
	
	"""
	if self.is_in_group("fire"):
		pass
	"""
	
	#card_order = get_parent().get_child_count()
	
	#get_parent().get_parent().get_parent().get_node("Wizard").has_fire = true
	
	if get_parent().get_child_count() == 1:
		if get_parent().slot1_free == true:
			position = get_parent().pos_card_1
			get_parent().slot1_free = false
			slot = 1
			card_order = 1
		elif get_parent().slot2_free == true:
			position = get_parent().pos_card_2
			get_parent().slot2_free = false
			slot = 2
			card_order = 2
		elif get_parent().slot3_free == true:
			position = get_parent().pos_card_3
			get_parent().slot3_free = false
			slot = 3
			card_order = 3 
		elif get_parent().slot4_free == true:
			position = get_parent().pos_card_4
			get_parent().slot4_free = false
			slot = 4
			card_order = 4
		elif get_parent().slot5_free == true:
			position = get_parent().pos_card_5
			get_parent().slot5_free = false
			slot = 5
			card_order = 5
	
	if get_parent().get_child_count() == 2:
		if get_parent().slot1_free == true:
			position = get_parent().pos_card_1
			get_parent().slot1_free = false
			slot = 1
			card_order = 1
		elif get_parent().slot2_free == true:
			position = get_parent().pos_card_2
			get_parent().slot2_free = false
			slot = 2
			card_order = 2
		elif get_parent().slot3_free == true:
			position = get_parent().pos_card_3
			get_parent().slot3_free = false
			slot = 3
			card_order = 3
		elif get_parent().slot4_free == true:
			position = get_parent().pos_card_4
			get_parent().slot4_free = false
			slot = 4
			card_order = 4
		elif get_parent().slot5_free == true:
			position = get_parent().pos_card_5
			get_parent().slot5_free = false
			slot = 5
			card_order = 5
	
	if get_parent().get_child_count() == 3:
		if get_parent().slot1_free == true:
			position = get_parent().pos_card_1
			get_parent().slot1_free = false
			slot = 1
			card_order = 1
		elif get_parent().slot2_free == true:
			position = get_parent().pos_card_2
			get_parent().slot2_free = false
			slot = 2
			card_order = 2
		elif get_parent().slot3_free == true:
			position = get_parent().pos_card_3
			get_parent().slot3_free = false
			slot = 3
			card_order = 3
		elif get_parent().slot4_free == true:
			position = get_parent().pos_card_4
			get_parent().slot4_free = false
			slot = 4
			card_order = 4
		elif get_parent().slot5_free == true:
			position = get_parent().pos_card_5
			get_parent().slot5_free = false
			slot = 5
			card_order = 5
	
	if get_parent().get_child_count() == 4:
		if get_parent().slot1_free == true:
			position = get_parent().pos_card_1
			get_parent().slot1_free = false
			slot = 1
			card_order = 1
		elif get_parent().slot2_free == true:
			position = get_parent().pos_card_2
			get_parent().slot2_free = false
			slot = 2
			card_order = 2
		elif get_parent().slot3_free == true:
			position = get_parent().pos_card_3
			get_parent().slot3_free = false
			slot = 3
			card_order = 3
		elif get_parent().slot4_free == true:
			position = get_parent().pos_card_4
			get_parent().slot4_free = false
			slot = 4
			card_order = 4
		elif get_parent().slot5_free == true:
			position = get_parent().pos_card_5
			get_parent().slot5_free = false
			slot = 5
			card_order = 5
	
	if get_parent().get_child_count() == 5:
		if get_parent().slot1_free == true:
			position = get_parent().pos_card_1
			get_parent().slot1_free = false
			slot = 1
			card_order = 1
		elif get_parent().slot2_free == true:
			position = get_parent().pos_card_2
			get_parent().slot2_free = false
			slot = 2
			card_order = 2
		elif get_parent().slot3_free == true:
			position = get_parent().pos_card_3
			get_parent().slot3_free = false
			slot = 3
			card_order = 3
		elif get_parent().slot4_free == true:
			position = get_parent().pos_card_4
			get_parent().slot4_free = false
			slot = 4
			card_order = 4
		elif get_parent().slot5_free == true:
			position = get_parent().pos_card_5
			get_parent().slot5_free = false
			slot = 5
			card_order = 5


# warning-ignore:unused_argument
func _process(delta):
	
	
	if card_order == 1:
		get_parent().slot1 = self
	if card_order == 2:
		get_parent().slot2 = self
	if card_order == 3:
		get_parent().slot3 = self
	if card_order == 4:
		get_parent().slot4 = self
	if card_order == 5:
		get_parent().slot5 = self
		
	
	if retrograde == true && get_parent().card_just_used_pos < self.card_order:
		card_order -=1
		retrograde = false
		get_parent().card_just_used = null

	
	if selected == true:
		
		get_parent().card_selected = self
		
		self.scale = Vector2(1.5,1.5)
		
		if self.is_in_group("fire"):
			
			first_digit=charge_num_fire
			
			
			while (first_digit >= 10 && first_digit < 100):
				first_digit /= 10;
			
			while (first_digit >= 100):
				first_digit /= 100;
			
			second_digit = charge_num_fire
			
			
			while (second_digit >= 10 && second_digit < 100):
				second_digit -= 10;
			
			while (second_digit >= 100):
				second_digit = (second_digit/10)
			while second_digit>=10:
				second_digit-=10
			
			
			third_digit = charge_num_fire
			
			while (third_digit >= 10):
				third_digit -= 10;
			
			
			if (charge_num_fire>=10):
				$number_up_2.play("default")
				$number_up_2.set_frame(second_digit)
			else:$number_up_2.play("off")
			
			
			if (charge_num_fire>=100):
				$number_up_3.play("default")
				$number_up_3.set_frame(third_digit)
			else:$number_up_3.play("off")
			
			$number_up_1.set_frame(first_digit)
			
			if charge_num_fire <= 0:
			
				if position == get_parent().pos_card_1:
					get_parent().slot1_free = true
				if position == get_parent().pos_card_2:
					get_parent().slot2_free = true
				if position == get_parent().pos_card_3:
					get_parent().slot3_free = true
				if position == get_parent().pos_card_4:
					get_parent().slot4_free = true
				if position == get_parent().pos_card_5:
					get_parent().slot5_free = true
				
				if get_parent().slot1 == self:
					get_parent().slot1 = null
				if get_parent().slot2 == self:
					get_parent().slot2 = null
				if get_parent().slot3 == self:
					get_parent().slot3 = null
				if get_parent().slot4 == self:
					get_parent().slot4 = null
				if get_parent().slot5 == self:
					get_parent().slot5 = null
				
				if get_parent().slot1 != null:
					get_parent().slot1.selected = true
				elif get_parent().slot2 != null:
					get_parent().slot2.selected = true
				elif get_parent().slot3 != null:
					get_parent().slot3.selected = true
				elif get_parent().slot4 != null:
					get_parent().slot4.selected = true
				elif get_parent().slot5 != null:
					get_parent().slot5.selected = true
				
				
				get_parent().get_parent().get_parent().get_node("Wizard").casting = false
				
				get_parent().get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
				
				get_parent().get_parent().get_parent().get_node("Wizard").get_node("fire").get_node("Timer_quefree").start()
				get_parent().get_parent().get_parent().get_node("Wizard").get_node("fire").emitting = false
				
				get_parent().get_parent().get_parent().get_node("Wizard").has_fire = false
				
				#get_parent().get_parent().get_parent().get_node("Wizard").fire = null
				
				get_parent().card_just_used_pos = self.slot
				get_parent().card_just_used = self
				
				self.remove_from_group("fire")
				
				
				get_parent().spell_active.remove(get_parent().spell_active.find($icon.get_animation(),0))
				
				queue_free()
			
			elif self.is_in_group("fire"):
				$number_up_1.visible = true
				$number_up_2.visible = true
				$number_up_3.visible = true
				$number_down_1.visible = true
				$number_down_2.visible = true
				$number_down_3.visible = true
			else:
				$number_up_1.visible = false
				$number_up_2.visible = false
				$number_up_3.visible = false
				$number_down_1.visible = false
				$number_down_2.visible = false
				$number_down_3.visible = false
		
		
		if self.is_in_group("frost"):
			
			first_digit=charge_num_frost
			
			
			while (first_digit >= 10 && first_digit < 100):
				first_digit /= 10;
			
			while (first_digit >= 100):
				first_digit /= 100;
			
			second_digit = charge_num_frost
			
			
			while (second_digit >= 10 && second_digit < 100):
				second_digit -= 10;
			
			while (second_digit >= 100):
				second_digit = (second_digit/10)
			while second_digit>=10:
				second_digit-=10
			
			
			third_digit = charge_num_frost
			
			while (third_digit >= 10):
				third_digit -= 10;
			
			
			if (charge_num_frost>=10):
				$number_up_2.play("default")
				$number_up_2.set_frame(second_digit)
			else:$number_up_2.play("off")
			
			
			if (charge_num_frost>=100):
				$number_up_3.play("default")
				$number_up_3.set_frame(third_digit)
			else:$number_up_3.play("off")
			
			$number_up_1.set_frame(first_digit)
			
			if charge_num_frost <= 0:
			
				if position == get_parent().pos_card_1:
					get_parent().slot1_free = true
				if position == get_parent().pos_card_2:
					get_parent().slot2_free = true
				if position == get_parent().pos_card_3:
					get_parent().slot3_free = true
				if position == get_parent().pos_card_4:
					get_parent().slot4_free = true
				if position == get_parent().pos_card_5:
					get_parent().slot5_free = true
				
				if get_parent().slot1 == self:
					get_parent().slot1 = null
				if get_parent().slot2 == self:
					get_parent().slot2 = null
				if get_parent().slot3 == self:
					get_parent().slot3 = null
				if get_parent().slot4 == self:
					get_parent().slot4 = null
				if get_parent().slot5 == self:
					get_parent().slot5 = null
				
				if get_parent().slot1 != null:
					get_parent().slot1.selected = true
				elif get_parent().slot2 != null:
					get_parent().slot2.selected = true
				elif get_parent().slot3 != null:
					get_parent().slot3.selected = true
				elif get_parent().slot4 != null:
					get_parent().slot4.selected = true
				elif get_parent().slot5 != null:
					get_parent().slot5.selected = true
				
				
				get_parent().get_parent().get_parent().get_node("Wizard").casting = false
				
				get_parent().get_parent().get_parent().get_node("Wizard").get_node("Wizard_arm").play("static")
				
				get_parent().get_parent().get_parent().get_node("Wizard").get_node("frost").get_node("Timer_quefree").start()
				get_parent().get_parent().get_parent().get_node("Wizard").get_node("frost").emitting = false
				
				get_parent().get_parent().get_parent().get_node("Wizard").has_frost = false
				
				get_parent().card_just_used_pos = self.slot
				get_parent().card_just_used = self
				
				self.remove_from_group("frost")
				
				
				get_parent().spell_active.remove(get_parent().spell_active.find($icon.get_animation(),0))
				
				queue_free()
			
			elif self.is_in_group("frost"):
				$number_up_1.visible = true
				$number_up_2.visible = true
				$number_up_3.visible = true
				$number_down_1.visible = true
				$number_down_2.visible = true
				$number_down_3.visible = true
			else:
				$number_up_1.visible = false
				$number_up_2.visible = false
				$number_up_3.visible = false
				$number_down_1.visible = false
				$number_down_2.visible = false
				$number_down_3.visible = false
		
		
		
		if is_instance_valid(get_parent().get_parent().get_parent().get_node("Wizard")):
			if self.is_in_group("fireball"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_fireball = true
			if self.is_in_group("fire"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_fire = true
			if self.is_in_group("frost"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_frost = true
			if self.is_in_group("frostball"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_frostball = true
			if self.is_in_group("shield"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_shield = true
			if self.is_in_group("mass_shield"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_mass_shield = true
		
		if self.is_in_group("fireball"):
			if charge_fireball == 3:
				$icon.set_frame(0) 
			
			if charge_fireball == 2:
				$icon.set_frame(1) 
			
			if charge_fireball == 1:
				$icon.set_frame(2)
		
		if self.is_in_group("frostball"):
			if charge_frostball == 3:
				$icon.set_frame(0) 
			
			if charge_frostball == 2:
				$icon.set_frame(1) 
			
			if charge_frostball == 1:
				$icon.set_frame(2)
		
		if self.is_in_group("shield"):
			if charge_shield == 3:
				$icon.set_frame(0) 
			
			if charge_shield == 2:
				$icon.set_frame(1) 
			
			if charge_shield == 1:
				$icon.set_frame(2)
		
		if self.is_in_group("mass_shield"):
			if charge_shield == 1:
				$icon.set_frame(0) 
		
		
		if charge_fireball == 0:
			
			if position == get_parent().pos_card_1:
				get_parent().slot1_free = true
			if position == get_parent().pos_card_2:
				get_parent().slot2_free = true
			if position == get_parent().pos_card_3:
				get_parent().slot3_free = true
			if position == get_parent().pos_card_4:
				get_parent().slot4_free = true
			if position == get_parent().pos_card_5:
				get_parent().slot5_free = true
			
			get_parent().get_parent().get_parent().get_node("Wizard").has_fireball = false
			
			self.remove_from_group("fireball")
			
			if get_parent().slot1 == self:
				get_parent().slot1 = null
			if get_parent().slot2 == self:
				get_parent().slot2 = null
			if get_parent().slot3 == self:
				get_parent().slot3 = null
			if get_parent().slot4 == self:
				get_parent().slot4 = null
			if get_parent().slot5 == self:
				get_parent().slot5 = null
			
			if get_parent().slot1 != null:
				get_parent().slot1.selected = true
				print(get_parent().slot1)
			elif get_parent().slot2 != null:
				get_parent().slot2.selected = true
			elif get_parent().slot3 != null:
				get_parent().slot3.selected = true
			elif get_parent().slot4 != null:
				get_parent().slot4.selected = true
			elif get_parent().slot5 != null:
				get_parent().slot5.selected = true
			
			get_parent().card_just_used_pos = self.slot
			get_parent().card_just_used = self
			
			queue_free()
			
			get_parent().spell_active.remove(get_parent().spell_active.find($icon.get_animation(),0))
		
		
		if charge_frostball == 0:
			
			if position == get_parent().pos_card_1:
				get_parent().slot1_free = true
			if position == get_parent().pos_card_2:
				get_parent().slot2_free = true
			if position == get_parent().pos_card_3:
				get_parent().slot3_free = true
			if position == get_parent().pos_card_4:
				get_parent().slot4_free = true
			if position == get_parent().pos_card_5:
				get_parent().slot5_free = true
			
			get_parent().get_parent().get_parent().get_node("Wizard").has_frostball = false
			
			self.remove_from_group("frostball")
			
			if get_parent().slot1 == self:
				get_parent().slot1 = null
			if get_parent().slot2 == self:
				get_parent().slot2 = null
			if get_parent().slot3 == self:
				get_parent().slot3 = null
			if get_parent().slot4 == self:
				get_parent().slot4 = null
			if get_parent().slot5 == self:
				get_parent().slot5 = null
			
			if get_parent().slot1 != null:
				get_parent().slot1.selected = true
				print(get_parent().slot1)
			elif get_parent().slot2 != null:
				get_parent().slot2.selected = true
			elif get_parent().slot3 != null:
				get_parent().slot3.selected = true
			elif get_parent().slot4 != null:
				get_parent().slot4.selected = true
			elif get_parent().slot5 != null:
				get_parent().slot5.selected = true
			
			get_parent().card_just_used_pos = self.slot
			get_parent().card_just_used = self
			
			queue_free()
			
			get_parent().spell_active.remove(get_parent().spell_active.find($icon.get_animation(),0))
		
		if charge_shield == 0:
			
			if position == get_parent().pos_card_1:
				get_parent().slot1_free = true
			if position == get_parent().pos_card_2:
				get_parent().slot2_free = true
			if position == get_parent().pos_card_3:
				get_parent().slot3_free = true
			if position == get_parent().pos_card_4:
				get_parent().slot4_free = true
			if position == get_parent().pos_card_5:
				get_parent().slot5_free = true
			
			get_parent().get_parent().get_parent().get_node("Wizard").has_shield = false
			
			self.remove_from_group("shield")
			
			if get_parent().slot1 == self:
				get_parent().slot1 = null
			if get_parent().slot2 == self:
				get_parent().slot2 = null
			if get_parent().slot3 == self:
				get_parent().slot3 = null
			if get_parent().slot4 == self:
				get_parent().slot4 = null
			if get_parent().slot5 == self:
				get_parent().slot5 = null
			
			if get_parent().slot1 != null:
				get_parent().slot1.selected = true
				print(get_parent().slot1)
			elif get_parent().slot2 != null:
				get_parent().slot2.selected = true
			elif get_parent().slot3 != null:
				get_parent().slot3.selected = true
			elif get_parent().slot4 != null:
				get_parent().slot4.selected = true
			elif get_parent().slot5 != null:
				get_parent().slot5.selected = true
			
			get_parent().card_just_used_pos = self.slot
			get_parent().card_just_used = self
			
			queue_free()
			
			get_parent().spell_active.remove(get_parent().spell_active.find($icon.get_animation(),0))
		
		if charge_mass_shield == 0:
			
			if position == get_parent().pos_card_1:
				get_parent().slot1_free = true
			if position == get_parent().pos_card_2:
				get_parent().slot2_free = true
			if position == get_parent().pos_card_3:
				get_parent().slot3_free = true
			if position == get_parent().pos_card_4:
				get_parent().slot4_free = true
			if position == get_parent().pos_card_5:
				get_parent().slot5_free = true
			
			get_parent().get_parent().get_parent().get_node("Wizard").has_mass_shield = false
			
			self.remove_from_group("mass_shield")
			
			if get_parent().slot1 == self:
				get_parent().slot1 = null
			if get_parent().slot2 == self:
				get_parent().slot2 = null
			if get_parent().slot3 == self:
				get_parent().slot3 = null
			if get_parent().slot4 == self:
				get_parent().slot4 = null
			if get_parent().slot5 == self:
				get_parent().slot5 = null
			
			if get_parent().slot1 != null:
				get_parent().slot1.selected = true
				print(get_parent().slot1)
			elif get_parent().slot2 != null:
				get_parent().slot2.selected = true
			elif get_parent().slot3 != null:
				get_parent().slot3.selected = true
			elif get_parent().slot4 != null:
				get_parent().slot4.selected = true
			elif get_parent().slot5 != null:
				get_parent().slot5.selected = true
			
			get_parent().card_just_used_pos = self.slot
			get_parent().card_just_used = self
			
			queue_free()
			
			get_parent().spell_active.remove(get_parent().spell_active.find($icon.get_animation(),0))
		
		
		
	else:
		self.scale = Vector2(1,1)
		if is_instance_valid(get_parent().get_parent().get_parent().get_node("Wizard")):
			if self.is_in_group("fireball"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_fireball = false
			if self.is_in_group("frostball"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_frostball = false
			if self.is_in_group("shield"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_shield = false
			if self.is_in_group("mass_shield"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_mass_shield = false
			if self.is_in_group("fire"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_fire = false
				$number_up_1.visible = true
				$number_up_2.visible = true
				$number_up_3.visible = true
				$number_down_1.visible = true
				$number_down_2.visible = true
				$number_down_3.visible = true
			if self.is_in_group("frost"):
				get_parent().get_parent().get_parent().get_node("Wizard").has_frost = false
				$number_up_1.visible = true
				$number_up_2.visible = true
				$number_up_3.visible = true
				$number_down_1.visible = true
				$number_down_2.visible = true
				$number_down_3.visible = true
	
	
	
	pass
