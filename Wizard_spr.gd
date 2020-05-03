extends Sprite

var mouv = Vector2()

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		set_scale(1,0)
		

