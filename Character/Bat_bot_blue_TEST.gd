extends KinematicBody2D

var HEALTH = 0.75
var max_HEALTH = 0.75
var mouv = Vector2()
var attack_free = true
var attack_check = false
var body_check = false
var body_char
var max_mouv = 160
var timer_check = false
var i = 0
var stop = false
var flap = false
var reset = true
const FLOOR = Vector2(0,-1)
var GRAVITY = 4
onready var vie = get_node("bat_spr/barre_vie/vie")
onready var barre_vie = get_node("bat_spr/barre_vie")


func _ready():
	
	$AnimationPlayer.play("Bat_move (copy)")
	mouv.x = -100
	GRAVITY = 4
	$bat_spr.scale.x= -1
	$CollisionPolygon2D.scale.x = -1
	
	pass 



func _process(delta):
	
	if mouv.x <= 0:
		$bat_spr.scale.x= -1
		$CollisionPolygon2D.scale.x = -1
	else:
		$bat_spr.scale.x= 1
		$CollisionPolygon2D.scale.x = 1
	
	#if $AnimationPlayer.get_current_animation()=="bat_move":
		#mouv.x = -45
	
	if $bat_spr.get_frame() == 2 && HEALTH>0:
		
		flap = true
	
	if $bat_spr.get_frame() == 3 && HEALTH>0:
		
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
					#if mouv.x*sign(mouv.x) <= max_mouv:
						mouv.x += 3*sign(body_char.global_position.x-self.global_position.x)
					#if mouv.y*sign(mouv.y) <= max_mouv:
						mouv.y -= 3*sign(self.global_position.y-body_char.global_position.y)
						GRAVITY = 0
						#if body_char.global_position.y < self.global_position.y:
							#body_check = false
							#body_char = null
				else:
					body_check = false
		else:
			#$AnimationPlayer.play("Bat_move (copy)")
			pass
			#mouv.x = -45
			#GRAVITY = 4
	
	
	if i >= 3:
		
		#$attack_check/CollisionShape2D.disabled = false
		body_char = null
		i = 0
	
	if i == 2:
		#$attack_check/CollisionShape2D.disabled = false
		pass
	
	
	$bat_spr/barre_vie.scale.x=max_HEALTH
	$bat_spr/barre_vie/vie.scale.x=HEALTH*1.75
	
	if(HEALTH<=0):
		GRAVITY = 4
		$bat_spr/barre_vie.play("off")
		$bat_spr/barre_vie/vie.play("off")
		$CollisionPolygon2D.set_disabled(true)
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

		
		attack_free = false
		body_check = false
		#$bat_spr/attack/CollisionShape2D.disabled = true
		self.remove_from_group("Character_blue")
		$bat_spr/barre_vie.play("off")
		$bat_spr/barre_vie/vie.play("off")
		if timer_check == false:
			$Timer.start()
			timer_check = true
	
	mouv.y+=GRAVITY
	
	mouv=move_and_slide(mouv,FLOOR)
	
	pass


func _take_damage(damage,knock):
	
	HEALTH -= damage
	
	global_position+=knock



func _on_Timer_timeout():
	queue_free()
