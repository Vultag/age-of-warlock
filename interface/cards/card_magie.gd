extends Node2D

var Spell
var new_spell
var charge

func _ready():
	
	randomize()
	new_spell = randi() % 6 + 1
	
	match new_spell:
		1:
			Spell = "mass_shield"
			$icons.play("mass_shield")
			self.add_to_group("mass_shield")
		2:
			Spell = "shield"
			$icons.play("shield")
			self.add_to_group("shield")
		3:
			Spell = "frost"
			$icons.play("frost")
			self.add_to_group("frost")
		4:
			Spell = "frostball"
			$icons.play("frostball")
			self.add_to_group("frostball")
		5:
			Spell = "fire"
			$icons.play("fire")
			self.add_to_group("fire")
		6:
			Spell = "fireball"
			$icons.play("fireball")
			self.add_to_group("fireball")
		
	

func _process(_delta):
	"""
	if get_parent() == get_node("Card_playing"):
		if $icons.get_animation() == "fireball":
			$icons.play("fireball_playing")
	"""
	
	pass
	


func _on_Area2D_mouse_entered():
	$AnimationPlayer.play("mouse_over_in")


func _on_Area2D_mouse_exited():
	$AnimationPlayer.play("mouse_over_out")

