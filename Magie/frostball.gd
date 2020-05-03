extends Area2D

# Declare member variables here. Examples:
var mouv = Vector2()
var spd = Vector2(260,260)
const FLOOR = Vector2(0,-1)

# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("default")


func _process(delta):
	
	#mouv *= Vector2(1.01,1.01)
	
	if $AnimatedSprite.get_frame() == 5:
		queue_free()
	
	translate(mouv*delta)


func _on_fireball_body_entered(body):
	if body.is_in_group("Shield"):
		pass
	else:
		$AnimationPlayer.play("explode")
		mouv = Vector2(0,0)
		if body.is_in_group("Character_blue"):
			body._take_damage(0.4,Vector2(0,0))
			body.HEAT -= 0.5

