extends CanvasLayer

var crystal_num=0
var gain = 10
var first_digit
var second_digit
var third_digit
#var warrior_card
#var card_pos
var card_number = 0
var mouse_in = false


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
		$number_crystal/number_l2.play("default")
		$number_crystal/number_l2.set_frame(second_digit)
	else:$number_crystal/number_l2.play("off")
	
	
	if (crystal_num>=100):
		$number_crystal/number_l3.play("default")
		$number_crystal/number_l3.set_frame(third_digit)
	else:$number_crystal/number_l3.play("off")
	
	
	$number_crystal/number_l1.set_frame(first_digit)

	
	if(mouse_in == true):
		if crystal_num>=5:
			if card_number<6:
				if Input.is_action_just_pressed("Souris_left"):
					crystal_num -= 5
					card_number+=1
					get_node("Card_borad").load_card = true
				

	


func _on_Area2D_mouse_entered():
	if crystal_num>=5:
		$number_crystal/chest.play("open")
	mouse_in = true
		
	

func _on_Area2D_mouse_exited():
	$number_crystal/chest.play("closed")
	mouse_in = false



