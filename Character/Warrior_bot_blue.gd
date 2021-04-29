extends RigidBody2D

# Declare member variables here. Examples:
var timer_check = false
var mouv = Vector2()
var attack_free = true
var body_check = false
var body_char
var hit = false
var ADD_HEALTH = 0
var spell_mass_shield_selected =false
onready var HEALTH = 1.2
onready var hitbox = get_node("Warrior_spr/attack_hitbox/hitbox")
onready var vie = get_node("Warrior_spr/barre_vie/vie")
onready var divine_shield = get_node("Warrior_spr/barre_vie/divine_shield")
var GRAVITY = 14
var spd = 35
var HEAT = 0
const FLOOR = Vector2(0,-1)

const divine_shield_load = preload("res://Magie/divine_shield.tscn")

func _ready():
	if is_network_master():
		$Warrior_spr/AnimationPlayer.play("mouv")
		$Warrior_spr/attack_check/hitbox_check.disabled = false
		$Warrior_spr/barre_vie.play("default")
		mouv.x =-35
		$Warrior_spr.scale.x = -1
	else:
		$Warrior_spr/AnimationPlayer.play("mouv")
		$Warrior_spr/barre_vie.play("default")
		$Warrior_spr/attack_check/hitbox_check.disabled = true
		$Warrior_spr/attack_hitbox/hitbox.disabled = true
		#$hit_box.disabled = true
		pass

func  _integrate_forces(state):
	if is_network_master():
		set_friction(0)
		state.set_linear_velocity((mouv/35)*spd)
		
		rpc_unreliable("setPos",position)
		if global_position.y < globals.sol:
			mouv.y+=GRAVITY
		else:
			mouv.y = 0


func _physics_process(_delta):
	
	if is_network_master():
		
		randomize()
		
		
		if HEAT != 0:
			_apply_heat(HEAT)
			rpc_unreliable("_apply_color",get_modulate())




func _on_attack_hitbox_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character_red"):
			body._take_damage(0.20,Vector2(-20,-20))#(0.20,Vector2(4,-2))
			body_char = body


func _on_attack_check_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character_red") && HEALTH > 0:
			$Warrior_spr/AnimationPlayer.play("attack")
			rpc("setAnim","attack")


func _take_damage(damage,knock):
	if is_network_master():
		
		var block_chance
		
		if damage <= 0.3:
			block_chance = randi() % 9
			if block_chance < 3.33:
				global_position+=knock
				#$block_display.play("on")
				#$block_display/AnimationPlayer.play("de-pop")
				$Warrior_spr/warrior_shield.play("block")
				rpc_unreliable("_block_display")
			else :
				$Warrior_spr/warrior_shield.play("static")
				#$block_display.play("off")
				rpc_unreliable("_block_display_off")
				if ADD_HEALTH <= 0 :
					HEALTH -= damage
				else:
					ADD_HEALTH -= damage
					if ADD_HEALTH <= 0:
						rpc("_shield_broke")
				global_position+=knock/2
		else :
			if ADD_HEALTH <= 0 :
				HEALTH -= damage
			else:
				ADD_HEALTH -= damage
				if ADD_HEALTH <= 0:
					rpc("_shield_broke")
		
		if HEALTH <=0 :
			rpc("_die")
		elif ADD_HEALTH > 0:
			divine_shield.scale.x = (ADD_HEALTH/1)
			rpc_unreliable("setHealth",ADD_HEALTH)
		else:
			vie.scale.x=HEALTH/1.2
			rpc_unreliable("setHealth",HEALTH)


sync func _get_divine_shield():
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		#rpc("_apply_spell","divine_shield")
		divine_shield.global_position = global_position-Vector2(1,0)
		$Warrior_spr/barre_vie/divine_shield.play("default")
		$Warrior_spr/barre_vie.play("divine_shield")
		ADD_HEALTH = 1
		$Warrior_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
		divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	else:
		pass

sync func _shield_broke():
	ADD_HEALTH = 0
	$Warrior_spr/barre_vie.play("default")
	$Warrior_spr/barre_vie/divine_shield.play("off")

func _apply_heat(Heat):
	if is_network_master():
		if HEAT > 0:
			modulate = Color(1,1-HEAT,1-HEAT,1)
			HEAT -= 0.003
			HEALTH -= HEAT/400
			if HEALTH <=0 :
				if is_network_master():
					rpc("_die")
			elif ADD_HEALTH > 0:
				divine_shield.scale.x = (ADD_HEALTH/1)
				rpc_unreliable("setHealth",ADD_HEALTH)
			else:
				vie.scale.x=HEALTH/1.2
				rpc_unreliable("setHealth",HEALTH)
			rpc_unreliable("_speed_scale",35)#aieaieaie
		if HEAT < 0:
			HEAT += 0.001
			if HEAT < -1:
				spd = 0
			else:
				spd = 35 *(1+HEAT)
			modulate = Color(1+HEAT,1,1,1)
			rpc_unreliable("_speed_scale",spd)


sync func _die():
	#queue_free()
		set_physics_process(false)
		#queue_free()
		$Warrior_spr/AnimationPlayer.play("die")
		#$Warrior_spr.play("die")
		##$Warrior_spr/warrior_legs.play("off")
		#""$Warrior_spr/warrior_shield.play("off")
		$hit_box.set_deferred("disabled", true)
		mouv.x= 0
		mouv.y= 0
		#attack_free = false
		body_check = false
		hitbox.set_deferred("disabled", true)
		$Warrior_spr/attack_check/hitbox_check.set_deferred("disabled", true)
		$Warrior_spr/barre_vie.play("off")
		$Warrior_spr/barre_vie/vie.play("off")
		if self.is_in_group("Character_blue"):
			self.remove_from_group("Character_blue")
		if timer_check == false:
			if is_network_master():
				$Timer.start()
			timer_check = true
	

func _attack_fin():
	if is_network_master():
		$Warrior_spr/AnimationPlayer.play("mouv")
		rpc("setAnim","mouv")

func _on_Timer_timeout():
	#queue_free()
	rpc("_queue_free")
	pass



puppet func setHealth(health):
	if ADD_HEALTH > 0:
		$Warrior_spr/barre_vie/divine_shield.scale.x = (health/1)
	else:
		HEALTH = health
		vie.scale.x=HEALTH/1.2

puppet func setPos(pos):
	position = pos

puppet func _apply_color(color):
	modulate = color

puppet func setAnim(anim_spr):
	$Warrior_spr/AnimationPlayer.play(anim_spr)

puppet func setAnimH(Barre,Vie):
	$Warrior_spr/barre_vie.play(Barre)
	$Warrior_spr/barre_vie/vie.play(Vie)

sync func _block_display():
	$block_display.play("on")
	$block_display/AnimationPlayer.play("de-pop")

sync func _block_display_off():
	$block_display.play("off")

sync func _speed_scale(spd):
	$Warrior_spr/AnimationPlayer.playback_speed = (spd/35)
	$Warrior_spr/warrior_legs.set_speed_scale(spd/35)
	$Warrior_spr.set_speed_scale(spd/35)
	$Warrior_spr/warrior_shield.set_speed_scale(spd/35)


sync func _queue_free():
	queue_free()








