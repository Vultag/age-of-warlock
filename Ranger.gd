extends KinematicBody2D

var mouv = Vector2()
var attack_free = true
var arrow = arrow_load.instance()
var test = true
var Collision_on = "hit_box_R"
onready var HEALTH = 1
onready var vie = get_node("Ranger_spr/barre_vie/vie")
const GRAVITY = 4
const FLOOR = Vector2(0,-1)
const arrow_load = preload("res://projectiles/arrow_red.tscn")


func _process(delta):
	
	if attack_free == true:
		if Input.is_action_pressed("6") or Input.is_action_pressed("4"):
			$Ranger_spr.play("mouv")
			if Input.is_action_pressed("6"):
				mouv.x=40
				$Ranger_spr.scale.x=1
				Collision_on = "hit_box_R"

			if Input.is_action_pressed("4"):
				mouv.x=-40
				$Ranger_spr.scale.x=-1
				Collision_on = "hit_box_L"
		else :
			$Ranger_spr.play("static")
			mouv.x=0
	

	if Input.is_action_just_pressed("8"):
		#var arrow = arrow_load.instance()
		var angle_mouse = get_global_mouse_position().angle_to_point(position)
		test = true
		$Ranger_arm.set_speed_scale(0.8)
		$Ranger_arm.rotation=angle_mouse
		$Ranger_arm.play("shoot")
		#$Ranger_arm.position=$Position2D.global_position
		mouv.x=0
		attack_free = false
		$Ranger_spr.play("shoot")
		$Ranger_spr.scale.x = $Ranger_arm.scale.x
		if ($Ranger_arm.rotation_degrees)*sign($Ranger_arm.rotation_degrees)>90:
			$Ranger_spr.scale.x=-1
			$Ranger_arm.scale.y=-1
		else: 
			$Ranger_arm.scale.y=1
	if($Ranger_arm.get_frame()==7):
		var angle_mouse = get_global_mouse_position().angle_to_point(position)
		var arrow = arrow_load.instance()
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
		
		
	
	if ($Ranger_arm.get_frame()==14):
		$Ranger_spr.set_speed_scale(0.7)
		$Ranger_spr.play("reload")
		$Ranger_arm.play("off")

	if ($Ranger_spr.get_frame()==10):
		attack_free = true
		$Ranger_arm.play("static")

	if(Collision_on == "hit_box_L"):
		$hit_box_R.disabled=true
	else:$hit_box_R.disabled=false
	
	if(Collision_on == "hit_box_R"):
		$hit_box_L.disabled=true
	else:$hit_box_L.disabled=false
	
	
	vie.scale.x=HEALTH
	
	if(HEALTH<=0):
		queue_free()
	
	mouv.y+=GRAVITY

	mouv=move_and_slide(mouv,FLOOR)