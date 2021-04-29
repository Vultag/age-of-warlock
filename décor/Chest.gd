extends Area2D


onready var card_item_load = preload("res://décor/Card_item.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = true
	$lock.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Chest_area_entered(area):
	if area.name == "tir_arcane" or area.name == "tir_arcane_blue":
		#$CollisionShape2D.set_deferred("disabled",true)
		$sprite.set_frame(1)
		var card_item = card_item_load.instance()
		card_item.global_position = global_position
		get_parent().get_parent().call_deferred("add_child",(card_item))
		$Timer.start()



func _chest_unlock():
	$lock.visible = false
	$CollisionShape2D.disabled = false




func _on_Timer_timeout():
	$sprite.set_frame(0)
