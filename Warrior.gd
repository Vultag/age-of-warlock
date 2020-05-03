extends KinematicBody2D

# Declare member variables here. Examples:
var mouv = Vector2()
var attack_free = true
var body_check = false
var Collision_on = "hit_box_L"
onready var HEALTH = 1
onready var hitbox = get_node("Warrior_spr/attack_hitbox/hitbox")
onready var vie = get_node("Warrior_spr/barre_vie/vie")
const GRAVITY = 4
const FLOOR = Vector2(0,-1)


func _process(delta):
	
	if attack_free == true:
		if Input.is_action_pressed("M") or Input.is_action_pressed("K"):
			$Warrior_spr.play("mouv")
			if Input.is_action_pressed("M"):
				mouv.x=35
				$Ranger_spr.scale.x=1
				Collision_on = "hit_box_L"

			if Input.is_action_pressed("K"):
				mouv.x=-35
				$Warrior_spr.scale.x=-1
				Collision_on = "hit_box_R"
	
	if body_check == true:
		mouv.x=0
		attack_free = false
		$Warrior_spr.play("attack")
	if ($Warrior_spr.get_frame()==5 and $Warrior_spr.get_animation()=="attack"):hitbox.disabled=false
	if ($Warrior_spr.get_frame()==9):
		$Warrior_spr.play("static")
		attack_free = true
		body_check = false
		hitbox.disabled=true
	
	if(Collision_on == "hit_box_L"):
		$hit_box_L.disabled=false
	else:$hit_box_L.disabled=true
	
	if(Collision_on == "hit_box_R"):
		$hit_box_R.disabled=false
	else:$hit_box_R.disabled=true
	
	
	vie.scale.x=HEALTH
	
	mouv.y+=GRAVITY
	
	
	mouv=move_and_slide(mouv,FLOOR)
	
	
	if(HEALTH<=0):
		queue_free()
	
	

func _on_attack_hitbox_body_entered(body):
	if body.is_in_group("Character"):
		body.HEALTH-=0.20
		body.global_position+=Vector2((sign(self.position.x-body.position.x)*-4),-2)