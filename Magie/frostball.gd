extends Area2D

# Declare member variables here. Examples:
var mouv = Vector2()
var spd = Vector2(260,260)
var team = null
var shield = false
const FLOOR = Vector2(0,-1)

# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$CollisionShape2D.disabled = false
	$AnimationPlayer.play("default")
	$AnimatedSprite.play("default")
	self.scale = Vector2(0.5,0.5)
	$explosion/CollisionShape2D.disabled = true
	
	if team == "red":
		set_collision_mask_bit(2,true)
		$explosion.set_collision_mask_bit(2,true)
		set_collision_mask_bit(7,true)
		$explosion.set_collision_mask_bit(7,true)
	else:
		set_collision_mask_bit(1,true)
		$explosion.set_collision_mask_bit(1,true)
		#set_collision_mask_bit(4,true)
		set_collision_mask_bit(6,true)
		$explosion.set_collision_mask_bit(6,true)



func _process(delta):
	
	translate(mouv*delta)
	"""
	if team == "blue":
		if is_network_master():
			pass
		else:
			#mouv *= Vector2(1.01,1.01)
			
			
			translate(mouv*delta)
			
			rpc_unreliable("setPositionBlue",Vector2(global_position.x , global_position.y))
			
	if team == "red":
		if is_network_master():
			
			translate(mouv*delta)
			
			rpc_unreliable("setPositionRed",Vector2(global_position.x , global_position.y))
	"""


func _on_fireball_body_entered(body):
	if body.is_in_group("Shield"):
		if is_network_master():
			rpc("_explode",true)
	else:
		if is_network_master():
			rpc("_explode",false)



master func setPositionBlue(pos):
	global_position = pos

sync func _explode(shield_hit):
	shield = shield_hit
	self.scale = Vector2(2,2)
	$AnimationPlayer.play("explode")
	mouv = Vector2(0,0)


puppet func setPositionRed(pos):
	global_position = pos

sync func _queue_free():
	set_process(false)
	queue_free()



func _on_explosion_body_entered(body):
	if shield == false:
		if team == "red":
			#if body.is_in_group("Character_blue"):
				body._take_damage(0.2,Vector2(0,0))
				body.HEAT -= 0.5
		if team == "blue":
			#if body.is_in_group("Character_red"):
				body._take_damage(0.2,Vector2(0,0))
				body.HEAT -= 0.5
	else:
		if !body.is_in_group("Hero"):
			if team == "red":
				#if body.is_in_group("Character_blue"):
					body._take_damage(0.2,Vector2(0,0))
					body.HEAT -= 0.5
			if team == "blue":
				#if body.is_in_group("Character_red"):
					body._take_damage(0.2,Vector2(0,0))
					body.HEAT -= 0.5


func local_queue_free():
	if is_network_master():
		rpc("_queue_free")




