extends KinematicBody2D

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


func _physics_process(_delta):
	
	
	if HEAT < -1:
		HEAT = -1
	
	if HEAT < 0:
		modulate = Color(1+HEAT,1,1,1)
		HEAT += 0.00005
		#if spd > 0:
		spd = 35 *(1+HEAT/1)
		if HEALTH > 0:
			$Spearman_spr/Spearman_legs.set_speed_scale(spd/35)
			$Spearman_spr.set_speed_scale(spd/35)
		else:
			$Spearman_spr/Spearman_legs.set_speed_scale(1)
			$Spearman_spr.set_speed_scale(1)
	if HEAT > 0:
		modulate = Color(1,1-HEAT,1-HEAT,1)
		HEAT -= 0.0001
		$Spearman_spr/Spearman_legs.set_speed_scale(1)
		$Spearman_spr.set_speed_scale(1)
	
	
	if attack_free == true:
			#$Spearman_spr.play("mouv")
			$Spearman_spr/Spearman_legs.play("mouv")
			mouv.x=-spd
			$Spearman_spr.scale.x=-1

			if Input.is_action_pressed("K"):
				mouv.x=-spd
				$Spearman_spr.scale.x=-1
	
	if body_check == true:
		mouv.x=0
		attack_free = false
		$Spearman_spr.play("attack_mid")
		$Spearman_spr/Spearman_legs.play("static")
	if ($Spearman_spr.get_frame()==3 and $Spearman_spr.get_animation()=="attack_mid"):
		hitbox_mid.disabled = true
		$Spearman_spr/attack_check_mid/hit_box_check.disabled = true
	if ($Spearman_spr.get_frame()==4 and $Spearman_spr.get_animation()=="attack_mid"):
		hitbox_mid.disabled = false
		hit = false
		$Spearman_spr/attack_check_mid/hit_box_check.disabled = false
		if(is_instance_valid(body_char)):
			if !$Spearman_spr/attack_check_mid.overlaps_body(body_char):
				$Spearman_spr.play("aim_mid")
				$Spearman_spr.set_frame(3)
				body_check = false
				attack_free = true
		else:
			$Spearman_spr.play("aim_mid")
			$Spearman_spr.set_frame(3)
			body_check = false
			attack_free = true
		
	
	if(HEALTH>0):
		if(is_instance_valid(body_aim)):
			if $Spearman_spr/aim_check.overlaps_body(body_aim):
				if body_check == false:
					if body_aim.is_in_group("Character_red"):
						$Spearman_spr.play("aim_mid")
						hitbox_mid.disabled = false
			elif body_check == false:
				$Spearman_spr.play("aim_mid",true)

	
	vie.scale.x=HEALTH
	
	mouv.y+=GRAVITY
	
	
	mouv=move_and_slide(mouv,FLOOR)
	
	
	if(HEALTH<=0):
		$Spearman_spr.play("die")
		$Spearman_spr/Spearman_legs.play("off")
		$hit_box.disabled = true
		GRAVITY = 0
		mouv.x= 0
		mouv.y= 0
		attack_free = false
		body_check = false
		$hit_box.disabled = true
		$Spearman_spr/attack_check_mid/hit_box_check.disabled = true
		$Spearman_spr/attack_hitbox_mid/hitbox.disabled = true
		$Spearman_spr/aim_check/hitbox.disabled = true
		$Spearman_spr/barre_vie.play("off")
		$Spearman_spr/barre_vie/vie.play("off")
		if self.is_in_group("Character_blue"):
			self.remove_from_group("Character_blue")
		if timer_check == false:
			$Timer.start()
			timer_check = true
	

func _on_attack_hitbox_mid_body_entered(body):
	if hit == false:
		if body.is_in_group("Character_red"):
			body._take_damage(0.15,Vector2(-3,-1))
			hit = true
			#hitbox_mid.disabled=true
			#body_char = body


func _on_attack_check_mid_body_entered(body):
	if body.is_in_group("Character_red"):
		body_check = true
		body_char = body


func _take_damage(damage,knock):
	
	if ADD_HEALTH <= 0:
		HEALTH -= damage
	else:
		ADD_HEALTH -= damage
	
	global_position+=knock

func _stuned():
	attack_free = false
	$Spearman_spr.stop()
	GRAVITY = 0


func _on_aim_check_body_entered(body):
	if body.is_in_group("Character_red"):
		body_aim = body


func _on_Timer_timeout():
	queue_free()
	pass












