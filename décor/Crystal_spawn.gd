extends RigidBody2D

var crystal_type
var mouv = Vector2(0,-0.1)
var HEAT = 0

func _ready():
	match crystal_type:
		"money":
			self.mode = MODE_CHARACTER
			#self.modulate = Color(0,0,1,1)
			self.get_node("AnimatedSprite").play("money")
		"ball":
			self.modulate = Color(0,1,0,1)
			self.get_node("AnimatedSprite").play("ball")
		"soul":
			self.mode = MODE_CHARACTER
			self.modulate = Color(1,1,1,1)
			self.get_node("AnimatedSprite").play("soul")


func  _integrate_forces(state):
	state.set_linear_velocity(mouv)



func _physics_process(delta):
	
	if is_network_master():
		rpc_unreliable("setPosRot",global_position,global_rotation)
	
	pass
	



func _on_Crystal_spawn_body_entered(body):
		if body is TileMap:
			rpc("_queue_free")
			#rpc("_queue_free")
		else:
			match crystal_type:
				"money":
					if !body.is_in_group("Crystal_spawn"):
						if body.get_network_master() == globals.playerHostId:
							if is_network_master():
								get_parent().get_node("HUD").crystal_num += 1
								rpc("_queue_free")
						else:
							if !is_network_master():
								get_parent().get_node("HUD").crystal_num += 1
								rpc("_queue_free")
				"ball":
					if body.is_in_group("Shield"):
						mouv = Vector2(0,0)
					elif !body.is_in_group("Crystal_spawn"):
						if is_network_master():
							body._take_damage(1.1,Vector2(0,0))
							rpc("_queue_free")
				"soul":
					if body.is_in_group("Shield"):
						mouv = Vector2(0,0)
					elif !body.is_in_group("Crystal_spawn"):
						if is_network_master():
							body._take_damage(1.1,Vector2(0,0))
							rpc("_queue_free")
					#self.modulate = Color(1,0,0,1)
					#$Area2D/CollisionShape2D.disabled = false
					pass



func _on_Area2D_body_entered(body):
	if is_network_master():
		if body.is_in_group("Character"):
			var Angle =  self.global_position.angle_to_point(body.global_position) - PI
			mouv = Vector2(cos(Angle)*300,sin(Angle)*300)

func _take_damage(damage,knock):
	if is_network_master():
		
		if crystal_type == "money" :
			rpc("_queue_free")



sync func setColor(color):
	self.modulate = color


puppet func setPosRot(pos,rot):
	global_position = pos
	global_rotation = rot


sync func _queue_free():
	get_parent().get_node("The_crystal").crystal_spawn_cout -= 1
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)
	queue_free()
