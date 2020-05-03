extends KinematicBody2D

var HEALTH = 0.75
var ADD_HEALTH = 0
var max_HEALTH = 0.75
var mouv = Vector2()
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
var spell_mass_shield_selected = false
onready var vie = get_node("bat_spr/barre_vie/vie")
onready var barre_vie = get_node("bat_spr/barre_vie")
onready var divine_shield = get_node("bat_spr/barre_vie/divine_shield")

const divine_shield_load = preload("res://Magie/divine_shield.tscn")


func _ready():
	
	$AnimationPlayer.play("Bat_move")
	$bat_spr.scale.x= 1
	#$CollisionPolygon2D.scale.x = 1
	$attack_check.scale.x = 1
	
	pass 



func _physics_process(_delta):
	
	
	if mouv.x <= 0:
		$bat_spr.scale.x= -1
		$alive_detect.scale.x = -1
	else:
		$bat_spr.scale.x= 1
		$alive_detect.scale.x = 1
	
	#if $AnimationPlayer.get_current_animation()=="bat_move":
		#mouv.x = -45
	
	if $bat_spr.get_frame() == 2 && HEALTH>0:
		
		flap = true
	
	if $bat_spr.get_frame() == 3 && HEALTH>0:
		
		mouv.y = -113
		"""
		if self.global_position.y > 540:
			mouv.y = -140
		elif self.global_position.y < 450:
			mouv.y = 15
		else:
			mouv.y = -70.8
		"""
		
		pass
	
	if flap == true:
		if $bat_spr.get_frame() == 3 :
			i +=1
			flap = false
	
	
	if attack_free == true:
		if body_check == true:
			$AnimationPlayer.play("Bat_attack")
			if attack_check == false:
				if(is_instance_valid(body_char)):
					if body_char.is_in_group("Character_blue"):
						#if mouv.x*sign(mouv.x) <= max_mouv:
							mouv.x += 4*sign(body_char.global_position.x-self.global_position.x)
						#if mouv.y*sign(mouv.y) <= max_mouv:
							mouv.y -= 5*sign(self.global_position.y-body_char.global_position.y)
							GRAVITY = 0
							#if body_char.global_position.y < self.global_position.y:
								#body_check = false
								#body_char = null
					else:
						body_check = false
				else:
					body_check = false
		else:
			$AnimationPlayer.play("Bat_move")
			mouv.x = 45
			GRAVITY = 14
	
	
	if i >= 3:
		
		$attack_check/CollisionShape2D.disabled = false
		$attack_check.scale.x *=-1
		body_char = null
		i = 0
	
	if i == 2:
		#$attack_check/CollisionShape2D.disabled = false
		pass
	
	
	barre_vie.scale.x = max_HEALTH
	vie.value = (HEALTH/.75)*100
	
	if ADD_HEALTH > 0:
		divine_shield.scale.x = (ADD_HEALTH/1)
		$bat_spr/barre_vie.play("divine_shield")
		divine_shield.play("default")
	else:
		divine_shield.play("off")
		$bat_spr/barre_vie.play("on")
	
	if(HEALTH<=0):
		GRAVITY = 14
		$bat_spr/barre_vie.play("off")
		$alive_detect.set_disabled(true)
		if reset == true:
			$AnimationPlayer.play("die")
			#$CollisionPolygon2D.disabled = true
			reset = false
		
		if $bat_spr.get_animation() == "die":
			if $bat_spr.get_frame() != 5 :
				$AnimationPlayer.play("die")
				#$CollisionPolygon2D.disabled = true
			else:
				$AnimationPlayer.stop()
				#$CollisionPolygon2D.disabled = false
		if global_position.y > 704:
			mouv.x = 0
			mouv.y = 0
			GRAVITY = 0
			global_position.y = 704
			$AnimationPlayer.play("die_2")
			if $bat_spr.get_animation() == "die_2" && $bat_spr.get_frame() == 3:
				$AnimationPlayer.stop()
		
		if self.is_in_group("Character_red"):
			self.remove_from_group("Character_red")
		
		attack_free = false
		body_check = false
		$bat_spr/attack/CollisionShape2D.disabled = true
		$alive_detect.set_disabled(true)
		$bat_spr/barre_vie.play("off")
		if timer_check == false:
			$Timer.start()
			timer_check = true
	
	mouv.y+=GRAVITY
	
	mouv=move_and_slide(mouv,FLOOR)
	
	pass


func _take_damage(damage,knock):
	
	if ADD_HEALTH <= 0:
		HEALTH -= damage
	else:
		ADD_HEALTH -= damage
	
	global_position+=knock

func _on_attack_check_body_entered(body):
	if body.is_in_group("Character_blue"):
		if!(is_instance_valid(body_char)):
			body_char = body
			body_check = true

"""
func _on_attack_check_body_exited(body_char):
	if body_char.is_in_group("Character_blue"):
		#body_check = false
		pass
"""


func _on_attack_body_entered(body):
	if $bat_spr.get_animation() == "attack":
		if body.is_in_group("Character_blue"):
			body_check = false
			body._take_damage(0.25,Vector2(2,2))
			#$attack_check/CollisionShape2D.disabled = true
	else:
		pass

func _stuned():
	attack_free = false
	$bat_spr.stop()
	GRAVITY = 0

func _get_divine_shield():
	
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		divine_shield.global_position = global_position-Vector2(1,0)
		ADD_HEALTH = 1
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
	else:
		pass

func _on_Timer_timeout():
	queue_free()
