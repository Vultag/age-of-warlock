extends Node2D



#func _process(delta):
#	pass


func _on_Area2D_mouse_entered():
	$AnimationPlayer.play("mouse_over_in")


func _on_Area2D_mouse_exited():
	$AnimationPlayer.play("mouse_over_out")
