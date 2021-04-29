extends Area2D

var Card_spawned 


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var x = 0
	var i = get_parent().get_node("HUD").card_not_activated[x]
	var unit_id = 0
	
	if i <= 99:
		Card_spawned = get_parent().get_node("HUD").card_not_activated[0]
		$AnimatedSprite.set_frame(Card_spawned)
		get_parent().get_node("HUD").card_not_activated.remove(0)
	else:
		
		while i >= 99 :
			x+=1
			unit_id = get_parent().get_node("HUD").card_not_activated[x]
			if unit_id <=99:
				Card_spawned = unit_id
				$AnimatedSprite.set_frame(Card_spawned)
				get_parent().get_node("HUD").card_not_activated.remove(x)
				x = -1
				break
			else:
				i = get_parent().get_node("HUD").card_not_activated[x]
		
	#Card_spawned = unit_id
	##$AnimatedSprite.set_frame(Card_spawned)
	##print("card_spawned")
	#print(Card_spawned)
	#get_parent().get_node("HUD").card_not_activated.remove(unit_id)
	
	#Card_spawned = get_parent().get_node("HUD").card_not_activated[i]
	#$AnimatedSprite.set_frame(Card_spawned)
	#get_parent().get_node("HUD").card_not_activated.remove(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Card_item_body_entered(body):
	if body.get_network_master() == globals.playerHostId:
		if is_network_master():
			get_parent().get_node("HUD").activate_unit(Card_spawned)
			queue_free()
	elif body.get_network_master() == globals.playerJoinId:
		if !is_network_master():
			get_parent().get_node("HUD").activate_unit(Card_spawned)
			queue_free()
