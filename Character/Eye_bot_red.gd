extends KinematicBody2D

var HEALTH = 1.25
var ADD_HEALTH = 0
var max_HEALTH = 1.25
var local_mouv = Vector2()
var mouv = Vector2()
var GRAVITY = 0
var body_char = null
var body_check = false
var test = true
var reset = true
var HEAT = 0
const FLOOR = Vector2(0,-1)
onready var vie = get_node("eye_spr/barre_vie/vie")
onready var barre_vie = get_node("eye_spr/barre_vie")
onready var divine_shield = get_node("eye_spr/barre_vie/divine_shield")

const beam_load = preload("res://projectiles/Eye_beam_red.tscn")
const divine_shield_load = preload("res://Magie/divine_shield.tscn")


var velocity = Vector2()
var tegu_vel = Vector2()
var prev_pos = get_position()


func _ready():
	$AnimationPlayer.play("eye_idle")
	$eye_spr/tentacules.set_frame(0)
	$eye_spr.scale.x= 1
	$CollisionPolygon2D.scale.x = 1



func _process(delta):
	
	_fixed_process(delta)
	
	local_mouv.y = 0
	
	#mouv = tegu_vel
	
	if $eye_spr/tentacules.get_frame()  ==  5:
		local_mouv.x += 400*delta
	
	if local_mouv.x >=0:
		local_mouv.x -= 60*delta
	
	
	
	if body_check == true:
		$AnimationPlayer.play("eye_idle")
		local_mouv.x = 0
		var angle_to_body = get_global_position().angle_to_point(body_char.global_position)
		self.rotation = angle_to_body+3.14159
		if $eye_spr.get_frame() == 3:
			
			#var beam = beam_load.instance()
			
			if(test == true):
				var beam = beam_load.instance()
				get_parent().get_parent().get_parent().add_child(beam)
				beam.global_position = $shoot_point.global_position
				beam.scale.x = 1
				beam.rotation = self.rotation
				test=false
		
		if $eye_spr.get_frame() == 4:
			test = true
			pass
			#point_progress += 10
			#$eye_spr/Line2D.clear_points()
			#$eye_spr/Line2D.set_visible(false)
	
	
	
	barre_vie.scale.x = max_HEALTH
	vie.value = (HEALTH/1.25)*100
	
	if ADD_HEALTH > 0:
		divine_shield.scale.x = (ADD_HEALTH/1)
		$eye_spr/barre_vie.play("divine_shield")
		divine_shield.play("default")
	else:
		divine_shield.play("off")
		$eye_spr/barre_vie.play("default")
	
	
	if HEALTH <= 0:
		queue_free()
		pass
	
	local_mouv.y+=GRAVITY
	
	local_mouv=move_and_slide(local_mouv,FLOOR)
	
	pass


func _take_damage(damage,knock):
	
	#$AnimationPlayer.play("eye_idle")
	#$AnimationPlayer.set_animation_process_mode(0) 
	
	if ADD_HEALTH <= 0:
		HEALTH -= damage
	else:
		ADD_HEALTH -= damage
	
	global_position+=knock


func _get_divine_shield():
	
	if ADD_HEALTH <= 0:
		var divine_shield = divine_shield_load.instance()
		add_child(divine_shield)
		divine_shield.global_position = global_position-Vector2(1,0)
		ADD_HEALTH = 1
	elif ADD_HEALTH > 0 :
		ADD_HEALTH = 1
	else:
		pass


func _on_aim_check_body_entered(body):
	if  body.is_in_group("Character_blue") && body_char == null:
		body_char = body
		body_check = true
		reset = true


func _on_aim_check_body_exited(body):
	if body == body_char:
		if reset == true:
			body_check = false
			body_char = null
			reset = false
			$aim_check/aim.position.y = 1000
			$AnimationPlayer.play("eye_idle")
			rotation = 0
		if reset == false:
			$aim_check/aim.position.y = 0





func _fixed_process(delta):

	mouv = tegu_vel
	velocity = get_global_position() - prev_pos
	tegu_vel = (get_global_position() - prev_pos) / delta

	prev_pos = get_global_position()








