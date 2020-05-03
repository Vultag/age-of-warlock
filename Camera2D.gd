extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#export var spd = 250
#var camera_mv = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	"""
	if get_global_mouse_position().x>=position.x+1900:
		camera_mv.x=+spd*delta
	
	elif get_global_mouse_position().x<=position.x+20:
		camera_mv.x=-spd*delta
	else: camera_mv.x = 0
	
	
	position += camera_mv
	"""