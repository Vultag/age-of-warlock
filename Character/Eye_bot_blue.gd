extends KinematicBody2D

var HEALTH = 1.25
var max_HEALTH = 1.25
var local_mouv = Vector2()
var mouv = Vector2()
var spd = 400
var GRAVITY = 0
var body_char = null
var body_check = false
var test = true
var reset = true
var HEAT = 0
const FLOOR = Vector2(0,-1)
onready var vie = get_node("eye_spr/barre_vie/vie")
onready var barre_vie = get_node("eye_spr/barre_vie")

const beam_load = preload("res://projectiles/Eye_beam_blue.tscn")


var velocity = Vector2()
var tegu_vel = Vector2()
var prev_pos = get_position()


func _ready():
	$eye_spr/tentacules.set_frame(0)
	$AnimationPlayer.play("eye_idle")
	self.scale.x = -1
	"""
	$eye_spr.scale.x= -1
	$CollisionPolygon2D.scale.x = -1
	$aim_check.scale.x = -1
	"""


func _process(delta):
	#self.scale.y = -1
	_fixed_process(delta)
	
	local_mouv.y = 0
	
	
	if HEAT < -1:
		HEAT = -1
	
	if HEAT < 0:
		modulate = Color(1+HEAT,1,1,1)
		HEAT += 0.00005
		#if spd > 0:
		spd =  400 *(1+HEAT/1)
		if HEALTH > 0:
			$AnimationPlayer.set_speed_scale(spd/400)
			$eye_spr/tentacules.set_speed_scale(spd/400)
		else:
			$AnimationPlayer.set_speed_scale(1)
			$eye_spr/tentacules.set_speed_scale(1)
	if HEAT > 0:
		modulate = Color(1,1-HEAT,1-HEAT,1)
		HEAT -= 0.00005
	
	
	if $eye_spr/tentacules.get_frame()  ==  5:
		local_mouv.x -= spd*delta
	
	if local_mouv.x <=0:
		local_mouv.x += 60*delta
	
	if body_check == true:
		#self.scale.y = 1
		$AnimationPlayer.play("eye_idle")
		local_mouv.x = 0
		var angle_to_body = get_global_position().angle_to_point(body_char.global_position)
		self.rotation = angle_to_body+3.14159
		if $eye_spr.get_frame() == 3:
			
			var beam = beam_load.instance()
			
			if(test == true):
				get_parent().get_parent().get_parent().add_child(beam)
				test=false
				
			beam.position = $shoot_point.global_position
			beam.scale.x = -1
			beam.rotation = self.rotation +3.14159
		
		if $eye_spr.get_frame() == 4:
			test = true
			pass
			#point_progress += 10
			#$eye_spr/Line2D.clear_points()
			#$eye_spr/Line2D.set_visible(false)
	
	
	
	
	
	
	
	
	
	
	
	
	barre_vie.scale.x = max_HEALTH
	vie.value = (HEALTH/1.25)*100
	
	if HEALTH <= 0:
		queue_free()
		pass
	
	local_mouv.y+=GRAVITY
	
	local_mouv=move_and_slide(local_mouv,FLOOR)
	
	pass


func _take_damage(damage,knock):
	
	#$AnimationPlayer.play("eye_idle")
	#$AnimationPlayer.set_animation_process_mode(0) 
	
	HEALTH -= damage
	
	global_position+=knock



func _fixed_process(delta):

	mouv = tegu_vel
	velocity = get_global_position() - prev_pos
	tegu_vel = (get_global_position() - prev_pos) / delta

	prev_pos = get_global_position()



func _on_aim_check_body_entered(body):
	if  body.is_in_group("Character_red") && body_char == null:
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
			self.scale.x=-1
			self.scale.y=1
		if reset == false:
			$aim_check/aim.position.y = 0
	
	"""
	
	if body == body_char:
	#if  body.is_in_group("Character_red"):
		rotation = 0
		$AnimationPlayer.play("eye_idle")
		body_char = null
		body_check = false
	"""



