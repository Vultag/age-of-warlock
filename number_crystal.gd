extends Sprite

var crystal_num=0
var gain = 1
var first_digit
var second_digit
var third_digit
var mouse_in = false
const warrior_card_load = preload("res://interface/warrior_card.tscn")


func _process(delta):
	
	
	crystal_num += (gain*delta)
	
	
	first_digit=crystal_num
	
	
	while (first_digit >= 10 && first_digit < 100):
		first_digit /= 10;
	
	while (first_digit >= 100):
		first_digit /= 100;
	
	second_digit = crystal_num
	
	
	while (second_digit >= 10 && second_digit < 100):
		second_digit -= 10;
	
	while (second_digit >= 100):
		second_digit = (second_digit/10)
	while second_digit>=10:
		second_digit-=10
	
	
	third_digit = crystal_num
	
	while (third_digit >= 10):
		third_digit -= 10;
	
	
	if (crystal_num>=10):
		$number_l2.play("default")
		$number_l2.set_frame(second_digit)
	else:$number_l2.play("off")
	
	
	if (crystal_num>=100):
		$number_l3.play("default")
		$number_l3.set_frame(third_digit)
	else:$number_l3.play("off")
	
	
	$number_l1.set_frame(first_digit)
	
	
	if(mouse_in == true):
		if crystal_num>=5:
			if Input.is_action_just_pressed("Souris_left"):
				crystal_num -= 5
				var warrior_card = warrior_card_load.instance()
				get_parent().add_child(warrior_card)
				$warrior_card.position = $card_pos.position
				
	


func _on_Area2D_mouse_entered():
	if crystal_num>=5:
		$chest.play("open")
	mouse_in = true
		
	

func _on_Area2D_mouse_exited():
	$chest.play("closed")
	mouse_in = false




