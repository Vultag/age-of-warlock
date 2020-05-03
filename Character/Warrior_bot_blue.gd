extends KinematicBody2D

# Declare member variables here. Examples:
var timer_check = false
var mouv = Vector2()
var spd = 35
var attack_free = true
var body_check = false
var body_char
var hit = false
onready var HEALTH = 1.2
onready var hitbox = get_node("Warrior_spr/attack_hitbox/hitbox")
onready var vie = get_node("Warrior_spr/barre_vie/vie")
onready var divine_shield = get_node("Warrior_spr/barre_vie/divine_shield")
var GRAVITY = 14
var HEAT = 0
const FLOOR = Vector2(0,-1)


func _physics_process(_delta):
	
	randomize()
	
	if HEAT < -1:
		HEAT = -1
	
	if HEAT < 0:
		modulate = Color(1+HEAT,1,1,1)
		HEAT += 0.001
		#if spd > 0:
		spd = 35 *(1+HEAT/1)
		if HEALTH > 0:
			$Warrior_spr/warrior_legs.set_speed_scale(spd/35)
			$Warrior_spr.set_speed_scale(spd/35)
			$Warrior_spr/warrior_shield.set_speed_scale(spd/35)
		else:
			$Warrior_spr/warrior_legs.set_speed_scale(1)
			$Warrior_spr.set_speed_scale(1)
			$Warrior_spr/warrior_shield.set_speed_scale(1)
	if HEAT > 0:
		modulate = Color(1,1-HEAT,1-HEAT,1)
		HEAT -= 0.003
		HEALTH -= HEAT/400
		$Warrior_spr/warrior_legs.set_speed_scale(1)
		$Warrior_spr.set_speed_scale(1)
		$Warrior_spr/warrior_shield.set_speed_scale(1)
	
	
	if attack_free == true:
			$Warrior_spr.play("mouv")
			$Warrior_spr/warrior_legs.play("mouv")
			mouv.x=-spd
			$Warrior_spr.scale.x=-1

			if Input.is_action_pressed("K"):
				mouv.x=-spd
				$Warrior_spr.scale.x=-1
	
	if body_check == true:
		mouv.x=0
		attack_free = false
		$Warrior_spr.play("attack")
		$Warrior_spr/warrior_legs.play("static")
	
	if ($Warrior_spr.get_frame()==5 and $Warrior_spr.get_animation()=="attack"):
		hitbox.disabled=false
		hit = false
	
	if ($Warrior_spr.get_frame()==9 and $Warrior_spr.get_animation()=="attack"):
		$Warrior_spr.play("static")
		#$Warrior_spr/warrior_legs.play("static")
		attack_free = true
		hitbox.disabled=true
		hit = false
		
		if is_instance_valid(body_char):
			if!($Warrior_spr/attack_check.overlaps_body(body_char)):
				body_check = false
		else:
			body_check = false
	
	
	if HEALTH <= 1.2:
		vie.scale.x=HEALTH/1.2
		divine_shield.play("off")
	elif HEALTH > 1.2:
		vie.scale.x = 1
		divine_shield.play("default")
	
	
	
	mouv.y+=GRAVITY
	
	
	mouv=move_and_slide(mouv,FLOOR)
	
	
	if(HEALTH<=0):
		$Warrior_spr.play("die")
		$Warrior_spr/warrior_legs.play("off")
		$Warrior_spr/warrior_shield.play("off")
		$hit_box.disabled = true
		GRAVITY = 0
		mouv.x= 0
		mouv.y= 0
		attack_free = false
		body_check = false
		hitbox.disabled = true
		$Warrior_spr/attack_check/hitbox_check.disabled = true
		$Warrior_spr/barre_vie.play("off")
		$Warrior_spr/barre_vie/vie.play("off")
		if self.is_in_group("Character_blue"):
			self.remove_from_group("Character_blue")
		if timer_check == false:
			$Timer.start()
			timer_check = true
	
	

func _on_attack_hitbox_body_entered(body):
	if body.is_in_group("Character_red"):
		body_char = body
	if hit == false:
		if body.is_in_group("Character_red"):
			body._take_damage(0.20,Vector2(-4,-2))
			hit = true
			#hitbox.disabled = true


func _on_attack_check_body_entered(body):
	if body.is_in_group("Character_red"):
		body_check = true
		#body_char = body


func _take_damage(damage,knock):
	
	var block_chance
	
	if damage <= 0.2:
		block_chance = randi() % 9
		if block_chance < 3.33:
			global_position+=knock
			$block_display.play("on")
			$block_display/AnimationPlayer.play("de-pop")
			$Warrior_spr/warrior_shield.play("block")
		else :
			$Warrior_spr/warrior_shield.play("static")
			$block_display.play("off")
			HEALTH -= damage
			global_position+=knock/2
	else :
		HEALTH -= damage
		global_position+=knock

func _stuned():
	attack_free = false
	$Warrior_spr.stop()
	GRAVITY = 0


func _on_Timer_timeout():
	queue_free()
	pass









