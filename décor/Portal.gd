extends Area2D

var resp_timer = 30
var first_digit
var second_digit
var gain = 1

func _ready():
	$portal/Light2D/vortex/AnimationPlayer.play("vortex")


func _process(delta):
	
	resp_timer -= (gain*delta)
	
	first_digit = resp_timer
	
	
	while (first_digit >= 10 ):
		first_digit -= 10;
	
	
	second_digit = resp_timer
	
	
	while (second_digit >= 10):
		second_digit /= 10;
	
	
	$PJ_respawn_spr/num_1.set_frame(first_digit)
	
	
	if (resp_timer>=10):
		$PJ_respawn_spr/num_2.play("default")
		$PJ_respawn_spr/num_2.set_frame(second_digit)
	else:$PJ_respawn_spr/num_2.play("off")
	
	
	
	pass






