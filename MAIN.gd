extends Node

var wiz_red

var wiz_blue

var spawn_point_bat
var spawn_point_eye

var tower_owner = ["Tower1",null,"Tower2",null,"Tower3",null,"Tower4",null]

const warrior_red_load = preload("res://Character/Warrior_bot.tscn")
const warrior_blue_load = preload("res://Character/Warrior_bot_blue.tscn")
const ranger_red_load = preload("res://Character/Ranger_bot.tscn")
const ranger_blue_load = preload("res://Character/Ranger_bot_blue.tscn")
const spearman_red_load = preload("res://Character/Spearman_bot.tscn")
const spearman_blue_load = preload("res://Character/Spearman_bot_blue.tscn")
const Bat_red_load = preload("res://Character/Bat_bot_red.tscn")
const Bat_blue_load = preload("res://Character/Bat_bot_blue.tscn")
const Eye_blue_load = preload("res://Character/Eye_bot_blue.tscn")
const Eye_red_load = preload("res://Character/Eye_bot_red.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var playerRed = preload("res://Character/Wizard.tscn").instance()
	playerRed.set_name(str(globals.playerHostId))
	playerRed.set_network_master(globals.playerHostId)
	add_child(playerRed)
	wiz_red = playerRed
	#playerRed.global_position = Vector2(900,586)
	#playerRed.global_position = $Portal_red/spawn_point_red
	playerRed.global_position = $Portal_red.global_position
		
	var playerBlue = preload("res://Character/Wizard_blue.tscn").instance()
	playerBlue.set_name(str(globals.playerJoinId))
	playerBlue.set_network_master(globals.playerJoinId)
	add_child(playerBlue)
	wiz_blue = playerBlue
	playerBlue.global_position = Vector2(1000,586)
	#playerBlue.global_position = $Portal_blue/spawn_point_blue
	
	
	var HUD_red = preload("res://HUD/HUD_red.tscn").instance()
	HUD_red.set_network_master(globals.playerHostId)
	#add_child(HUD_red)
	var HUD_blue = preload("res://HUD/HUD_blue.tscn").instance()
	HUD_blue.set_network_master(globals.playerJoinId)
	#add_child(HUD_blue)
	
	if playerRed.is_network_master():
		add_child(HUD_red)
		#HUD_blue.visible = false
	if wiz_blue.is_network_master():
		add_child(HUD_blue)
		#HUD_red.visible = false
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

	randomize()
	"""
	if get_tree().is_network_server():
		if Performance.get_monitor(Performance.TIME_FPS) < 120:
			Engine.time_scale = Performance.get_monitor(Performance.TIME_FPS)/120
		elif Engine.time_scale < 1:
			pass
			#Engine.time_scale += 0.01
		else:
			pass
			Engine.time_scale = 1
			##Engine.time_scale = 1
		
		rpc("_fix_time",Engine.time_scale)
	"""
	"""
	if Performance.get_monitor(Performance.TIME_FPS) < 120:
		Engine.time_scale -= 0.01
	elif Engine.time_scale < 1:
		Engine.time_scale += 0.01
	else:
		Engine.time_scale = 1
	"""
	#rpc_unreliable("send_client_image",client_image)
	
	
	#print(Performance.get_monitor(Performance.TIME_FPS))
	
	if Input.is_action_pressed("1"):
		$HUD/number_crystal/icon_warrior.play("pressed")
	else:
		$HUD/number_crystal/icon_warrior.play("default")

	if Input.is_action_pressed("2"):
		$HUD/number_crystal/icon_spear.play("pressed")
	else:
		$HUD/number_crystal/icon_spear.play("default")

	if Input.is_action_pressed("3"):
		$HUD/number_crystal/icon_ranger.play("pressed")
	else:
		$HUD/number_crystal/icon_ranger.play("default")

	if Input.is_action_pressed("4"):
		$HUD/number_crystal/icon_bat.play("pressed")
	else:
		$HUD/number_crystal/icon_bat.play("default")

	if Input.is_action_pressed("5"):
		$HUD/number_crystal/icon_eye.play("pressed")
	else:
		$HUD/number_crystal/icon_eye.play("default")


	if is_instance_valid(wiz_red):
		
		if wiz_red.is_network_master():
		
			if Input.is_action_just_pressed("1") && $HUD/number_crystal/icon_warrior.visible == true:
				if $HUD.crystal_num >=2:
					$HUD.crystal_num -= 2
					$HUD.change_exp(2)
					var warrior_red = warrior_red_load.instance()
					#get_parent().add_child(warrior_red)
					warrior_red.position=$Portal_red/spawn_point_red.global_position
					rpc("_spawn_warrior","RED")
				else:
					pass
		
			if Input.is_action_just_pressed("2") && $HUD/number_crystal/icon_spear.visible == true:
				if $HUD.crystal_num >=2:
					$HUD.crystal_num -= 2
					$HUD.change_exp(2)
					var spearman_red = spearman_red_load.instance()
					#get_parent().add_child(spearman_red)
					spearman_red.position=$Portal_red/spawn_point_red.global_position
					rpc("_spawn_spearman","RED")
				else:
					pass
		
		
			if Input.is_action_just_pressed("3") && $HUD/number_crystal/icon_ranger.visible == true:
				if $HUD.crystal_num >=3:
					$HUD.crystal_num -= 3
					$HUD.change_exp(3)
					var ranger_red = ranger_red_load.instance()
					#get_parent().add_child(ranger_red)
					ranger_red.position=$Portal_red/spawn_point_red.global_position
					rpc("_spawn_ranger","RED")
				else:
					pass
		
			if Input.is_action_just_pressed("4") && $HUD/number_crystal/icon_bat.visible == true:
				if $HUD.crystal_num >=4:
					$HUD.crystal_num -= 4
					$HUD.change_exp(4)
					var Bat_red = Bat_red_load.instance()
					spawn_point_bat = -randi() % 200
					#get_parent().add_child(Bat_red)
					Bat_red.position.y=($Portal_red/spawn_point_red.global_position.y+75)+spawn_point_bat
					Bat_red.position.x=$Portal_red/spawn_point_red.global_position.x
					rpc("_spawn_bat","RED",spawn_point_bat)
				else:
					pass
		
			if Input.is_action_just_pressed("5") && $HUD/number_crystal/icon_eye.visible == true:
				if $HUD.crystal_num >=5:
					$HUD.crystal_num -= 5
					$HUD.change_exp(5)
					var eye_red = Eye_red_load.instance()
					spawn_point_eye = -randi() % 190
					#get_parent().add_child(eye_red)
					eye_red.position.y=($Portal_red/spawn_point_red.global_position.y+70)+spawn_point_eye
					eye_red.position.x=$Portal_red/spawn_point_red.global_position.x
					rpc("_spawn_eye","RED",spawn_point_eye)
				else:
					pass
		
		
		
		
		
	if is_instance_valid(wiz_blue):
		
		if wiz_blue.is_network_master():
		
			if Input.is_action_just_pressed("1") && $HUD/number_crystal/icon_warrior.visible == true:
				if $HUD.crystal_num >=2:
					$HUD.crystal_num -= 2
					$HUD.change_exp(2)
					#$HUD.change_exp(2)
					var warrior_blue = warrior_blue_load.instance()
					#get_parent().add_child(warrior_blue)
					warrior_blue.position=$Portal_blue/spawn_point_blue.global_position
					rpc("_spawn_warrior","BLUE")
		
		
		
			if Input.is_action_just_pressed("3") && $HUD/number_crystal/icon_ranger.visible == true:
				if $HUD.crystal_num >=3:
					$HUD.crystal_num -= 3
					$HUD.change_exp(3)
					#$HUD.change_exp(3)
					#var ranger_blue = ranger_blue_load.instance()
					#get_parent().add_child(ranger_blue)
					#ranger_blue.position=$Portal_blue/spawn_point_blue.global_position
					rpc("_spawn_ranger","BLUE")
		
		
			if Input.is_action_just_pressed("2") && $HUD/number_crystal/icon_spear.visible == true:
				if $HUD.crystal_num >=2:
					$HUD.crystal_num -= 2
					$HUD.change_exp(2)
					#$HUD.change_exp(2)
					var spearman_blue = spearman_blue_load.instance()
					#get_parent().add_child(spearman_blue)
					spearman_blue.position=$Portal_blue/spawn_point_blue.global_position
					rpc("_spawn_spearman","BLUE")
		
		
		
			if Input.is_action_just_pressed("4") && $HUD/number_crystal/icon_bat.visible == true:
				if $HUD.crystal_num >=4:
					$HUD.crystal_num -= 4
					$HUD.change_exp(4)
					#$HUD.change_exp(4)
					var Bat_blue = Bat_blue_load.instance()
					spawn_point_bat = -randi() % 200
					#get_parent().add_child(Bat_blue)
					Bat_blue.position.y=($Portal_blue/spawn_point_blue.global_position.y+75)+spawn_point_bat
					Bat_blue.position.x=$Portal_blue/spawn_point_blue.global_position.x
					rpc("_spawn_bat","BLUE",spawn_point_bat)
		
		
			if Input.is_action_just_pressed("5") && $HUD/number_crystal/icon_eye.visible == true:
				if $HUD.crystal_num >=5:
					$HUD.crystal_num -= 5
					$HUD.change_exp(5)
					#$HUD.change_exp(5)
					var eye_blue = Eye_blue_load.instance()
					spawn_point_eye = -randi() % 190
					#get_parent().add_child(eye_blue)
					eye_blue.position.y=($Portal_blue/spawn_point_blue.global_position.y+70)+spawn_point_eye
					eye_blue.position.x=$Portal_blue/spawn_point_blue.global_position.x
					rpc("_spawn_eye","BLUE",spawn_point_eye)



func _PJ_respawn(TEAM):
	if TEAM == "RED" :
		$Portal_red.resp_timer = 5
		$Portal_red.count = true
		$Portal_red/PJ_respawn_spr.visible = true
	if TEAM == "BLUE":
		$Portal_blue.resp_timer = 5
		$Portal_blue.count = true
		$Portal_blue/PJ_respawn_spr.visible = true


sync func _spawn_warrior(TEAM):
	if TEAM == "RED" :
		var warrior_red = warrior_red_load.instance()
		get_parent().add_child(warrior_red,true)
		warrior_red.position=$Portal_red/spawn_point_red.global_position
		#print(warrior_red.name)
	if TEAM == "BLUE" :
		var warrior_blue = warrior_blue_load.instance()
		get_parent().add_child(warrior_blue,true)
		warrior_blue.position=$Portal_blue/spawn_point_blue.global_position

sync func _spawn_spearman(TEAM):
	if TEAM == "RED" :
		var spearman_red = spearman_red_load.instance()
		get_parent().add_child(spearman_red,true)
		spearman_red.position=$Portal_red/spawn_point_red.global_position
	if TEAM == "BLUE" :
		var spearman_blue = spearman_blue_load.instance()
		get_parent().add_child(spearman_blue,true)
		spearman_blue.position=$Portal_blue/spawn_point_blue.global_position

sync func _spawn_ranger(TEAM):
	if TEAM == "RED" :
		var ranger_red = ranger_red_load.instance()
		get_parent().add_child(ranger_red,true)
		ranger_red.position=$Portal_red/spawn_point_red.global_position
	if TEAM == "BLUE" :
		var ranger_blue = ranger_blue_load.instance()
		get_parent().add_child(ranger_blue,true)
		ranger_blue.position=$Portal_blue/spawn_point_blue.global_position


sync func _spawn_bat(TEAM,RNG):
	if TEAM == "RED" :
		var Bat_red = Bat_red_load.instance()
		get_parent().add_child(Bat_red)
		Bat_red.global_position.y=($Portal_red/spawn_point_red.global_position.y+75)+RNG
		Bat_red.global_position.x=$Portal_red/spawn_point_red.global_position.x
		Bat_red.set_network_master(globals.playerHostId)
	if TEAM == "BLUE" :
		var Bat_blue = Bat_blue_load.instance()
		get_parent().add_child(Bat_blue)
		Bat_blue.global_position.y=($Portal_blue/spawn_point_blue.global_position.y+75)+RNG
		Bat_blue.global_position.x=$Portal_blue/spawn_point_blue.global_position.x
		Bat_blue.set_network_master(globals.playerHostId)

sync func _spawn_eye(TEAM,RNG):
	if TEAM == "RED" :
		var eye_red = Eye_red_load.instance()
		get_parent().add_child(eye_red,true)
		eye_red.global_position.y=($Portal_red/spawn_point_red.global_position.y+70)+RNG
		eye_red.global_position.x=$Portal_red/spawn_point_red.global_position.x
	if TEAM == "BLUE" :
		var eye_blue = Eye_blue_load.instance()
		get_parent().add_child(eye_blue,true)
		eye_blue.global_position.y=($Portal_blue/spawn_point_blue.global_position.y+70)+RNG
		eye_blue.global_position.x=$Portal_blue/spawn_point_blue.global_position.x



#SPELLS COMMUNICATION


sync func _add_fire_blue():
		var Wizard = get_node(str(globals.playerJoinId))
		var fire = preload("res://Magie/fire.tscn").instance()
		Wizard.add_child(fire)
		Wizard.get_node("fire").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("fire").set_emitting(false)#a changer
		Wizard.get_node("fire").active = false


sync func _add_fire_red():
		var Wizard = get_node(str(globals.playerHostId))
		var fire = preload("res://Magie/fire.tscn").instance()
		Wizard.add_child(fire)
		Wizard.get_node("fire").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("fire").set_emitting(false)#a changer
		Wizard.get_node("fire").active = false


sync func _add_frost_blue():
		var Wizard = get_node(str(globals.playerJoinId))
		var frost = preload("res://Magie/frost.tscn").instance()
		Wizard.add_child(frost)
		Wizard.get_node("frost").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("frost").set_emitting(false)#a changer
		Wizard.get_node("frost").active = false

sync func _add_frost_red():
		var Wizard = get_node(str(globals.playerHostId))
		var frost = preload("res://Magie/frost.tscn").instance()
		Wizard.add_child(frost)
		Wizard.get_node("frost").global_position = Wizard.get_node("Wizard_arm").get_node("Position2D").global_position
		Wizard.get_node("frost").set_emitting(false)#a changer
		Wizard.get_node("frost").active = false



sync func _quit_game():
	get_tree().paused = true
	#get_tree().quit()








#puppet func _fix_time(time):
	#Engine.time_scale = time

