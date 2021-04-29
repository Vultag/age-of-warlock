extends StaticBody2D


var HEALTH = 15
var HEAT = 0
var Body
var body_check
var body_char

var capture = 0

var enemy_group = "none"



const tir_tour_load = preload("res://projectiles/tir_tour.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#if is_network_master():
		#$offset/shoot_check/CollisionShape2D.disabled = false
	#else:
	$offset/shoot_check.set_collision_layer_bit(1,false)
	$offset/shoot_check.set_collision_layer_bit(2,false)
	$offset/shoot_check/CollisionShape2D.disabled = true
	$offset/Tower/barre_vie.visible = false
	$CollisionShape2D.disabled = false
	#$offset/Tower/AnimatedSprite/AnimationPlayer.play("Nouvelle animation")
	
	pass



func _take_damage(damage,knock):
	if is_network_master():
		
		if enemy_group != "none":
			HEALTH -= damage*30
		
		if HEALTH <=0 :
			rpc("_die")
			#$Timer.start()
		else:
			$offset/Tower/barre_vie/vie.scale.x=HEALTH/15
			rpc("setHealth",HEALTH)

sync func _die():
	$CollisionShape2D.set_deferred("disabled",true)
	if self.is_in_group("Character_red"):
		self.remove_from_group("Character_red")
	else:
		self.remove_from_group("Character_blue")
	Body = null
	enemy_group = "none"
	$offset/shoot_check.set_collision_layer_bit(1,false)
	$offset/shoot_check.set_collision_layer_bit(2,false)
	self.set_collision_mask_bit(2,false)
	self.set_collision_mask_bit(1,false)
	self.set_collision_layer_bit(10,false)
	self.set_collision_layer_bit(11,false)
	$offset/Tower.play("deactivated")
	$offset/Tower/AnimatedSprite.visible = false
	#$activation_area/activation_col.set_deferred("disable",false)
	$activation_area/activation_col.set_deferred("disabled",false)
	###$Timer_shoot.stop()
	#$CollisionShape2D.set_deferred("disable",true)
	###$AnimationPlayer.play("death")
	$offset/Tower/barre_vie.visible = false
	###z_index = -2

sync func setHealth(health):
	$offset/Tower/barre_vie/vie.scale.x=health/15

func _on_Timer_timeout():
	rpc("_delete")

sync func _delete():
	queue_free()


func _on_shoot_check_body_entered(body):
	if is_network_master():
		if body.is_in_group(enemy_group):
			$offset/shoot_check/CollisionShape2D.set_deferred("disabled", true)
			Body = body
			$Timer_shoot.start()
	#$AnimationPlayer.play("shoot")


func _on_Timer_shoot_timeout():
	if is_instance_valid(Body):
		if Body.is_in_group(enemy_group) && abs(Body.global_position.x-$offset/shoot_check/CollisionShape2D.global_position.x) <= 560 && abs(Body.global_position.y-$offset/shoot_check/CollisionShape2D.global_position.y) <= 550:
			rpc("_shoot",Body.global_position)
		else:
			Body = null
			$Timer_shoot.stop()
			$offset/shoot_check/CollisionShape2D.disabled = false
	else:
		Body = null
		$Timer_shoot.stop()
		$offset/shoot_check/CollisionShape2D.disabled = false


sync func _shoot(body_pos):
	
	var tir_tour = tir_tour_load.instance()
	tir_tour.global_position = $offset/shoot_check/CollisionShape2D.global_position
	tir_tour.tir_mouv = Vector2(2, 0).rotated($offset/shoot_check/CollisionShape2D.global_position.angle_to_point(body_pos)-PI)
	if enemy_group == "Character_blue":
		tir_tour.team = "red"
	else:
		tir_tour.team = "blue"
	get_parent().add_child(tir_tour)



func _on_activation_area_body_entered(body):
	if is_network_master():
		
		if body.is_in_group("Character_red") && enemy_group != "Character_blue":
			rpc("_remote_anim","red")
		if body.is_in_group("Character_blue") && enemy_group != "Character_red":
			rpc("_remote_anim","blue")
	pass


func _on_activation_area_body_exited(body):
	$activation_area/anim_capture.stop(false)


func _on_anim_capture_animation_finished(anim_name):
	if is_network_master():
		rpc("_captured",anim_name)


sync func _remote_anim(team):
	
	if team == "red":
		$activation_area/anim_capture.play("Capture_red")
		$activation_area/capture.visible = true
		$activation_area/capture.tint_progress.r = 1
		$activation_area/capture.tint_progress.b = 0
	else:
		$activation_area/anim_capture.play("Capture_blue")
		$activation_area/capture.visible = true
		$activation_area/capture.tint_progress.b = 1
		$activation_area/capture.tint_progress.r = 0



sync func _captured(anim):
	
	get_node("Chest")._chest_unlock()
	$offset/NPC_owned.visible = false
	
	$activation_area/capture.visible = false
	$CollisionShape2D.set_deferred("disabled",false)
	HEALTH = 15
	$offset/Tower/barre_vie/vie.scale.x=HEALTH/15
	$offset/shoot_check/CollisionShape2D.disabled = false
	$offset/Tower/barre_vie.visible = true
	$activation_area/activation_col.disabled = true
	if anim == "Capture_red":
		get_parent().tower_owner[(get_parent().tower_owner.find(self.get_name()))+1] = "red"
		get_parent().get_node("The_crystal")._check_map_pos(get_parent().tower_owner[1],get_parent().tower_owner[3],get_parent().tower_owner[5],get_parent().tower_owner[7])
		enemy_group = "Character_blue"
		$offset/Tower.play("team_red")
		self.set_collision_mask_bit(2,true)
		self.set_collision_layer_bit(10,true)
		self.add_to_group("Character_red")
		$offset/Tower/AnimatedSprite.visible = true
		$offset/Tower/AnimatedSprite.play("team_red")
		$offset/Tower/barre_vie/vie.play("team_red")
		$offset/shoot_check.set_collision_mask_bit(2,true)
		$offset/shoot_check.set_collision_mask_bit(1,false)
	if anim == "Capture_blue":
		get_parent().tower_owner[(get_parent().tower_owner.find(self.get_name()))+1] = "blue"
		get_parent().get_node("The_crystal")._check_map_pos(get_parent().tower_owner[1],get_parent().tower_owner[3],get_parent().tower_owner[5],get_parent().tower_owner[7])
		enemy_group = "Character_red"
		$offset/Tower.play("team_blue")
		self.set_collision_mask_bit(1,true)
		self.set_collision_layer_bit(11,true)
		self.add_to_group("Character_blue")
		$offset/Tower/AnimatedSprite.visible = true
		$offset/Tower/barre_vie/vie.play("team_blue")
		$offset/Tower/AnimatedSprite.play("team_blue")
		$offset/shoot_check.set_collision_mask_bit(1,true)
		$offset/shoot_check.set_collision_mask_bit(2,false)


