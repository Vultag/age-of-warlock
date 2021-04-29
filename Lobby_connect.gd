extends Node2D

#var host = NetworkedMultiplayerENet.new()

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	#get_tree().connect("connected_to_server",self,"connected_to_server")

#func connected_to_server():
	#globals.playerJoinId = get_tree().get_network_unique_id() 
	#rset_id(get_tree().get_network_unique_id() , globals.playerHostId, value)



func _player_connected(id):

	if get_tree().is_network_server():
		globals.playerHostId = get_tree().get_network_unique_id()
		globals.playerJoinId = id
		var game = preload("res://MAIN.tscn").instance()
		get_tree().get_root().add_child(game)
		#var HUD_red = preload("res://HUD/HUD_red.tscn").instance()
		#get_tree().get_root().add_child(HUD_red)
	else:
		globals.playerJoinId = get_tree().get_network_unique_id()
		globals.playerHostId = 1
		var game = preload("res://MAIN.tscn").instance()
		get_tree().get_root().add_child(game)
		#var HUD_blue = preload("res://HUD/HUD_blue.tscn").instance()
		#get_tree().get_root().add_child(HUD_blue)
	
	
	hide()


func _on_Button_host_pressed():
	print("Hosting network")
	var host = NetworkedMultiplayerENet.new()
	host.create_server(5000,2)
	#print(globals.playerHostId)
	$Button_join.hide()
	$Button_host.disabled = true
	get_tree().set_network_peer(host)
	#globals.playerHostId = get_tree().get_network_unique_id()



func _on_Button_join_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	#host.create_client("2a01:cb1d:814a:d600:b148:b821:1cdd:1405",50000)
	host.create_client("192.168.1.52",5000)
	#host.create_client("127.0.0.1",5000)
	#host.create_client("86.210.53.131",5000)
	get_tree().set_network_peer(host)
	$Button_join.hide()
	$Button_host.disabled = true
	#globals.playerJoinId = get_tree().get_network_unique_id() 

