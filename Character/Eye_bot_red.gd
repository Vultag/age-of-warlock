extends RigidBody2D

var HEALTH = 1.25
var ADD_HEALTH = 0
var max_HEALTH = 1.25
var dead
var local_mouv = Vector2()
var mouv = Vector2()
var GRAVITY = 0
var body_char = null
var body_check = false
var test = true
var reset = true
var spd = 50
var HEAT = 0
const FLOOR = Vector2(0,-1)
onready var vie = get_node("eye_spr/barre_vie/vie")
onready var barre_vie = get_node("eye_spr/barre_vie")
onready var divine_shield = get_node("eye_spr/barre_vie/divine_shield")

const beam_load = preload("res://projectiles/Eye_beam_red.tscn")
const divine_shield_load = preload("res://Magie/divine_shield.tscn")


var velocity = Vector2()
var tegu_vel = Vector2()
var prev_pos = get_position()


func _ready():
	$AnimationPlayer.play("eye_idle")
	$eye_spr/tentacules.set_frame(0)
	$eye_spr/tentacules/tent.play("mouv")
	$eye_spr.scale.x= 1
	$CollisionPolygon2D.scale.x = 1
	barre_vie.scale.x = max_HEALTH
	vie.value = (HEALTH/1.25)*100
	if is_network_master():
		pass
	else:
		#$CollisionPolygon2D.disabled = true
		$aim_check/aim.disabled = true


func  _integrate_forces(state):
	if is_network_master():
		set_friction(0)
		state.set_linear_velocity((local_mouv/50)*spd)


func _physics_process(delta):
	
	
	if is_network_master():
		
		if local_mouv.x >=0:
			local_mouv.x -= 0.5
		
		if HEAT != 0:
			_apply_heat(HEAT)
			rpc("_apply_color",get_modulate())
		
		
		if body_check == true:
			if is_instance_valid(body_char) && body_char.is_in_group("Character_blue") && abs(body_char.global_position.x-self.global_position.x) <= 600:
				local_mouv.x = 0
				var angle_to_body = get_global_position().angle_to_point(body_char.global_position)
				if HEAT < -0.2:
					pass
				else:
					self.rotation = angle_to_body + PI
				rpc_unreliable("setRot",scale,rotation)
			else:
				body_check = false
				body_char = null
				reset = false
				$aim_check/aim.position.y = 0
				$aim_check/aim.disabled = false
				$AnimationPlayer.play("eye_idle")
				rpc_unreliable("setAnim",$AnimationPlayer.get_current_animation(),$AnimationPlayer.get_playing_speed(),self.scale,self.rotation)
				rotation = 0
				rpc_unreliable("setRot",scale,rotation)
		else:
			$aim_check/aim.disabled = false
			rpc_unreliable("setPos",position)



func _take_damage(damage,knock):
	if is_network_master():
		if ADD_HEALTH <= 0 :
			HEALTH -= damage
		else:
			ADD_HEALTH -= damage
			if ADD_HEALTH <= 0:
				rpc("_shield_broke")
		
		if HEALTH <=0 :
			rpc("_queue_free")
		elif ADD_HEALTH > 0:
			divine_shield.scale.x = (ADD_HEALTH/1)
			rpc("setHealth",ADD_HEALTH)
		else:
			$eye_spr/barre_vie/vie.value = ((HEALTH/0.75)*100)
			rpc("setHealth",HEALTH)
		
		global_position+=knock


sync func _get_divine_shield():
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		#rpc("_apply_spell","divine_shield")
		divine_shield.global_position = global_position-Vector2(1,0)
		$eye_spr/barre_vie/divine_shield.play("default")
		$eye_spr/barre_vie.play("divine_shield")
		ADD_HEALTH = 1
		$eye_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
		divine_shield.scale.x = (ADD_HEALTH/1)
		#rpc("setHealth",ADD_HEALTH)
	else:
		pass

sync func _shield_broke():
	ADD_HEALTH = 0
	$eye_spr/barre_vie.play("default")
	$eye_spr/barre_vie/divine_shield.play("off")

func _on_aim_check_body_entered(body):
	if is_network_master():
		if  body.is_in_group("Character_blue") && body_char == null:
			$AnimationPlayer.play("Eye_aim")
			rpc_unreliable("setAnim",$AnimationPlayer.get_current_animation(),$AnimationPlayer.get_playing_speed(),self.scale,self.rotation)
			$aim_check/aim.position.y = 1000
			$aim_check/aim.set_deferred("disabled",true)
			body_char = body
			body_check = true



func _push():
	if body_check == false:
		local_mouv.x += spd


func _shoot():
	if is_network_master():
		rpc("_add_beam")
		pass
	"""
	var beam = beam_load.instance()
	get_parent().get_parent().get_parent().add_child(beam)
	beam.position = $shoot_point.global_position
	beam.scale.x = 1
	beam.rotation = self.rotation# + deg2rad(180) #+3.14159
	"""



sync func _add_beam():
	
	var beam_red = beam_load.instance()
	beam_red.position = $shoot_point.global_position
	beam_red.scale.x = -1
	beam_red.rotation = self.rotation +3.14159
	get_parent().get_parent().get_parent().add_child(beam_red,true)


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
				$eye_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
				rpc("setHealth",ADD_HEALTH)
			else:
				$eye_spr/barre_vie/divine_shield.scale.x = (ADD_HEALTH/1)
				rpc("setHealth",HEALTH)
			rpc_unreliable("_speed_scale",50)
		if HEAT < 0:
			HEAT += 0.001
			if HEAT < -1:
				spd = 0
			else:
				spd = 50 *(1+HEAT)
			modulate = Color(1+HEAT,1,1,1)
			rpc_unreliable("_speed_scale",spd)


puppet func _apply_color(color):
	modulate = color



puppet func setHealth(health):
	if ADD_HEALTH > 0:
		divine_shield.scale.x = (health/1)
	else:
		HEALTH = health
		$eye_spr/barre_vie/vie.value = ((HEALTH/1.25)*100)

puppet func setPos(pos):
	position = pos


puppet func setAnim(anim_spr,anim_spd,Scale,rot):
	#$eye_spr.play(anim_spr)
	$AnimationPlayer.play(anim_spr,-1,anim_spd)
	self.scale = Scale
	self.rotation = rot
	#$eye_spr.scale = anim_scale

puppet func setRot(Scale,Rot):
	self.scale = Scale
	self.rotation = Rot


puppet func setAnimH(barre):
	$eye_spr/barre_vie.play(barre)
	pass



sync func _speed_scale(spd):
	$eye_spr/tentacules/tent.set_speed_scale(spd/50) 
	$AnimationPlayer.set_speed_scale(spd/50) 



sync func _queue_free():
	set_physics_process(false)
	get_parent().get_parent().queue_free()






