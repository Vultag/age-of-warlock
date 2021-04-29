extends RigidBody2D

# Declare member variables here. Examples:
var mouv = Vector2()
var spd = 35
var attack_free = true
var body_check = false
var body_char
var body_aim
var hit = false
var timer_check = false
var ADD_HEALTH = 0
onready var HEALTH = 1
onready var hitbox_mid = get_node("Spearman_spr/attack_hitbox_mid/hitbox")
onready var vie = get_node("Spearman_spr/barre_vie/vie")
var GRAVITY = 14
var HEAT = 0
const FLOOR = Vector2(0,-1)

const divine_shield_load = preload("res://Magie/divine_shield.tscn")


func _ready():
	
	if is_network_master():
		$Spearman_spr.scale.x = -1
		mouv.x = -35
		$Spearman_spr.play("static")
		$Spearman_spr/Spearman_legs.play("mouv")
	else:
		$Spearman_spr.scale.x = -1
		$Spearman_spr/aim_check/hitbox.disabled = true
		$Spearman_spr/attack_hitbox_mid/hitbox.disabled = true
		#$hit_box.disabled = true
		$Spearman_spr.scale.x = -1
		mouv.x = -35
		$Spearman_spr.play("static")
		$Spearman_spr/Spearman_legs.play("mouv")

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
		
		
		if HEAT != 0:
			_apply_heat(HEAT)
			rpc("_apply_color",get_modulate())
		
		
		
		
	




func _on_attack_hitbox_mid_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character_red") && HEALTH > 0:
			$AnimationPlayer.play("attack")
			rpc("setAnim","attack")
			body._take_damage(0.05,Vector2(-2,-2))#3,-1))
			hit = true
			#hitbox_mid.disabled=true
			#body_char = body
		#else:
			#$AnimationPlayer.play("raise_mid")


func _on_aim_check_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character_red") && HEALTH > 0:
			$AnimationPlayer.play("aim_mid")
			rpc("setAnim","aim_mid")
			$Spearman_spr/aim_check/hitbox.set_deferred("disabled", true)
			$Spearman_spr/aim_check/hitbox.position.y = 1000
			#body_aim = body


func _take_damage(damage,knock):
	if is_network_master():
		if ADD_HEALTH <= 0 :
			HEALTH -= damage
		else:
			ADD_HEALTH -= damage
			if ADD_HEALTH <= 0:
				rpc("_shield_broke")
		
		if HEALTH <=0 :
			if is_network_master():
				rpc("_die")
		elif ADD_HEALTH > 0:
			$Spearman_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
			rpc("setHealth",ADD_HEALTH)
		else:
			vie.scale.x=HEALTH/1
			rpc("setHealth",HEALTH)
		
		global_position+=knock
	

sync func _get_divine_shield():
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		#rpc("_apply_spell","divine_shield")
		divine_shield.global_position = global_position-Vector2(1,0)
		$Spearman_spr/barre_vie/divine_shield.play("default")
		$Spearman_spr/barre_vie.play("divine_shield")
		ADD_HEALTH = 1
		$Spearman_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
		$Spearman_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	else:
		pass

sync func _shield_broke():
	ADD_HEALTH = 0
	$Spearman_spr/barre_vie.play("default")
	$Spearman_spr/barre_vie/divine_shield.play("off")


sync func _die():
		set_physics_process(false)
		$AnimationPlayer.play("die")
		$Spearman_spr/barre_vie.queue_free()
		#$Ranger_spr.play("die")
		#$Ranger_spr/Ranger_legs.play("off")
		#$Ranger_arm.play("off")
		#$hit_box.disabled = true
		mouv.x = 0
		mouv.y = 0
		body_check = false
		$hit_box.set_deferred("disabled", true)
		$Spearman_spr/attack_hitbox_mid.set_deferred("disabled", true)
		$Spearman_spr/aim_check/hitbox.set_deferred("disabled", true)
		$Spearman_spr/barre_vie.play("off")
		$Spearman_spr/barre_vie/vie.play("off")
		if self.is_in_group("Character_blue"):
			self.remove_from_group("Character_blue")
		if timer_check == false:
			if is_network_master():
				$Timer.start()
			timer_check = true



func _attack_again():
	if is_network_master():
		if  hit == true:
			$AnimationPlayer.play("attack")
			rpc("setAnim","attack")
			hit = false
		else:
			$AnimationPlayer.play("raise_mid")
			rpc("setAnim","raise_mid")

func _scan():
	if is_network_master():
		$Spearman_spr/aim_check/hitbox.set_deferred("disabled", false)
		$Spearman_spr/aim_check/hitbox.position.y = 0


func _on_Timer_timeout():
	rpc("_queue_free")
	pass

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
				$Spearman_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
				rpc("setHealth",ADD_HEALTH)
			else:
				vie.scale.x=HEALTH/1.2
				rpc("setHealth",HEALTH)
			rpc_unreliable("_speed_scale",35)
		if HEAT < 0:
			HEAT += 0.001
			if HEAT < -1:
				spd = 0
			else:
				spd = 35 *(1+HEAT)
			modulate = Color(1+HEAT,1,1,1)
			rpc_unreliable("_speed_scale",spd)


puppet func _apply_color(color):
	modulate = color

puppet func setHealth(health):
	if ADD_HEALTH > 0:
		$Spearman_spr/barre_vie/divine_shield.scale.x = (health/1)
	else:
		HEALTH = health
		vie.scale.x=HEALTH/1

puppet func setPos(pos):
	position = pos


puppet func setAnim(anim_spr):
	$AnimationPlayer.play(anim_spr)

puppet func setAnimH(Barre,Vie):
	$Spearman_spr/barre_vie.play(Barre)
	$Spearman_spr/barre_vie/vie.play(Vie)


sync func _speed_scale(spd):
	$AnimationPlayer.playback_speed = (spd/35)
	$Spearman_spr/Spearman_legs.set_speed_scale(spd/35)
	$Spearman_spr.set_speed_scale(spd/35)


sync func _queue_free():
	queue_free()








