
extends RigidBody2D

#class_name body_class

var has_homing_missile = false
#var has_bigger_shield = false # non
var Shield = "shield"

var mouv = Vector2()
var direction = Vector2()
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
var Spell
var switch_fire = 0 
var switch_frost = 0 
var HEAT = 0
#var GRAVITY = 0
onready var HEALTH = 1.75
onready var max_HEALTH = 1.75
var ADD_HEALTH = 0
onready var vie = get_node("barre_vie/vie")
onready var barre_vie = get_node("barre_vie")
onready var Spell_spawn_point = $Wizard_arm.get_node("fireball_spawn")
#onready var Card_playing = get_parent().get_node("HUD").get_node("Card_playing")
const FLOOR = Vector2(0,-1)
const max_mouv = 170
var spd = 170
var MANA = 100
onready var tir_arcane_load = preload("res://projectiles/tir_arcane.tscn")
onready var shield_load = preload("res://Magie/shield.tscn")
onready var fireball_load = preload("res://Magie/fireball.tscn")
onready var fire_load = preload("res://Magie/fire.tscn")
onready var frost_load = preload("res://Magie/frost.tscn")
onready var frostball_load = preload("res://Magie/frostball.tscn")
onready var spell_shield_load = preload("res://Magie/Spell_shield.tscn")
onready var spell_mass_shield_load = preload("res://Magie/spell_mass_shield.tscn")
onready var divine_shield_load = preload("res://Magie/divine_shield.tscn")

func  _integrate_forces(state):
	if is_network_master():
		$Camera2D.current = true
		state.set_linear_velocity((mouv/170)*spd)



func _physics_process(delta):

	
	if (is_network_master()):
		
		var angle_mouse = get_global_mouse_position().angle_to_point(position)
		
		
		if aim_mouse == true:
			$Wizard_arm.rotation = angle_mouse
		else:
			$Wizard_arm.rotation = 0
		
		if $Wizard_arm.scale.x == 1:
			$Wizard_arm/fireball_spawn.position.x = 12
		else:
			$Wizard_arm/fireball_spawn.position.x = -12
		
		
		direction = Vector2(Input.get_action_strength("d")-Input.get_action_strength("q"),Input.get_action_strength("s")-Input.get_action_strength("z"))
		
		if direction != Vector2(0,0):
			mouv = lerp(mouv,Vector2(170,170)*direction,0.03)
		else:
			mouv = lerp(mouv,Vector2(0,0),0.02)
		
		if direction.x != 0:
			if casting == false:
				$Wizard_spr.scale.x= direction.x
			$Wizard_spr.play("mouv")
		else:
			$Wizard_spr.play("static")
		
		$hit_box.scale.x = $Wizard_spr.scale.x
		
		MANA = clamp(MANA,0,100)
		
		if shield_on == true:
			MANA -= 0.1
		else:
			MANA += 0.08
		
		
		if casting == true:
			$Wizard_arm.scale.x = 1
			$Wizard_spr.scale.x = $Wizard_arm.scale.y
			$Wizard_arm.rotation = angle_mouse
		else:
			$Wizard_arm.scale.x = $Wizard_spr.scale.x
			$Wizard_arm.rotation = 0
			
			if Input.is_action_just_pressed("Souris_right") && MANA >= 0.1:
				$Wizard_arm/AnimationPlayer.play(Shield)
				$Wizard_arm/Shield/Shield_hitbox.disabled = false
				shield_on = true
			
			if Input.is_action_pressed("Souris_right"):
				#$Wizard_arm/Shield/Shield_hitbox.disabled = false
				$Wizard_arm.scale.x = 1
				$Wizard_spr.scale.x = $Wizard_arm.scale.y
				$Wizard_arm.rotation = angle_mouse
				if MANA < 0.15:
					$Wizard_arm.play("aim")
					$Wizard_arm/Shield/Shield_hitbox.disabled = true
					shield_on = false
				else:
					rpc("setAnim",Shield)
					$Wizard_arm/Shield/Shield_hitbox.disabled = false
					shield_on = true
			if Input.is_action_just_released("Souris_right"):
				#$Wizard_arm.flip_v =false;
				$Wizard_arm/Shield/Shield_hitbox.disabled = true
				$Wizard_arm.rotation = 0
				$Wizard_arm/AnimationPlayer.play("static")
				$Wizard_arm.scale.x = $Wizard_spr.scale.x
				shield_on = false
			if Input.is_action_pressed("Souris_left") && MANA >= 20:
				$Wizard_arm.play("shoot")
				#$Wizard_arm.speed_scale = 1.5
				$Wizard_arm.scale.x = 1
				$Wizard_spr.scale.x = $Wizard_arm.scale.y
				$Wizard_arm.rotation = angle_mouse
				#$Wizard_spr.scale.x=1;
				if($Wizard_arm.get_frame()==16):
						rpc("_tir_arcane")
						MANA -= 20
						$Wizard_arm.set_frame(0)
						if MANA < 20:
							$Wizard_arm.scale.x = $Wizard_spr.scale.x
							$Wizard_arm.rotation = 0
							$Wizard_arm.play("static")
			if Input.is_action_just_released("Souris_left"):
				$Wizard_arm.scale.x = $Wizard_spr.scale.x
				$Wizard_arm.rotation = 0
				$Wizard_arm.play("static")
			
		
		
		if Input.is_action_just_pressed("space"):
			if get_parent().get_node("HUD").get_node("Card_playing").get_child_count() > 0 :
				Spell = get_parent().get_node("HUD").get_node("Card_playing").card_selected.Spell
				if Spell == "fire" or Spell == "frost":
					$Wizard_arm.play("aim")
				else:
					$Wizard_arm.play("fireball_aim")
				if Spell != "idle_process":
					rpc("_create_spell",(Spell))
				
			
			
		
		if Input.is_action_just_pressed("Souris_right"):
			if casting == true && get_parent().get_node("HUD").get_node("Card_playing").card_selected != null:
				_launch_spell(get_parent().get_node("HUD").get_node("Card_playing").card_selected.Spell)
		
		
		if switch_fire == 1 && get_parent().get_node("HUD").get_node("Card_playing").card_selected.Spell == "fire":
			
			if Input.is_action_just_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_fire > 0:
				get_node("fire").active = true
				get_node("fire").set_emitting(true)
			if Input.is_action_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_fire > 0:
				get_node("fire").global_rotation = $Wizard_arm.rotation
				get_node("fire").global_position = $Wizard_arm/Position2D.global_position
				get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_fire -= 25*delta
				get_parent().get_node("HUD").get_node("Card_playing").card_selected.get_node("Label").text = str(round(get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_fire))
			else:
				get_node("fire").set_emitting(false)
				get_node("fire").active = false
		
		if switch_frost == 1 && get_parent().get_node("HUD").get_node("Card_playing").card_selected.Spell == "frost":
			
			if Input.is_action_just_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_frost > 0:
				get_node("frost").active = true
				get_node("frost").set_emitting(true)
			if Input.is_action_pressed("Souris_right") && get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_frost > 0:
				var frost = self.get_node("frost")
				frost.global_rotation = $Wizard_arm.rotation
				frost.global_position = $Wizard_arm/Position2D.global_position
				get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_frost -= 25*delta
				get_parent().get_node("HUD").get_node("Card_playing").card_selected.get_node("Label").text = str(round(get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_num_frost))
			else:
				get_node("frost").set_emitting(false)
				get_node("frost").active = false
		
		
		
		if ($Wizard_arm.rotation_degrees)*sign($Wizard_arm.rotation_degrees)>90:
			$Wizard_arm.scale.y=-1;
		else:
			$Wizard_arm.scale.y=1;
		
		
		rpc_unreliable("setPosition",Vector2(position.x , position.y))
		
		
		rpc_unreliable("setStatus",$Wizard_spr.get_animation(),$Wizard_spr.get_frame(),$Wizard_spr.scale.x,$Wizard_arm.get_animation(),$Wizard_arm.get_frame(),$Wizard_arm.scale,$Wizard_arm.rotation)
	
		if HEAT != 0:
			_apply_heat(HEAT)
			rpc("_apply_color",get_modulate())
		
		get_parent().get_node("HUD").get_node("Mana_pool").value = MANA




func _input(event):
	
	if !event is InputEventMouseMotion:
		
		if event.as_text() == "Shift":
			if spd == 170:
				spd = 400
			else:
				spd = 170
		
		if event is InputEventMouseButton:
			match event.button_index:
				BUTTON_WHEEL_UP:
					if $Camera2D.zoom > Vector2(0.08,0.08):
						$Camera2D.zoom -= Vector2(0.02,0.02)
				BUTTON_WHEEL_DOWN:
					if $Camera2D.zoom < Vector2(1.1,1.1):
						$Camera2D.zoom += Vector2(0.02,0.02)
			
		
		
		"""
		if event.as_text() == "D":
			if mouv.x<max_mouv:
				mouv.x+=5
			$Wizard_spr.play("mouv")
			if casting == false:
				$Wizard_spr.scale.x=1
				#$Wizard_arm.scale.x=1
	
		if event.as_text() == "Q":
			if mouv.x > -max_mouv:
				mouv.x-=5
			$Wizard_spr.play("mouv")
			if casting == false:
				$Wizard_spr.scale.x=-1
				#$Wizard_arm.scale.x=-1
		"""
		
		#if event is InputEventKey:
		
		pass


func _take_damage(damage,knock):
	if is_network_master():
		if ADD_HEALTH <= 0 :
			HEALTH -= damage
		else:
			ADD_HEALTH -= damage
			if ADD_HEALTH <= 0:
				rpc("_shield_broke")
		
		if HEALTH <=0 :
			rpc("_die")
		elif ADD_HEALTH > 0:
			$barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
			rpc("setHealth",HEALTH,ADD_HEALTH)
		else:
			vie.scale.x=HEALTH/1.75
			rpc("setHealth",HEALTH,ADD_HEALTH)
		
		global_position+=knock


sync func _get_divine_shield():
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		#rpc("_apply_spell","divine_shield")
		divine_shield.global_position = global_position-Vector2(1,0)
		$barre_vie/divine_shield.play("default")
		$barre_vie.play("divine_shield")
		ADD_HEALTH = 1
		$barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
		$barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	else:
		pass

sync func _shield_broke():
	ADD_HEALTH = 0
	$barre_vie.play("default")
	$barre_vie/divine_shield.play("off")


func _stuned():
	mouv.x = 0
	mouv.y = 0

puppet func setPosition(pos):
	position = pos

puppet func setHealth(health,add_health):
	if ADD_HEALTH > 0:
		$barre_vie/divine_shield.scale.x = (add_health/1)
	else:
		HEALTH = health
		vie.scale.x=HEALTH/1.75

puppet func setStatus(anim,frame,scale,arm_anim,arm_frame,arm_scale,arm_rotation):
	$Wizard_spr.play(anim)
	$Wizard_spr.set_frame(frame) 
	$Wizard_spr.scale.x = scale
	$Wizard_arm.scale = arm_scale
	$Wizard_arm.play(arm_anim)
	$Wizard_arm.set_frame(arm_frame)
	$Wizard_arm.rotation = arm_rotation

sync func _tir_arcane():
	var tir_arcane = tir_arcane_load.instance()
	tir_arcane.global_rotation_degrees = $Wizard_arm.rotation_degrees
	tir_arcane.mouv = Vector2(230, 0).rotated(tir_arcane.rotation)
	tir_arcane.position = $Wizard_arm/Position2D.global_position
	tir_arcane.tir_power = tir_power_self
	tir_arcane.Homing = has_homing_missile
	get_parent().add_child(tir_arcane)


sync func _create_spell(Spell):
	
	match Spell:
		"fireball":
			if !Spell_spawn_point.has_node(Spell): 
				casting = true
				var fireball = fireball_load.instance()
				fireball.team = "red"
				Spell_spawn_point.add_child(fireball)
				fireball.global_position = $Wizard_arm/fireball_spawn.global_position
			else:
				casting = false
				Spell_spawn_point.get_node(Spell).queue_free()
		"frostball":
			if !Spell_spawn_point.has_node(Spell): 
				casting = true
				var frostball = frostball_load.instance()
				frostball.team = "red"
				Spell_spawn_point.add_child(frostball)
				frostball.global_position = $Wizard_arm/fireball_spawn.global_position
			else:
				casting = false
				Spell_spawn_point.get_node(Spell).queue_free()
		"shield":
			if !Spell_spawn_point.has_node("spell_shield"):
				casting = true
				var spell_shield = spell_shield_load.instance()
				if !is_network_master():
					spell_shield.Remote = true
				Spell_spawn_point.add_child(spell_shield)
				spell_shield.global_position = $Wizard_arm/fireball_spawn.global_position
			else:
				casting = false
				Spell_spawn_point.get_node("spell_shield").queue_free()
		"mass_shield":
			if !Spell_spawn_point.has_node("spell_mass_shield"): 
				casting = true
				var spell_mass_shield = spell_mass_shield_load.instance()
				if !is_network_master():
					spell_mass_shield.Remote = true
				Spell_spawn_point.add_child(spell_mass_shield)
				spell_mass_shield.global_position = $Wizard_arm/fireball_spawn.global_position
			else:
				casting = false
				Spell_spawn_point.get_node("spell_mass_shield").queue_free()
		"fire":
			if switch_fire == 0:
				casting = true
				$Wizard_arm.play("aim")
				switch_fire = 1
				if Input.is_action_pressed("Souris_right"):
					get_node("fire").active = true
					get_node("fire").set_emitting(true)
			elif switch_fire == 1:
				switch_fire = 0
				casting = false
				$Wizard_arm.play("static")
				get_node("fire").set_emitting(false)
				get_node("fire").active = false
				if Input.is_action_pressed("Souris_right"):
					casting = false
					$Wizard_arm/AnimationPlayer.play(Shield)
		"frost":
			if switch_frost == 0:
				casting = true
				$Wizard_arm.play("aim")
				switch_frost = 1
				if Input.is_action_pressed("Souris_right"):
					get_node("frost").active = true
					get_node("frost").set_emitting(true)
			elif switch_frost == 1:
				switch_frost = 0
				casting = false
				$Wizard_arm.play("static")
				get_node("frost").active = false
				get_node("frost").set_emitting(false)
				if Input.is_action_pressed("Souris_right"):
					casting = false
					$Wizard_arm/AnimationPlayer.play(Shield)


func _launch_spell(Spell):
	match Spell:
		
		"fireball":
			if Spell_spawn_point.has_node("fireball"):
				get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_fireball -=1
				get_parent().get_node("HUD").get_node("Card_playing").update_card_sprite(Spell)
				$Wizard_arm.play("fireball_shoot")
				var fball = Spell_spawn_point.get_node("fireball")
				fball.mouv = Vector2(cos($Wizard_arm.rotation),sin($Wizard_arm.rotation)) * Spell_spawn_point.get_node("fireball").spd
				rpc("_remote_spell","fireball",$Wizard_arm/fireball_spawn.global_position,fball.mouv)
				Spell_spawn_point.remove_child(fball)
				fball.global_position = $Wizard_arm/fireball_spawn.global_position
				get_parent().add_child(fball)
				fball.set_owner(get_parent())
				casting = false
		
		"frostball":
			if Spell_spawn_point.has_node("frostball"):
				get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_frostball -=1
				get_parent().get_node("HUD").get_node("Card_playing").update_card_sprite(Spell)
				$Wizard_arm.play("fireball_shoot")
				var fball = Spell_spawn_point.get_node("frostball")
				fball.mouv = Vector2(cos($Wizard_arm.rotation),sin($Wizard_arm.rotation)) * Spell_spawn_point.get_node("frostball").spd
				rpc("_remote_spell","frostball",$Wizard_arm/fireball_spawn.global_position,fball.mouv)
				Spell_spawn_point.remove_child(fball)
				get_parent().add_child(fball)
				fball.global_position = $Wizard_arm/fireball_spawn.global_position
				fball.set_owner(get_parent())
				casting = false
		
		"shield":
			if Spell_spawn_point.has_node("spell_shield"):
				$Wizard_arm.play("fireball_shoot")
				if Spell_spawn_point.get_node("spell_shield").selected != null:
					Spell_spawn_point.get_node("spell_shield").selected.rpc("_get_divine_shield")
					get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_shield -=1
					get_parent().get_node("HUD").get_node("Card_playing").update_card_sprite(Spell)
					rpc("_remote_spell","shield",0,0)
					Spell_spawn_point.get_node("spell_shield").queue_free()
					casting = false
		
		"mass_shield":
			if Spell_spawn_point.has_node("spell_mass_shield"):
				get_parent().get_node("HUD").get_node("Card_playing").card_selected.charge_mass_shield -=1
				$Wizard_arm.play("fireball_shoot")
				var divine_shield = divine_shield_load.instance()
				Spell_spawn_point.get_node("spell_mass_shield").get_node("arrow_end").get_node("hitbox_click").get_node("hitbox_click").disabled = false
				Spell_spawn_point.get_node("spell_mass_shield").get_node("Timer").start()
				casting = false
				#divine_shield.global_position = get_node("spell_shield").selected.global_position-Vector2(1,0)
				#get_node("spell_shield").selected.ADD_HEALTH += 1
				#get_node("spell_mass_shield").queue_free()



puppet func _remote_spell(spell,spell_pos,spell_mouv):
	match spell:
		"fireball":
			var fball = Spell_spawn_point.get_node("fireball")
			fball.mouv = spell_mouv
			Spell_spawn_point.remove_child(fball)
			fball.global_position = spell_pos
			get_parent().add_child(fball)
			fball.set_owner(get_parent())
		"frostball":
			var fball = Spell_spawn_point.get_node("frostball")
			fball.mouv = spell_mouv
			Spell_spawn_point.remove_child(fball)
			fball.global_position = spell_pos
			get_parent().add_child(fball)
			fball.set_owner(get_parent())
		"shield":
			Spell_spawn_point.get_node("spell_shield").queue_free()



sync func _remove_child(spell,pos):
	if spell == "fire":
		var Fire = get_node("fire")
		Fire.emitting = false
		remove_child(Fire)
		get_parent().add_child(Fire)
		Fire.global_position = pos
	if spell == "frost":
		var Frost = get_node("frost")
		Frost.emitting = false
		remove_child(Frost)
		get_parent().add_child(Frost)
		Frost.global_position = pos



func _apply_heat(Heat):
	if is_network_master():
		if HEAT > 0:
			modulate = Color(1,1-HEAT,1-HEAT,1)
			HEAT -= 0.005
			HEALTH -= HEAT/400
			if HEALTH <=0 :
				if is_network_master():
					rpc("_die")
			elif ADD_HEALTH > 0:
				$barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
				rpc("setHealth",HEALTH,ADD_HEALTH)
			else:
				$barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
				rpc("setHealth",HEALTH,ADD_HEALTH)
			rpc_unreliable("_speed_scale",170)
		if HEAT < 0:
			HEAT += 0.002
			if HEAT < -1:
				spd = 0
			else:
				spd = 170 *(1+HEAT)
			modulate = Color(1+HEAT,1,1,1)
			rpc_unreliable("_speed_scale",spd)

sync func _speed_scale(spd):
	$Wizard_spr.set_speed_scale(spd/170) 
	$Wizard_arm.set_speed_scale(spd/170) 
	$Wizard_arm/AnimationPlayer.set_speed_scale(spd/170) 

puppet func _apply_color(color):
	modulate = color





sync func _die():
	set_physics_process(false)
	if has_node("fire"):#has_fire == true:
		get_parent().get_node("Portal_red").respawn_with_fire_red = true
	if has_node("frost"):#has_frost == true:
		get_parent().get_node("Portal_red").respawn_with_frost_red = true
	get_parent()._PJ_respawn("RED")
	get_parent().get_node("Camera_dead").current = true
	queue_free()

