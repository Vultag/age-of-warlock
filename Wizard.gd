
extends KinematicBody2D

#class_name body_class

var mouv = Vector2()
var get_tir_dir = 0
#var tir_arcane = tir_arcane_load.instance()
#var tir_loop = true
var casting = false
var aim_mouse = false
var tir_power_self= null
var shield_on = false
var has_fireball = false
var has_fire = false
var has_frost = false
var has_frostball = false
var has_shield = false
var has_mass_shield = false
var fire
var switch_fire = 0 
var switch_frost = 0 
var HEAT = 0
#var GRAVITY = 0
onready var HEALTH = 1.75
onready var max_HEALTH = 1.75
onready var vie = get_node("barre_vie/vie")
onready var barre_vie = get_node("barre_vie")
const FLOOR =Vector2(0,-1)
const max_mouv = 170
const tir_arcane_load = preload("res://projectiles/tir_arcane.tscn")
const shield_load = preload("res://Magie/shield.tscn")
const fireball_load = preload("res://Magie/fireball.tscn")
const fire_load = preload("res://Magie/fire.tscn")
const frost_load = preload("res://Magie/frost.tscn")
const frostball_load = preload("res://Magie/frostball.tscn")
const spell_shield_load = preload("res://Magie/Spell_shield.tscn")
const spell_mass_shield_load = preload("res://Magie/spell_mass_shield.tscn")
const divine_shield_load = preload("res://Magie/divine_shield.tscn")


func _physics_process(delta):
	
	var angle_mouse = get_global_mouse_position().angle_to_point(position)
	
	if aim_mouse == true:
		$Wizard_arm.rotation = angle_mouse
	else:
		$Wizard_arm.rotation = 0
	
	if $Wizard_arm.scale.x == 1:
		$Wizard_arm/fireball_spawn.position.x = 12
	else:
		$Wizard_arm/fireball_spawn.position.x = -12
	
	
	if Input.is_action_pressed("d"):
		
		mouv.x+=3
		$Wizard_spr.play("mouv")
		if casting == false:
			$Wizard_spr.scale.x=1
			#$Wizard_arm.scale.x=1
		if mouv.x>=max_mouv:
			mouv.x-=3
		
	elif Input.is_action_pressed("q"):
		
		mouv.x+=-3
		$Wizard_spr.play("mouv")
		if casting == false:
			$Wizard_spr.scale.x=-1
			#$Wizard_arm.scale.x=-1
		if mouv.x<=-max_mouv:
			mouv.x+=3
		
	else:
		mouv.x+=3*sign(-mouv.x)
		$Wizard_spr.play("static")
		
	if Input.is_action_pressed("z"):
		mouv.y+=-3
		if mouv.y<=-max_mouv:
			mouv.y+=3
	elif Input.is_action_pressed("s"):
		mouv.y+=3
		if mouv.y>=max_mouv:
			mouv.y-=3
	else:
		mouv.y+=3*sign(-mouv.y)
	
	"""
	if Input.is_action_just_pressed("ui_right"):
		$Wizard_arm/fireball_spawn.position.x = 12
	if Input.is_action_just_pressed("ui_left"):
		$Wizard_arm/fireball_spawn.position.x = -12
	"""
	
		
	if casting == true:
		$Wizard_arm.scale.x = 1
		$Wizard_spr.scale.x = $Wizard_arm.scale.y
		$Wizard_arm.rotation = angle_mouse
	else:
		$Wizard_arm.scale.x = $Wizard_spr.scale.x
		$Wizard_arm.rotation = 0
	
	
	if get_parent().get_node("HUD").get_node("Card_playing").get_child_count()>0:
		if has_fireball == true:                 
			if Input.is_action_just_pressed("space"):
				casting = true
				$Wizard_arm.play("fireball_aim")
				#$Wizard_arm.rotation = angle_mouse
				#$Wizard_spr.scale.x=1;
			if ( $Wizard_arm.get_animation() =="fireball_aim" && $Wizard_arm.get_frame()==2):
				#$Wizard_arm.set_frame(0) 
				
				if !self.has_node("fireball"):
					var fireball = fireball_load.instance()
					add_child(fireball)
				else:
					self.get_node("fireball").global_position = $Wizard_arm/fireball_spawn.global_position
	
	if get_parent().get_node("HUD").get_node("Card_playing").get_child_count()>0:
		if has_frostball == true:                 
			if Input.is_action_just_pressed("space"):
				casting = true
				$Wizard_arm.play("fireball_aim")
				#$Wizard_arm.rotation = angle_mouse
				#$Wizard_spr.scale.x=1;
			if ( $Wizard_arm.get_animation() =="fireball_aim" && $Wizard_arm.get_frame()==2):
				#$Wizard_arm.set_frame(0) 
				
				if !self.has_node("frostball"):
					var frostball = frostball_load.instance()
					add_child(frostball)
				else:
					self.get_node("frostball").global_position = $Wizard_arm/fireball_spawn.global_position
	
	#SPELL SHIELD
	if get_parent().get_node("HUD").get_node("Card_playing").get_child_count()>0:
		if has_shield == true:                 
			if Input.is_action_just_pressed("space"):
				casting = true
				$Wizard_arm.play("fireball_aim")
				#$Wizard_arm.rotation = angle_mouse
				#$Wizard_spr.scale.x=1;
			if ( $Wizard_arm.get_animation() =="fireball_aim" && $Wizard_arm.get_frame()==2):
				#$Wizard_arm.set_frame(0) 
				
				if !self.has_node("spell_shield"):
					var spell_shield = spell_shield_load.instance()
					add_child(spell_shield)
				else:
					self.get_node("spell_shield").global_position = $Wizard_arm/fireball_spawn.global_position
	
	#SPELL MASS SHIELD
	if get_parent().get_node("HUD").get_node("Card_playing").get_child_count()>0:
		if has_mass_shield == true:                 
			if Input.is_action_just_pressed("space"):
				casting = true
				$Wizard_arm.play("fireball_aim")
				#$Wizard_arm.rotation = angle_mouse
				#$Wizard_spr.scale.x=1;
			if ( $Wizard_arm.get_animation() =="fireball_aim" && $Wizard_arm.get_frame()==2):
				#$Wizard_arm.set_frame(0) 
				
				if !self.has_node("spell_mass_shield"):
					var spell_mass_shield = spell_mass_shield_load.instance()
					add_child(spell_mass_shield)
				else:
					self.get_node("spell_mass_shield").global_position = $Wizard_arm/fireball_spawn.global_position

	
	if self.has_node("fireball"):
		if Input.is_action_just_pressed("Souris_right"):
			get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_fireball -=1
			$Wizard_arm.play("fireball_shoot")
			var fball = self.get_node("fireball")
			fball.mouv = Vector2(cos($Wizard_arm.rotation),sin($Wizard_arm.rotation)) * self.get_node("fireball").spd
			self.remove_child(fball)
			get_parent().add_child(fball)
			fball.set_owner(get_parent())
			fball.global_position = $Wizard_arm/fireball_spawn.global_position
	
	if self.has_node("frostball"):
		if Input.is_action_just_pressed("Souris_right"):
			get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_frostball -=1
			$Wizard_arm.play("fireball_shoot")
			var fball = self.get_node("frostball")
			fball.mouv = Vector2(cos($Wizard_arm.rotation),sin($Wizard_arm.rotation)) * self.get_node("frostball").spd
			self.remove_child(fball)
			get_parent().add_child(fball)
			fball.set_owner(get_parent())
			fball.global_position = $Wizard_arm/fireball_spawn.global_position
	
	if self.has_node("spell_shield"):
		if Input.is_action_just_pressed("Souris_right") && get_node("spell_shield").selected != null:
			get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_shield -=1
			$Wizard_arm.play("fireball_shoot")
			
			#var divine_shield = divine_shield_load.instance()
			get_node("spell_shield").selected._get_divine_shield()
			#divine_shield.global_position = get_node("spell_shield").selected.global_position-Vector2(1,0)
			#get_node("spell_shield").selected.ADD_HEALTH += 1
			get_node("spell_shield").queue_free()
	
	if self.has_node("spell_mass_shield"):
		if Input.is_action_just_pressed("Souris_right"):
			get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_mass_shield -=1
			$Wizard_arm.play("fireball_shoot")
			var divine_shield = divine_shield_load.instance()
			get_node("spell_mass_shield").get_node("arrow_end").get_node("hitbox_click").get_node("hitbox_click").disabled = false
			#get_node("spell_shield").selected.add_child(divine_shield)
			#divine_shield.global_position = get_node("spell_shield").selected.global_position-Vector2(1,0)
			#get_node("spell_shield").selected.ADD_HEALTH += 1
			#get_node("spell_mass_shield").queue_free()
	
	
	if ( $Wizard_arm.get_animation() =="fireball_shoot"):# && $Wizard_arm.get_frame()==2):
		aim_mouse = false
		$Wizard_arm.play("static")
		casting = false
	
	
	# SPELL FIRE
	if get_parent().get_node("HUD").get_node("Card_playing").get_child_count()>0:
		if has_fire == true && get_parent().get_node("HUD").get_node("Card_playing").card_selected.is_in_group("fire") :     
			if Input.is_action_just_pressed("space") && switch_fire == 0:
				casting = true
				$Wizard_arm.play("aim")
				switch_fire = 1
			elif Input.is_action_just_pressed("space") && switch_fire == 1:
				switch_fire = 0
				casting = false
				$Wizard_arm.play("static")
				get_node("fire").set_emitting(false)
				get_node("fire").active = false
				"""
				if is_instance_valid(self.get_node("fire"))==true:
					self.get_node("fire").queue_free()
				"""
	
	#SPELL FROST
	if get_parent().get_node("HUD").get_node("Card_playing").get_child_count()>0:
		if has_frost == true && get_parent().get_node("HUD").get_node("Card_playing").card_selected.is_in_group("frost"):     
			if Input.is_action_just_pressed("space") && switch_frost == 0:
				casting = true
				$Wizard_arm.play("aim")
				switch_frost = 1
			elif Input.is_action_just_pressed("space") && switch_frost == 1:
				switch_frost = 0
				casting = false
				$Wizard_arm.play("static")
				get_node("frost").set_emitting(false)
				get_node("frost").active = false
	
	
	
	if switch_fire == 1 && has_fire == true && get_parent().get_node("HUD").get_node("Card_playing").card_selected.is_in_group("fire") == true:
		
		if Input.is_action_just_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_fire > 0:
			get_node("fire").active = true
		if Input.is_action_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_fire > 0:
			get_node("fire").set_emitting(true)
			get_node("fire").global_rotation = $Wizard_arm.rotation
			get_node("fire").global_position = $Wizard_arm/Position2D.global_position
			get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_fire -= 25*delta
		else:
			get_node("fire").set_emitting(false)
			get_node("fire").active = false
	else :
		pass
		#get_node("fire").set_emitting(false)
		#get_node("fire").active = false
	
	if switch_frost == 1 && has_frost == true && get_parent().get_node("HUD").get_node("Card_playing").card_selected.is_in_group("frost") == true:
		
		if Input.is_action_just_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_frost > 0:
			get_node("frost").active = true
		if Input.is_action_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_frost > 0:
			var frost = self.get_node("frost")
			frost.set_emitting(true)
			frost.global_rotation = $Wizard_arm.rotation
			frost.global_position = $Wizard_arm/Position2D.global_position
			get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_frost -= 25*delta
		else:
			get_node("frost").set_emitting(false)
			get_node("frost").active = false
	else:
		pass
	
	
	if casting == false:
		if Input.is_action_just_pressed("Souris_right"):
			$Wizard_arm/AnimationPlayer.play("shield")
		
		if Input.is_action_pressed("Souris_right"):
			$Wizard_arm/Shield/Shield_hitbox.disabled = false
			shield_on = true
			$Wizard_arm.scale.x = 1
			$Wizard_spr.scale.x = $Wizard_arm.scale.y
			$Wizard_arm.rotation = angle_mouse
			#$Wizard_arm/AnimationPlayer.play("shield")
			#if $Wizard_arm.get_index() == 9:
				#$Wizard_arm/AnimationPlayer.stop()
		else:
			$Wizard_arm.scale.x = $Wizard_spr.scale.x
			$Wizard_arm.rotation = 0
			$Wizard_arm/Shield/Shield_hitbox.disabled = true
			pass
				
		
		if Input.is_action_just_released("Souris_right"):
			#$Wizard_arm.flip_v =false;
			$Wizard_arm/Shield/Shield_hitbox.disabled = true
			$Wizard_arm.rotation = 0
			$Wizard_arm/AnimationPlayer.play("static")
			$Wizard_arm.scale.x = $Wizard_spr.scale.x
			if shield_on == true:
				if $Wizard_arm/Shield.get_child_count() > 2:
					if is_instance_valid($Wizard_arm/Shield):
						pass
						#$Wizard_arm/Shield.get_node("arrow_blue").queue_free()
				#$Wizard_arm/Shield.queue_free()
				shield_on = false
	
	if casting == false:
		if Input.is_action_pressed("Souris_left"):
			$Wizard_arm.play("shoot")
			$Wizard_arm.speed_scale = 1.5
			$Wizard_arm.scale.x = 1
			$Wizard_spr.scale.x = $Wizard_arm.scale.y
			$Wizard_arm.rotation = angle_mouse
			#$Wizard_spr.scale.x=1;
			if($Wizard_arm.get_frame()==16):
					tir_power_self = 1
					var tir_arcane = tir_arcane_load.instance()
					tir_arcane.global_rotation_degrees = $Wizard_arm.rotation_degrees
					tir_arcane.mouv = Vector2(230, 0).rotated(tir_arcane.rotation)
					tir_arcane.position = $Wizard_arm/Position2D.global_position
					tir_arcane.tir_power = tir_power_self
					get_parent().add_child(tir_arcane)
					$Wizard_arm.set_frame(0)
	
	
		if Input.is_action_just_released("Souris_left"):
			#$Wizard_arm.flip_v =false;
			$Wizard_arm.scale.x = $Wizard_spr.scale.x
			$Wizard_arm.rotation = 0
			$Wizard_arm.play("static")
	
	
	if ($Wizard_arm.rotation_degrees)*sign($Wizard_arm.rotation_degrees)>90:
		#var angle_mouse = get_global_mouse_position().angle_to_point(position)
		#$Wizard_spr.scale.x=-1;
		$Wizard_arm.scale.y=-1;
		#if casting == true:
			#$Wizard_spr.scale.x = $Wizard_arm.scale.x
	else:
		#if($Wizard_spr.scale.x==1):
			#$Wizard_arm.scale.x=1;
		$Wizard_arm.scale.y=1;
		#$Wizard_spr.scale.x=-1
	
	
	if (!Input.is_action_pressed("Souris_right")):
		pass
		#$Wizard_arm.flip_h = $Wizard_spr.flip_h
		
	if (Input.is_action_pressed("Souris_right")):
		pass
		#if ($Wizard_spr.scale.x==-1):
			#$Wizard_arm.scale.x=1
	
	if (!Input.is_action_pressed("Souris_left")):
		pass
		#$Wizard_arm.flip_h = $Wizard_spr.flip_h
		
	if (Input.is_action_pressed("Souris_left")):
		pass
		#if ($Wizard_spr.scale.x==-1):
			#$Wizard_arm.scale.x=1
	
	"""
	if (!Input.is_action_pressed("Souris_left")):
		$Wizard_arm.flip_h = $Wizard_spr.flip_h
		
	if (Input.is_action_pressed("Souris_left")):
		if ($Wizard_spr.scale.x==-1):
			$Wizard_arm.scale.x=1
	"""
	
	if ($Wizard_spr.flip_h == true):
		get_tir_dir = -1
	else:
		get_tir_dir = 1
	
	barre_vie.scale.x=max_HEALTH/1.2
	vie.scale.x=HEALTH/1.75
	
	if(HEALTH<=0):
		queue_free()
		get_parent()._PJ_respawn()
	
	if ($Wizard_spr.scale.x == -1):
		$hit_box.scale.x = -1
	else:
		$hit_box.scale.x = 1
	
	
	mouv = move_and_slide(mouv,FLOOR)
	pass



func _take_damage(damage,knock):
	
	HEALTH -= damage
	
	global_position+=knock

func _stuned():
	mouv.x = 0
	mouv.y = 0
	
	


