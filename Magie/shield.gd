extends Area2D


const arrow_load = preload("res://projectiles/arrow_blue.tscn")


func _process(_delta):
	
	if $sprite.get_frame()==3:
		$shield_hitbox.disabled = false
	else:
		$shield_hitbox.disabled = true


