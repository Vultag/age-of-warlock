extends KinematicBody2D

# Declare member variables here. Examples:
var mouv = Vector2()
var attack_free = true
var body_check = false
var body_char
var body_aim
var hit = false
var timer_check = false
var ADD_HEALTH = 0
var spell_mass_shield_selected = false
onready var HEALTH = 1
onready var hitbox_mid = get_node("Spearman_spr/attack_hitbox_mid/hitbox")
onready var vie = get_node("Spearman_spr/barre_vie/vie")
onready var divine_shield = get_node("Spearman_spr/barre_vie/divine_shield")
var GRAVITY = 14
var HEAT = 0
const FLOOR = Vector2(0,-1)

const divine_shield_load = preload("res://Magie/divine_shield.tscn")


func _physics_process(_delta):
	
	if attack_free == true:
			#$Spearman_spr.play("mouv")
			$Spearman_spr/Spearman_legs.play("mouv")
			mouv.x=35
			$Spearman_spr.scale.x=1

			if Input.is_action_pressed("K"):
				mouv.x=-35
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
					if body_aim.is_in_group("Character_blue"):
						$Spearman_spr.play("aim_mid")
						hitbox_mid.disabled = false
			elif body_check == false:
				$Spearman_spr.play("aim_mid",true)
	
	
	vie.scale.x=HEALTH/1
	
	if ADD_HEALTH > 0:
		divine_shield.scale.x = (ADD_HEALTH/1)
		$Spearman_spr/barre_vie.play("divine_shield")
		divine_shield.play("default")
	else:
		divine_shield.play("off")
		$Spearman_spr/barre_vie.play("default")
	
	
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
		if self.is_in_group("Character_red"):
			self.remove_from_group("Character_red")
		if timer_check == false:
			$Timer.start()
			timer_check = true
	


func _take_damage(damage,knock):
	
	if ADD_HEALTH <= 0:
		HEALTH -= damage
	else:
		ADD_HEALTH -= damage
	
	global_position+=knock



func _on_attack_hitbox_mid_body_entered(body):
	if hit == false:
		if body.is_in_group("Character_blue"):
			body._take_damage(0.15,Vector2(3,-1))
			hit = true
			#hitbox_mid.disabled=true
			#body_char = body


func _on_attack_check_mid_body_entered(body):
	if body.is_in_group("Character_blue"):
		body_check = true
		body_char = body


func _on_aim_check_body_entered(body):
	if body.is_in_group("Character_blue"):
		body_aim = body


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
	pass 
