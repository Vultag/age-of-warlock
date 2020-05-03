"""
extends Position2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func start_at(rot,pos):
	set_rotation(rot)
	set_position(pos)

func _process(delta):
	var vec_to_wizard = $Wizard.global_position-global_position
	Vector2(0.1, 0).rotated(rotation)
