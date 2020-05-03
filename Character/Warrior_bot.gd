extends KinematicBody2D

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
var HEAT = 0
const FLOOR = Vector2(0,-1)

const divine_shield_load = preload("res://Magie/divine_shield.tscn")


func _physics_process(_delta):
	
	#self.modulate = Color(1.4,1.4,1.4)
	
	randomize()
	
	if attack_free == true:
			$Warrior_spr.play("mouv")
			$Warrior_spr/warrior_legs.play("mouv")
			mouv.x=35
			$Warrior_spr.scale.x=1

			if Input.is_action_pressed("K"):
				mouv.x=-35
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
	
	
	vie.scale.x=HEALTH/1.2
	
	if ADD_HEALTH > 0:
		divine_shield.scale.x = (ADD_HEALTH/1)
		$Warrior_spr/barre_vie.play("divine_shield")
		divine_shield.play("default")
	else:
		divine_shield.play("off")
		$Warrior_spr/barre_vie.play("default")
	
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
		if self.is_in_group("Character_red"):
			self.remove_from_group("Character_red")
		if timer_check == false:
			$Timer.start()
			timer_check = true
	
	

func _on_attack_hitbox_body_entered(body):
	if body.is_in_group("Character_blue"):
		body_char = body
	if hit == false:
		if body.is_in_group("Character_blue"):
			body._take_damage(0.20,Vector2(4,-2))
			hit = true
			#hitbox.disabled = true


func _on_attack_check_body_entered(body):
	if body.is_in_group("Character_blue"):
		#body_char = body
		body_check = true


func _take_damage(damage,knock):
	
	var block_chance
	
	if damage <= 0.3:
		block_chance = randi() % 9
		if block_chance < 3.33:
			global_position+=knock
			$block_display.play("on")
			$block_display/AnimationPlayer.play("de-pop")
			$Warrior_spr/warrior_shield.play("block")
		else :
			$Warrior_spr/warrior_shield.play("static")
			$block_display.play("off")
			if ADD_HEALTH <= 0 :
				HEALTH -= damage
			else:
				ADD_HEALTH -= damage
			global_position+=knock/2
	else :
		HEALTH -= damage
		global_position+=knock


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


func _stuned():
	attack_free = false
	$Warrior_spr.stop()
	GRAVITY = 0


func _on_Timer_timeout():
	queue_free()
	pass







