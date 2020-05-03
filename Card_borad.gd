extends Node2D

var check_card_num = false
var card_played 
var card_just_played = false
var retrograde = false
var card_dragged = false
var load_card = false
var card_pos
var card_created

"""
onready const card_pos_spectral_warrior_load = preload("res://interface/cards/spectral_warrior/card_pos_spectral_warrior.tscn")
const card_pos_spectral_spearman_load = preload("res://interface/cards/spectral_spearman/card_pos_spectral_spearman.tscn")
const card_pos_spectral_ranger_load = preload("res://interface/cards/spectral_ranger/card_pos_spectral_ranger.tscn")
const card_pos_spectral_bat_load = preload("res://interface/cards/spectral_bat/card_pos_spectral_bat.tscn")


const card_group = [card_pos_spectral_warrior_load,card_pos_spectral_spearman_load,
card_pos_spectral_ranger_load,card_pos_spectral_bat_load]
"""

onready var card_magie_pos_load = preload("res://interface/cards/card_magie_pos.tscn")


func _ready():
	randomize()

func _process(_delta):
	
	card_created = card_magie_pos_load
	
	#card_created = card_group[randi() % card_group.size()]
	
	if retrograde == true:
		for node in get_children():
			node.retrograde = true
			retrograde = false
	
	if card_just_played == true:
		for node in get_children():
			node.card_just_played = true
			card_just_played = false
	
	
	if load_card == true:
		card_pos = card_created.instance()
		add_child(card_pos)
		load_card = false
	
	
	
	pass



