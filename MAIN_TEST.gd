extends Node

var wiz_red

var wiz_blue

var spawn_point_bat
var spawn_point_eye

var HOST

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
	playerRed.global_position = Vector2(900,586)
		
	var playerBlue = preload("res://Character/Wizard_blue.tscn").instance()
	playerBlue.set_name(str(globals.playerJoinId))
	playerBlue.set_network_master(globals.playerJoinId)
	add_child(playerBlue)
	wiz_blue = playerBlue
	playerBlue.global_position = Vector2(1000,586)
	
	if is_network_master():
		HOST = true
	else:
		HOST = false

	
	if HOST == false:
		#$Portal_blue.queue_free()
		#$Portal_red.queue_free()
		#$background.queue_free()
		#$ground.queue_free()
		#$tile_map_ground.queue_free()
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#rpc_unreliable("send_client_image",get_viewport().get_texture())
	
	if  HOST == true:
		
		randomize()
		
		#client_image = get_viewport().get_texture()
		#$image_client.set_texture(get_viewport().get_texture())
		#$image_client.set_texture(client_image)
		rpc_unreliable("send_client_image",$ground.get_texture())
		print($ground.get_texture())
		
		#rset("$image_client.texture",$ground.get_texture())
		
		
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
			
				if Input.is_action_just_pressed("1"):
					if $HUD.crystal_num >=2:
						$HUD.crystal_num -= 2
						var warrior_red = warrior_red_load.instance()
						get_parent().add_child(warrior_red)
						warrior_red.position=$Portal_red/spawn_point_red.global_position
						rpc_unreliable("_spawn_warrior","RED")
					else:
						pass
			
				if Input.is_action_just_pressed("2"):
					if $HUD.crystal_num >=2:
						$HUD.crystal_num -= 2
						var spearman_red = spearman_red_load.instance()
						get_parent().add_child(spearman_red)
						spearman_red.position=$Portal_red/spawn_point_red.global_position
						rpc_unreliable("_spawn_spearman","RED")
					else:
						pass
			
			
				if Input.is_action_just_pressed("3"):
					if $HUD.crystal_num >=3:
						$HUD.crystal_num -= 3
						var ranger_red = ranger_red_load.instance()
						get_parent().add_child(ranger_red)
						ranger_red.position=$Portal_red/spawn_point_red.global_position
						rpc_unreliable("_spawn_ranger","RED")
					else:
						pass
			
				if Input.is_action_just_pressed("4"):
					if $HUD.crystal_num >=4:
						$HUD.crystal_num -= 4
						var Bat_red = Bat_red_load.instance()
						spawn_point_bat = -randi() % 200
						get_parent().add_child(Bat_red)
						Bat_red.position.y=($Portal_red/spawn_point_red.global_position.y+75)+spawn_point_bat
						Bat_red.position.x=$Portal_red/spawn_point_red.global_position.x
						rpc_unreliable("_spawn_bat","RED",spawn_point_bat)
					else:
						pass
			
				if Input.is_action_just_pressed("5"):
					if $HUD.crystal_num >=5:
						$HUD.crystal_num -= 5
						var eye_red = Eye_red_load.instance()
						spawn_point_eye = -randi() % 190
						get_parent().add_child(eye_red)
						eye_red.position.y=($Portal_red/spawn_point_red.global_position.y+70)+spawn_point_eye
						eye_red.position.x=$Portal_red/spawn_point_red.global_position.x
						rpc_unreliable("_spawn_eye","RED",spawn_point_eye)
					else:
						pass
			
			
			
			
			
		if is_instance_valid(wiz_blue):
			
			if wiz_blue.is_network_master():
			
				if Input.is_action_just_pressed("1"):
					if $HUD.crystal_num >=2:
						$HUD.crystal_num -= 2
						var warrior_blue = warrior_blue_load.instance()
						get_parent().add_child(warrior_blue)
						warrior_blue.position=$Portal_blue/spawn_point_blue.global_position
						rpc_unreliable("_spawn_warrior","BLUE")
			
			
			
				if Input.is_action_just_pressed("3"):
					if $HUD.crystal_num >=3:
						$HUD.crystal_num -= 3
						var ranger_blue = ranger_blue_load.instance()
						get_parent().add_child(ranger_blue)
						ranger_blue.position=$Portal_blue/spawn_point_blue.global_position
						rpc_unreliable("_spawn_ranger","BLUE")
			
			
				if Input.is_action_just_pressed("2"):
					if $HUD.crystal_num >=2:
						$HUD.crystal_num -= 2
						var spearman_blue = spearman_blue_load.instance()
						get_parent().add_child(spearman_blue)
						spearman_blue.position=$Portal_blue/spawn_point_blue.global_position
						rpc_unreliable("_spawn_spearman","BLUE")
			
			
			
				if Input.is_action_just_pressed("4"):
					if $HUD.crystal_num >=4:
						$HUD.crystal_num -= 4
						var Bat_blue = Bat_blue_load.instance()
						spawn_point_bat = -randi() % 200
						get_parent().add_child(Bat_blue)
						Bat_blue.position.y=($Portal_blue/spawn_point_blue.global_position.y+75)+spawn_point_bat
						Bat_blue.position.x=$Portal_blue/spawn_point_blue.global_position.x
						rpc_unreliable("_spawn_bat","BLUE",spawn_point_bat)
			
			
				if Input.is_action_just_pressed("5"):
					if $HUD.crystal_num >=5:
						$HUD.crystal_num -= 5
						var eye_blue = Eye_blue_load.instance()
						spawn_point_eye = -randi() % 190
						get_parent().add_child(eye_blue)
						eye_blue.position.y=($Portal_blue/spawn_point_blue.global_position.y+70)+spawn_point_eye
						eye_blue.position.x=$Portal_blue/spawn_point_blue.global_position.x
						rpc_unreliable("_spawn_eye","BLUE",spawn_point_eye)
	if HOST == false:
		#rpc_unreliable("send_client_image",client_image)
		pass



func _PJ_respawn(TEAM):
	if TEAM == "RED" :
		$Portal_red.resp_timer = 5
		$Portal_red.count = true
		$Portal_red/PJ_respawn_spr.visible = true
	if TEAM == "BLUE":
		$Portal_blue.resp_timer = 5
		$Portal_blue.count = true
		$Portal_blue/PJ_respawn_spr.visible = true
		

remote func _spawn_warrior(TEAM):
	if TEAM == "RED" :
		var warrior_red = warrior_red_load.instance()
		get_parent().add_child(warrior_red)
		warrior_red.position=$Portal_red/spawn_point_red.global_position
	if TEAM == "BLUE" :
		var warrior_blue = warrior_blue_load.instance()
		get_parent().add_child(warrior_blue)
		warrior_blue.position=$Portal_blue/spawn_point_blue.global_position

remote func _spawn_spearman(TEAM):
	if TEAM == "RED" :
		var spearman_red = spearman_red_load.instance()
		get_parent().add_child(spearman_red)
		spearman_red.position=$Portal_red/spawn_point_red.global_position
	if TEAM == "BLUE" :
		var spearman_blue = spearman_blue_load.instance()
		get_parent().add_child(spearman_blue)
		spearman_blue.position=$Portal_blue/spawn_point_blue.global_position

remote func _spawn_ranger(TEAM):
	if TEAM == "RED" :
		var ranger_red = ranger_red_load.instance()
		get_parent().add_child(ranger_red)
		ranger_red.position=$Portal_red/spawn_point_red.global_position
	if TEAM == "BLUE" :
		var ranger_blue = ranger_blue_load.instance()
		get_parent().add_child(ranger_blue)
		ranger_blue.position=$Portal_blue/spawn_point_blue.global_position


remote func _spawn_bat(TEAM,RNG):
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

remote func _spawn_eye(TEAM,RNG):
	if TEAM == "RED" :
		var eye_red = Eye_red_load.instance()
		get_parent().add_child(eye_red)
		eye_red.global_position.y=($Portal_red/spawn_point_red.global_position.y+70)+RNG
		eye_red.global_position.x=$Portal_red/spawn_point_red.global_position.x
	if TEAM == "BLUE" :
		var eye_blue = Eye_blue_load.instance()
		get_parent().add_child(eye_blue)
		eye_blue.global_position.y=($Portal_blue/spawn_point_blue.global_position.y+70)+RNG
		eye_blue.global_position.x=$Portal_blue/spawn_point_blue.global_position.x

slave func send_client_image(image):
	get_node("image_client").texture = image
	print(image)
	pass




