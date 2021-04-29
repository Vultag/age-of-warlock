extends Area2D


var crystal_spawn_cout = 0

const crystal_spawn_load = preload("res://décor/Crystal_spawn.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#$Timer_spawn.start()
	#$Timer_spawn.start()


func _physics_process(delta):
	
	pass


# 1 : x:2125
#mid : x:2950
# 3 : x: 3800


func _check_map_pos(tower1,tower2,tower3,tower4):
	
	#print(get_parent().tower_owner)
	
	if tower1 == "red" && tower2 == "red" && tower3 != "blue" && tower4 != "blue":
		self.global_position.x = 2950
		$Timer_spawn.start()
	
	if tower1 == "red" && tower4 == "blue":
		self.global_position.x = 2950
		$Timer_spawn.start()
	
	if tower1 == "red" && tower2 == "red" && tower3 == "red":
		self.global_position.x = 3800
		$Timer_spawn.start()
	if tower4 == "blue" && tower3 == "blue" && tower2 == "blue":
		self.global_position.x = 2125
		$Timer_spawn.start()



func _on_Timer_spawn_timeout():
	if is_network_master():
		if crystal_spawn_cout < 10:
			"""
			var crystal_spawn = crystal_spawn_load.instance()
			var crystal_type = (randi() % 3)+1
			match crystal_type:
				1:
					crystal_spawn.crystal_type = "money"
					
					
				2:
					crystal_spawn.crystal_type = "ball"
					
					
				3:
					crystal_spawn.crystal_type = "soul"
					
			"""
			var local_type = (randi() % 3)+1
			var local_pos = Vector2((randi() % 500)-250, (randi() % 500)-250)
			rpc("remote_crystal_spawn",local_type,local_pos)
		#add_child(crystal_spawn)
		#crystal_spawn.position = Vector2((randi() % 500)-250, (randi() % 500)-250)
		#crystal_spawn_cout += -1
		

sync func remote_crystal_spawn(type,pos):
	var crystal_spawn = crystal_spawn_load.instance()
	var crystal_type = type
	match crystal_type:
			1:
				crystal_spawn.crystal_type = "money"
				
				
			2:
				crystal_spawn.crystal_type = "ball"
				
				
			3:
				crystal_spawn.crystal_type = "soul"
				
				
	get_parent().add_child(crystal_spawn)
	crystal_spawn.global_position = global_position+pos
	crystal_spawn_cout += 1
