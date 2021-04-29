extends RigidBody2D

var mouv = Vector2()
var attack_free = true
#var arrow = arrow_load.instance()
var test = true
var body_check = false
var body_char
#var target = false
var timer_check = false
var reset = false #reset aimcheck
var ADD_HEALTH = 0
var spell_mass_shield_selected = false
onready var HEALTH = 1
onready var vie = get_node("Ranger_spr/barre_vie/vie")
onready var divine_shield = get_node("Ranger_spr/barre_vie/divine_shield")
var GRAVITY = 14
var spd = 40
var HEAT = 0
const FLOOR = Vector2(0,-1)

const arrow_load = preload("res://projectiles/arrow_red.tscn")
const divine_shield_load = preload("res://Magie/divine_shield.tscn")

func _ready():
	if is_network_master():
		$Ranger_spr.scale.x = 1
		mouv.x = 40
		$Ranger_spr/Ranger_legs.play("mouv")
		#$Ranger_spr/shoot_check/CollisionShape2D.disabled = false
		$AnimationPlayer.play("mouv")
		$Ranger_spr.playing = false
	else:
		$Ranger_spr.scale.x = 1
		mouv.x = 40
		$Ranger_spr/Ranger_legs.play("mouv")
		$Ranger_spr/shoot_check/CollisionShape2D.disabled = true
		$AnimationPlayer.play("mouv")
		$Ranger_spr.playing = false
		$hit_box.disabled = true


func  _integrate_forces(state):
	if is_network_master():
		set_friction(0)
		state.set_linear_velocity((mouv/40)*spd)
		
		rpc_unreliable("setPos",position)
		if global_position.y < globals.sol:
			mouv.y+=GRAVITY
		else:
			mouv.y = 0

func _physics_process(_delta):
	
	if is_network_master():
		
		
		"""
		if HEAT < -1:
			HEAT = -1
		
		if HEAT < 0:
			modulate = Color(1+HEAT,1,1,1)
			HEAT += 0.00005
			#if spd > 0:
			spd = 40 *(1+HEAT/1)
			if HEALTH > 0:
				$Ranger_spr/Ranger_legs.set_speed_scale(spd/40)
				$Ranger_spr.set_speed_scale(spd/40)
				$Ranger_arm.set_speed_scale(spd/40)
			else:
				$Ranger_spr/Ranger_legs.set_speed_scale(1)
				$Ranger_spr.set_speed_scale(1)
				$Ranger_arm.set_speed_scale(1)
		if HEAT > 0:
			modulate = Color(1,1-HEAT,1-HEAT,1)
			HEAT -= 0.0001
			$Ranger_spr/Ranger_legs.set_speed_scale(1)
			$Ranger_spr.set_speed_scale(1)
			$Ranger_arm.set_speed_scale(1)
		"""
		
		if body_check == true:
			if is_instance_valid(body_char) && body_char.is_in_group("Character_blue"):
				if abs(body_char.global_position.x-self.global_position.x) <= 560 && abs(body_char.global_position.y-self.global_position.y) <= 550:
					var angle_to_body = body_char.get_global_position().angle_to_point(position)
					if body_char.get_global_position().y<self.global_position.y:
						$Ranger_arm.rotation=angle_to_body-((body_char.get_global_position().x-position.x)/1900)
					if body_char.get_global_position().y>=self.global_position.y:
						$Ranger_arm.rotation=angle_to_body-((body_char.get_global_position().x-position.x)/2000)
					$Ranger_spr.scale.x = $Ranger_arm.scale.x
					if ($Ranger_arm.rotation_degrees)*sign($Ranger_arm.rotation_degrees)>90:
						$Ranger_spr.scale.x=-1
						$Ranger_arm.scale.y=-1
					else: 
							$Ranger_arm.scale.y=1
					rpc_unreliable("_aim_remote",$Ranger_arm.rotation,$Ranger_arm.scale,$Ranger_spr.scale)
				else:
					mouv.x = 40
					body_check = false
					body_char = null
					$Ranger_spr/shoot_check/CollisionShape2D.position.y = 0
					$Ranger_spr/shoot_check/CollisionShape2D.set_deferred("disabled", false)
					$Ranger_spr/Ranger_legs.play("mouv")
					rpc_unreliable("setAnim","mouv",true)
					$Ranger_spr.scale.x = 1
					rpc("_set_scale")
			else:
				mouv.x = 40
				body_check = false
				body_char = null
				$Ranger_spr/shoot_check/CollisionShape2D.position.y = 0
				$Ranger_spr/shoot_check/CollisionShape2D.set_deferred("disabled", false)
				$Ranger_spr/Ranger_legs.play("mouv")
				rpc_unreliable("setAnim","mouv",true)
				$Ranger_spr.scale.x = 1
				rpc("_set_scale")
		
		
		
		
		if HEAT != 0:
			_apply_heat(HEAT)
			rpc("_apply_color",get_modulate())



func _on_shoot_check_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character_blue") && body_char == null:
			_aim()
			$Ranger_spr/shoot_check/CollisionShape2D.position.y = 1000
			$Ranger_spr/shoot_check/CollisionShape2D.set_deferred("disabled", true)
			body_char = body
			body_check = true




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
			divine_shield.scale.x = (ADD_HEALTH/1)
			rpc("setHealth",ADD_HEALTH)
		else:
			vie.scale.x=HEALTH/1
			rpc("setHealth",HEALTH)
		
		global_position+=knock
	

sync func _die():
		set_physics_process(false)
		$AnimationPlayer.play("die")
		#$Ranger_spr.play("die")
		#$Ranger_spr/Ranger_legs.play("off")
		#$Ranger_arm.play("off")
		#$hit_box.disabled = true
		mouv.x = 0
		mouv.y = 0
		attack_free = false
		body_check = false
		$hit_box.set_deferred("disabled", true)
		$Ranger_spr/shoot_check/CollisionShape2D.set_deferred("disabled", true)
		$Ranger_spr/barre_vie.play("off")
		$Ranger_spr/barre_vie/vie.play("off")
		if self.is_in_group("Character_red"):
			self.remove_from_group("Character_red")
		if timer_check == false:
			if is_network_master():
				$Timer.start()
			timer_check = true


func _aim():
	if $AnimationPlayer.get_current_animation() == "reload" or $Ranger_arm.get_frame() > 5:
		pass
	else:
		$AnimationPlayer.play("shoot")
		rpc_unreliable("setAnim","shoot",false)
	$Ranger_spr/Ranger_legs.play("static")
	rpc_unreliable("setAnim","static",true)
	#$Ranger_spr/Ranger_legs.play("static")
	#$Ranger_spr/shoot_check/CollisionShape2D.disabled = true
	#$Ranger_spr/shoot_check/CollisionShape2D.position.y = 1000
	#$Ranger_arm.set_speed_scale(0.8)
	##$Ranger_arm.play("shoot")
	mouv.x = 0


func _shoot():
	if is_network_master():
		rpc("_tir_arrow")


func _walk():
	mouv.x = 40
	body_check = false
	body_char = null
	$Ranger_spr/shoot_check/CollisionShape2D.position.y = 0
	if is_network_master():
		$Ranger_spr/shoot_check/CollisionShape2D.set_deferred("disabled", false)
		rpc_unreliable("setAnim","mouv",false)
	$AnimationPlayer.play("mouv")



func _on_AnimationPlayer_animation_finished(anim_name):
	if is_network_master():
		match anim_name:
			"shoot":
				$AnimationPlayer.play("reload")
				rpc_unreliable("setAnim","reload",false)
			"reload":
				if body_check == true:
					$AnimationPlayer.play("shoot")
					rpc_unreliable("setAnim","shoot",false)
				else:
					$AnimationPlayer.play("mouv")
					rpc_unreliable("setAnim","mouv",false)


sync func _get_divine_shield():
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		#rpc("_apply_spell","divine_shield")
		divine_shield.global_position = global_position-Vector2(1,0)
		$Ranger_spr/barre_vie/divine_shield.play("default")
		$Ranger_spr/barre_vie.play("divine_shield")
		ADD_HEALTH = 1
		$Ranger_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
		divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	else:
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
				divine_shield.scale.x = (ADD_HEALTH/1)
				rpc("setHealth",ADD_HEALTH)
			else:
				vie.scale.x=HEALTH/1.2
				rpc("setHealth",HEALTH)
			rpc_unreliable("_speed_scale",40)
		if HEAT < 0:
			HEAT += 0.001
			if HEAT < -1:
				spd = 0
			else:
				spd = 40 *(1+HEAT)
			modulate = Color(1+HEAT,1,1,1)
			rpc_unreliable("_speed_scale",spd)


puppet func _apply_color(color):
	modulate = color

sync func _shield_broke():
	ADD_HEALTH = 0
	$Ranger_spr/barre_vie.play("default")
	$Ranger_spr/barre_vie/divine_shield.play("off")

func _on_Timer_timeout():
	rpc("_queue_free")
	pass 

puppet func setHealth(health):
	if ADD_HEALTH > 0:
		divine_shield.scale.x = (health/1)
	else:
		HEALTH = health
		vie.scale.x=HEALTH/1

puppet func setPos(pos):
	position = pos


puppet func setAnim(anim,legs):
	if legs == true:
		$Ranger_spr/Ranger_legs.play(anim)
	else:
		$AnimationPlayer.play(anim)

puppet func _set_scale():
	$Ranger_spr.scale.x = 1

puppet func setAnimH(Barre,Vie):
	$Ranger_spr/barre_vie.play(Barre)
	$Ranger_spr/barre_vie/vie.play(Vie)


puppet func _aim_remote(aim_rot,arm_scale,ranger_scale):
	$Ranger_arm.rotation = aim_rot
	$Ranger_arm.scale = arm_scale
	$Ranger_spr.scale = ranger_scale


sync func _tir_arrow():
	
	var arrow_red = arrow_load.instance()
	
	
	arrow_red.global_rotation_degrees = $Ranger_arm.rotation_degrees
	#arrow.global_rotation = arrow_rotation
	arrow_red.mouv = Vector2(arrow_red.spd, 0).rotated(arrow_red.rotation)
	if ($Ranger_arm.rotation_degrees)*sign($Ranger_arm.rotation_degrees)>90:
		arrow_red.flip_v = 1
	else: 
		arrow_red.flip_v = 0
	#arrow.global_position = arrow_pos
	arrow_red.position=$Pos_R.global_position
	
	
	get_parent().add_child(arrow_red,true)


sync func _speed_scale(spd):
	$Ranger_spr/Ranger_legs.set_speed_scale(spd/40)
	$Ranger_spr.set_speed_scale(spd/40)
	$AnimationPlayer.set_speed_scale(spd/40) 


sync func _queue_free():
	queue_free()





