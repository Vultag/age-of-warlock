extends KinematicBody2D

var HEALTH = 0.5
var mouv = Vector2()
const FLOOR = Vector2(0,-1)
const GRAVITY = 1
#onready var vie = get_node("bat_spr/barre_vie/vie")


func _ready():
	
	$AnimationPlayer.play("Bat_move")
	
	pass 



func _process(delta):
	
	mouv.x = 45
	
	if $bat_spr.get_frame() == 3:
		
		mouv.y = -17.7
		
		pass
	
	
	
	
	
	#vie.scale.x=HEALTH
	
	mouv.y+=GRAVITY
	
	mouv=move_and_slide(mouv,FLOOR)
	
	pass

"""
func _take_damage(damage,knock):
	
	HEALTH -= damage
	
	global_position+=knock
"""
