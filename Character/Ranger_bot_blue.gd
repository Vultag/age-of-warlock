extends KinematicBody2D

var mouv = Vector2()
var spd = 40
var attack_free = true
#var arrow = arrow_load.instance()
var test = true
var body_check = false
var body_char = null
var timer_check = false
var reset = false
onready var HEALTH = 1
onready var vie = get_node("Ranger_spr/barre_vie/vie")
var GRAVITY = 14
var HEAT = 0
const FLOOR = Vector2(0,-1)
const arrow_load = preload("res://projectiles/arrow_blue.tscn")


func _physics_process(delta):
	
	
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
	
	
	if attack_free == true && body_check == false:
			$Ranger_spr/Ranger_legs.play("mouv")
			mouv.x=-40
			$Ranger_spr.scale.x=-1
			$hit_box.scale.x=-1

			if Input.is_action_pressed("4"):
				mouv.x=-40
				$Ranger_spr.scale.x=1
				$hit_box.scale.x=1


	if attack_free == true:
		#if $Ranger_spr/shoot_check.overlaps_body(body_char):
		if body_check == true:
			if body_char.is_in_group("Character_red"):
				#var arrow = arrow_load.instance()
				var angle_to_body = body_char.get_global_position().angle_to_point(position)
				test = true
				$Ranger_arm.set_speed_scale(0.8)
				if body_char.get_global_position().y<self.global_position.y:
					$Ranger_arm.rotation=angle_to_body-((body_char.get_global_position().x-position.x)/1900)
				if body_char.get_global_position().y>=self.global_position.y:
					$Ranger_arm.rotation=angle_to_body-((body_char.get_global_position().x-position.x)/2000)
				$Ranger_arm.play("shoot")
				#$Ranger_arm.position=$Position2D.global_position
				mouv.x=0
				$Ranger_spr/Ranger_legs.play("static")
				$Ranger_spr.play("shoot")
				$Ranger_spr.scale.x = $Ranger_arm.scale.x
				if ($Ranger_arm.rotation_degrees)*sign($Ranger_arm.rotation_degrees)>90:
					$Ranger_spr.scale.x=-1
					$Ranger_arm.scale.y=-1
				else: 
					$Ranger_arm.scale.y=1
				if($Ranger_arm.get_frame()==7):
					#var angle_mouse = get_global_mouse_position().angle_to_point(position)
					var arrow = arrow_load.instance()
					attack_free = false
					if(test == true):
						get_parent().add_child(arrow)
						test=false
					$Ranger_arm.set_speed_scale(3)
					#$Ranger_arm.rotation=angle_mouse
					#$Ranger_spr.flip_h = $Ranger_arm.flip_h
					arrow.global_rotation_degrees = $Ranger_arm.rotation_degrees
					arrow.mouv = Vector2(arrow.spd, 0).rotated(arrow.global_rotation)
					#arrow.position = $Position2D.global_position
					if ($Ranger_arm.rotation_degrees)*sign($Ranger_arm.rotation_degrees)>90:
						arrow.flip_v = 1
						arrow.position=$Pos_R.global_position#+Vector2(6,0)
					else: 
						arrow.flip_v = 0
						arrow.position=$Pos_R.global_position
			else:
				if reset == true:
					body_check = false
					body_char = null
					reset = false
					$Ranger_spr/shoot_check/CollisionShape2D.position.y = 1000
				if reset == false:
					$Ranger_spr/shoot_check/CollisionShape2D.position.y = 0
	
	
	
	if ($Ranger_arm.get_frame()==14):
		$Ranger_spr.set_speed_scale(0.7)
		$Ranger_spr.play("reload")
		$Ranger_arm.play("off")

	if ($Ranger_spr.get_frame()==10):
		attack_free = true
		#$Ranger_arm.play("static")
	
	
	vie.scale.x=HEALTH
	
	if(HEALTH<=0):
		$Ranger_spr.play("die")
		$Ranger_spr/Ranger_legs.play("off")
		$Ranger_arm.play("off")
		$hit_box.disabled = true
		GRAVITY = 0
		mouv.x = 0
		mouv.y = 0
		attack_free = false
		body_check = false
		$hit_box.disabled = true
		$Ranger_spr/shoot_check/CollisionShape2D.disabled = true
		$Ranger_spr/barre_vie.play("off")
		$Ranger_spr/barre_vie/vie.play("off")
		if self.is_in_group("Character_blue"):
			self.remove_from_group("Character_blue")
		if timer_check == false:
			$Timer.start()
			timer_check = true
	
	
	mouv.y+=GRAVITY

	mouv=move_and_slide(mouv,FLOOR)
	
	

func _on_shoot_check_body_entered(body):
	if body.is_in_group("Character_red") && body_char == null:
		body_char = body
		body_check = true
		reset = true


func _on_shoot_check_body_exited(body):
	if body.is_in_group("Character_red"):
		if reset == true:
			body_check = false
			body_char = null
			reset = false
			$Ranger_spr/shoot_check/CollisionShape2D.position.y = 1000
		if reset == false:
			$Ranger_spr/shoot_check/CollisionShape2D.position.y = 0

func _take_damage(damage,knock):
	
	HEALTH -= damage
	
	global_position+=knock

func _stuned():
	attack_free = false
	$Ranger_spr.stop()
	GRAVITY = 0

func _on_Timer_timeout():
	queue_free()
	pass 



