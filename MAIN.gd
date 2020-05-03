extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
	#var spawn_point
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	randomize()
	
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



	if Input.is_action_just_pressed("1"):
		if $HUD.crystal_num >=2:
			$HUD.crystal_num -= 2
			var warrior_red = warrior_red_load.instance()
			get_parent().add_child(warrior_red)
			warrior_red.position=$Portal_red/spawn_point_red.global_position
			#warrior_red.position= Vector2(600,633)
		else:
			pass

	if Input.is_action_just_pressed("2"):
		if $HUD.crystal_num >=2:
			$HUD.crystal_num -= 2
			var spearman_red = spearman_red_load.instance()
			get_parent().add_child(spearman_red)
			spearman_red.position=$Portal_red/spawn_point_red.global_position
		else:
			pass


	if Input.is_action_just_pressed("3"):
		if $HUD.crystal_num >=3:
			$HUD.crystal_num -= 3
			var ranger_red = ranger_red_load.instance()
			get_parent().add_child(ranger_red)
			ranger_red.position=$Portal_red/spawn_point_red.global_position
		else:
			pass

	if Input.is_action_just_pressed("4"):
		if $HUD.crystal_num >=4:
			$HUD.crystal_num -= 4
			var spawn_point
			var Bat_red = Bat_red_load.instance()
			spawn_point = -randi() % 200
			get_parent().add_child(Bat_red)
			Bat_red.position.y=($Portal_red/spawn_point_red.global_position.y+75)+spawn_point
			Bat_red.position.x=$Portal_red/spawn_point_red.global_position.x
		else:
			pass

	if Input.is_action_just_pressed("5"):
		if $HUD.crystal_num >=5:
			$HUD.crystal_num -= 5
			var spawn_point
			var eye_red = Eye_red_load.instance()
			spawn_point = -randi() % 190
			get_parent().add_child(eye_red)
			eye_red.position.y=($Portal_red/spawn_point_red.global_position.y+70)+spawn_point
			eye_red.position.x=$Portal_red/spawn_point_red.global_position.x
		else:
			pass


	if Input.is_action_just_pressed("6"):
		var warrior_blue = warrior_blue_load.instance()
		get_parent().add_child(warrior_blue)
		warrior_blue.position=$Portal_blue/spawn_point_blue.global_position
		#warrior_blue.position= Vector2(800,633)



	if Input.is_action_just_pressed("7"):
		var ranger_blue = ranger_blue_load.instance()
		get_parent().add_child(ranger_blue)
		ranger_blue.position=$Portal_blue/spawn_point_blue.global_position


	if Input.is_action_just_pressed("8"):
		var spearman_blue = spearman_blue_load.instance()
		get_parent().add_child(spearman_blue)
		spearman_blue.position=$Portal_blue/spawn_point_blue.global_position



	if Input.is_action_just_pressed("9"):
			var spawn_point
			var Bat_blue = Bat_blue_load.instance()
			spawn_point = -randi() % 200
			get_parent().add_child(Bat_blue)
			Bat_blue.position.y=($Portal_blue/spawn_point_blue.global_position.y+75)+spawn_point
			Bat_blue.position.x=$Portal_blue/spawn_point_blue.global_position.x


	if Input.is_action_just_pressed("0"):
		var spawn_point
		var eye_blue = Eye_blue_load.instance()
		spawn_point = -randi() % 190
		get_parent().add_child(eye_blue)
		eye_blue.position.y=($Portal_blue/spawn_point_blue.global_position.y+70)+spawn_point
		eye_blue.position.x=$Portal_blue/spawn_point_blue.global_position.x



func _PJ_respawn():
	$Portal_red.resp_timer = 5
	$Portal_red.count = true
	$Portal_red/PJ_respawn_spr.visible = true





