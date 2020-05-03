extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

var a = 0
var b = 0

func get_imput(a,b):
	{GetGlobalMousePosition(a,b):1,2}

func mouvement();
{ x = place;
y = place;}