extends Area2D

# Declare member variables here. Examples:
# var a = 2

var spd = Vector2(190,190)
var mouv = Vector2(0,0)
var FLOOR = Vector2(0,-1)
var hit_once = true

var TEAM

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if TEAM == "red":
		set_collision_mask_bit(2,true)
		set_collision_mask_bit(11,true)
		#set_collision_mask_bit(7,true)
		#collision_mask = 4
		#collision_mask = 128
	else:
		set_collision_mask_bit(1,true)
		set_collision_mask_bit(10,true)
		#set_collision_mask_bit(6,true)
		#collision_mask = 3
		#collision_mask = 64
	
	
	pass


func _physics_process(delta):
	
	translate(mouv*delta)
	
	#global_position += Vector2(1,0)
	
	pass


func _on_fire_hitbox_body_entered(body):
	#if is_network_master():
		if TEAM == "red":
			if !body.is_in_group("Shield"):#body.is_in_group("Character_blue"):
				if hit_once == true:
					body._take_damage(0.005,Vector2(0,0))
					hit_once = false
				body.HEAT -= 0.02
			else:
				queue_free()
		if TEAM == "blue":
			if !body.is_in_group("Shield"):#body.is_in_group("Character_red"):
				if hit_once == true:
					body._take_damage(0.005,Vector2(0,0))
					hit_once = false
				body.HEAT -= 0.02
			else:
				queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	queue_free()
