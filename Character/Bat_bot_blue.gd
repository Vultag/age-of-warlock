extends RigidBody2D

var HEALTH = 0.75
var max_HEALTH = 0.75
var ADD_HEALTH = 0
var mouv = Vector2()
var spd = 60
var attack_free = true
var attack_check = false
var body_check = false
var body_char
#var max_mouv = 160
var timer_check = false
var i = 0
#var stop = false
var flap = false
var reset = true
const FLOOR = Vector2(0,-1)
var GRAVITY = 14
var HEAT = 0

onready var vie = get_node("bat_spr/barre_vie/vie")
onready var barre_vie = get_node("bat_spr/barre_vie")

const divine_shield_load = preload("res://Magie/divine_shield.tscn")

func _ready():
	if is_network_master():
		$AnimationPlayer.play("Bat_move")
		$bat_spr.scale.x= -1
		$alive_detect.disabled = false
		#$CollisionPolygon2D.scale.x = 1
		$attack_check.scale.x = -1
		mouv.x = -60
	else:
		$AnimationPlayer.play("Bat_move")
		$bat_spr.scale.x= -1
		#$alive_detect.disabled = true
		$attack_check/CollisionShape2D.disabled = true
		$bat_spr/attack/CollisionShape2D.disabled = true
		#$CollisionPolygon2D.scale.x = 1
		$attack_check.scale.x = -1
		mouv.x = -60
	
	pass 

func  _integrate_forces(state):
	if is_network_master():
		set_friction(1)
		state.set_linear_velocity(Vector2(((mouv.x/60)*spd),mouv.y))


func _physics_process(_delta):
	
	if is_network_master():
		
		if global_position.y < globals.sol+20:
			mouv.y+=GRAVITY
		else:
			global_position.y = globals.sol+20
			mouv.y = 0
			
			if HEALTH <= 0:
				if $bat_spr.get_animation() == "die_2":
					#rpc_unreliable("setAnim",$AnimationPlayer.get_current_animation(),$bat_spr.scale,$AnimationPlayer.get_playing_speed())
					mouv.x = 0
					pass
				else:
					#rpc("_die2")
					$AnimationPlayer.play("die_2")
					rpc_unreliable("setAnim","die_2")
		
		
		if mouv.x <= 0:
			$bat_spr.scale.x= -1
			$alive_detect.scale.x = -1
			rpc_unreliable("setScale",$bat_spr.scale.x)
		else:
			$bat_spr.scale.x= 1
			$alive_detect.scale.x = 1
			rpc_unreliable("setScale",$bat_spr.scale.x)
	
		
		
		if body_check == true:
				if(is_instance_valid(body_char)) && HEAT >= 0:
					if body_char.is_in_group("Character_red"):
						
						mouv.x += 4*sign(body_char.global_position.x-self.global_position.x)
						mouv.y -= 5*sign(self.global_position.y-body_char.global_position.y)
						GRAVITY = 0
						
					else:
						mouv = Vector2(-60,0)
						GRAVITY = 14
						$bat_spr/attack/CollisionShape2D.disabled = true
						$AnimationPlayer.play("Bat_move")
						rpc_unreliable("setAnim","Bat_move")
						body_check = false
						body_char = null
				else:
					mouv = Vector2(-60,0)
					GRAVITY = 14
					$bat_spr/attack/CollisionShape2D.disabled = true
					$AnimationPlayer.play("Bat_move")
					rpc_unreliable("setAnim","Bat_move")
					body_check = false
					body_char = null
			
			
		
		rpc_unreliable("setPos",position)
		
		if HEAT != 0:
			_apply_heat(HEAT)
			rpc("_apply_color",get_modulate())
	
	

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
			$bat_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
			rpc("setHealth",ADD_HEALTH)
		else:
			$bat_spr/barre_vie/vie.value = ((HEALTH/0.75)*100)
			rpc("setHealth",HEALTH)
	
	#global_position+=knock


sync func _get_divine_shield():
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		#rpc("_apply_spell","divine_shield")
		divine_shield.global_position = global_position-Vector2(1,0)
		$bat_spr/barre_vie/divine_shield.play("default")
		$bat_spr/barre_vie.play("divine_shield")
		ADD_HEALTH = 1
		$bat_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
		$bat_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	else:
		pass


sync func _shield_broke():
	ADD_HEALTH = 0
	$bat_spr/barre_vie.play("default")
	$bat_spr/barre_vie/divine_shield.play("off")


func _apply_heat(Heat):
	if HEAT > 0:
		modulate = Color(1,(1-HEAT*2),(1-HEAT*2),1)
		if HEAT - 0.003 < 0:
			HEAT = 0
		else:
			HEAT -= 0.003
		if $bat_spr/barre_vie.visible == true:
			if HEALTH > 0 :
				HEALTH -= HEAT/400
			elif HEALTH <=0 :
				if is_network_master():
					rpc("_die")
			elif ADD_HEALTH > 0:
				$bat_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
				rpc("setHealth",ADD_HEALTH)
			else:
				$bat_spr/barre_vie/vie.value = ((HEALTH/0.75)*100)
				rpc("setHealth",HEALTH)
			rpc_unreliable("_speed_scale",60)
	if HEAT < 0:
		HEAT += 0.003
		if HEAT < -1:
			spd = 0
		else:
			spd = 40 *(1+HEAT)
		modulate = Color(1+HEAT*2,1,1,1)
		rpc_unreliable("_speed_scale",spd)

puppet func _apply_color(color):
	modulate = color



func _on_attack_check_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character_red") && HEALTH > 0:
			if!(is_instance_valid(body_char)):
				mouv.y = 0
				body_char = body
				body_check = true
				$AnimationPlayer.play("Bat_attack")
				rpc_unreliable("setAnim","Bat_attack")
				$bat_spr/attack/CollisionShape2D.set_deferred("disabled",false)

"""
func _on_attack_check_body_exited(body_char):
	if body_char.is_in_group("Character_red"):
		#body_check = false
		pass
"""


func _on_attack_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character_red") && HEALTH > 0:
			body_check = false
			body_char = null
			body._take_damage(0.25,Vector2(0,0))#-2,-2))
			mouv = Vector2(-60,0)
			GRAVITY = 14
			$AnimationPlayer.play("Bat_move")
			rpc_unreliable("setAnim","Bat_move")
			$bat_spr/attack/CollisionShape2D.set_deferred("disabled",true)
			#$attack_check/CollisionShape2D.set_deferred("disabled",true)
		elif body.is_in_group("obstacle"):
			mouv = Vector2(0,0)


puppet func setHealth(health):
	if ADD_HEALTH > 0:
		$bat_spr/barre_vie/divine_shield.scale.x = (health/1)
	else:
		HEALTH = health
		$bat_spr/barre_vie/vie.value = ((HEALTH/0.75)*100)


puppet func setPos(pos):
	position = pos


puppet func setAnim(anim_spr):
	$AnimationPlayer.play(anim_spr)

puppet func setScale(anim_scale):
	$bat_spr.scale.x = anim_scale
	$alive_detect.scale.x = anim_scale



puppet func setAnimH(barre):
	$bat_spr/barre_vie.play(barre)
	pass


func _on_Timer_timeout():
	rpc("_queue_free")
	pass 

func _flap():
	if is_network_master():
		mouv.x = -60
		$attack_check/CollisionShape2D.set_deferred("disabled",false)
		$attack_check.scale.x *=-1
		if global_position.y < 700:
			mouv.y = -130
		elif global_position.y > 1000:
			mouv.y = -200
		else:
			mouv.y = -185


sync func _die():
	if mouv.y < 0:
		mouv.y = 0
	GRAVITY = 14
	
	#rpc("_barre_vie_qf")
	$bat_spr/barre_vie.visible = false
	
	$AnimationPlayer.play("die")
	#rpc_unreliable("setAnim",$AnimationPlayer.get_current_animation(),$bat_spr.scale,$AnimationPlayer.get_playing_speed())
	$alive_detect.set_deferred("disabled", true)
	$bat_spr/attack/CollisionShape2D.set_deferred("disabled", true)
	$attack_check/CollisionShape2D.set_deferred("disabled", true)
	
	if self.is_in_group("Character_blue"):
		self.remove_from_group("Character_blue")
	
	body_check = false
	body_char = null
	
	if timer_check == false:
		if is_network_master():
			$Timer.start()
		timer_check = true

"""
sync func _die2():
	#set_sleeping(true)
	mouv.x = 0
	mouv.y = 0
	GRAVITY = 0
	#global_position.y = 704
	$AnimationPlayer.play("die_2")
	#rpc_unreliable("setAnim",$AnimationPlayer.get_current_animation(),$bat_spr.scale,$AnimationPlayer.get_playing_speed())
"""

sync func _speed_scale(spd):
	$AnimationPlayer.set_speed_scale(spd/60)


sync func _queue_free():
	queue_free()

#sync func _barre_vie_qf():
	#$bat_spr/barre_vie.visible = false
