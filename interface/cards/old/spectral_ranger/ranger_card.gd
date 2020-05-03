extends Node2D

var Spell
var new_spell



func _process(delta):
	
	randomize()
	
	
	
	






func _on_Area2D_mouse_entered():
	$AnimationPlayer.play("mouse_over_in")


func _on_Area2D_mouse_exited():
	$AnimationPlayer.play("mouse_over_out")
