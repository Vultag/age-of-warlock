extends Node2D

var bar_load = 0
var gain = 0.05
var card_added = false
var card_stak = 1
var first_digit
var second_digit
const spearman_red_load = preload("res://Character/Spearman_bot.tscn")
const spearman_blue_load = preload("res://Character/Spearman_bot_blue.tscn")

func _ready():
	if get_parent().get_child_count() == 1:
		position = get_parent().pos_card_1
	
	if get_parent().get_child_count() == 2:
		position = get_parent().pos_card_2
	
	if get_parent().get_child_count() == 3:
		position = get_parent().pos_card_3
	
	if get_parent().get_child_count() == 4:
		position = get_parent().pos_card_4
	
	if get_parent().get_child_count() == 5:
		position = get_parent().pos_card_5

func _process(delta):
	
	$spearman_icon/charge.scale.x = bar_load
	
	bar_load += (gain*delta)
	
	if bar_load >= 1:
		bar_load = 0
		var spearman_red = spearman_red_load.instance()
		get_parent().get_parent().get_parent().add_child(spearman_red)
		spearman_red.position = get_parent().get_parent().get_parent().get_node("Portal_red").position
		var spearman_blue = spearman_blue_load.instance()
		get_parent().get_parent().get_parent().add_child(spearman_blue)
		spearman_blue.position = get_parent().get_parent().get_parent().get_node("Portal_blue").position
	
	if card_added == true:
		gain += 0.025
		card_stak += 1
		card_added = false
	
	if card_stak > 1:
		$x.play("on")
		$multiply_1d.play("on")
	else :
		$x.play("off")
		$multiply_1d.play("off")
	
	if card_stak > 9:
		$multiply_2d.play("on")
	else:
		$multiply_2d.play("off")
	
	first_digit = card_stak
	second_digit = card_stak
	
	if card_stak>9:
		first_digit /= 10
	
	while (second_digit >= 10):
		second_digit -= 10
	
	$multiply_1d.set_frame(first_digit)
	$multiply_2d.set_frame(second_digit)
	
	pass
