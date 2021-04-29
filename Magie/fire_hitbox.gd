extends Area2D

var TEAM

var spd = Vector2(370,370)
var mouv = Vector2(0,0)
var FLOOR = Vector2(0,-1)
var hit_once = true

# Called when the node enters the scene tree for the first time.
func _ready():

	if TEAM == "red":
		set_collision_mask_bit(2,true)
		set_collision_mask_bit(11,true)
	else:
		set_collision_mask_bit(1,true)
		set_collision_mask_bit(10,true)


func  _physics_process(delta):
	
	translate(mouv*delta)
	
	
	pass


func _on_fire_hitbox_body_entered(body):
	#if is_network_master():
		if TEAM == "red":
			if !body.is_in_group("Shield"):# && !body.is_in_group("Character_red"):
				if hit_once == true:
					body._take_damage(0.02,Vector2(0,0))
					hit_once = false
				body.HEAT += 0.03
			else:
				queue_free()
		if TEAM == "blue":
			if !body.is_in_group("Shield"):# && !body.is_in_group("Character_blue"):
				if hit_once == true:
					body._take_damage(0.02,Vector2(0,0))
					hit_once = false
				body.HEAT += 0.03
			else:
				queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	pass
	queue_free()


func _on_Timer_timeout():
	pass
	queue_free()
