extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	if get_parent().ADD_HEALTH <= 0:
		queue_free()
	
	if get_parent().is_in_group("Eye"):
		scale = Vector2(2.125,1.156)
		position = Vector2(6,0)
	
	if get_parent().is_in_group("Bat"):
		scale = Vector2(2.4,1.156)
		position = Vector2(1,0)
	
	"""
	if get_parent().is_in_group("Warrior"):
		if  get_parent().HEALTH <= 1.2:
			queue_free()
	
	if get_parent().is_in_group("Ranger"):
		if  get_parent().HEALTH <= 1:
			queue_free()
	
	if get_parent().is_in_group("Spearman"):
		if  get_parent().HEALTH <= 1:
			queue_free()
	"""
