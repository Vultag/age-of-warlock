extends KinematicBody2D

onready var frame_number

func _process(delta):
	$arms.play("shoot")
	frame_number = $arms.get_frame()
	if(frame_number==14):
		queue_free()
	
	#print (frame_number)
