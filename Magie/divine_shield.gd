extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	
	if get_parent().ADD_HEALTH <= 0:
		queue_free()
	
	if get_parent().is_in_group("Hero"):
		scale = Vector2(2.8,1.5)
		position = Vector2(0,0)	
	
	if get_parent().is_in_group("Eye"):
		if get_parent().is_in_group("Character_blue"):
			scale = Vector2(2.125,1.156)
			position = Vector2(-6,0)
		else:
			scale = Vector2(2.125,1.156)
			position = Vector2(6,0)
	
	if get_parent().is_in_group("Bat"):
		scale = Vector2(2.4,1.156)
		position = Vector2(1,0)
	
	if get_parent().is_in_group("Character_blue"):
		if get_parent().name == "Ranger":
			position = Vector2(3,0)
		if get_parent().name == "Spearman":
			position = Vector2(2,0)
		if get_parent().is_in_group("Bat"):
			position = Vector2(-1,0)
	else:
		if get_parent().name == "Ranger":
			position = Vector2(-2,0)
		if get_parent().name == "Spearman":
			position = Vector2(-3,0)
