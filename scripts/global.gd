extends Node2D

var player_current_attack = false

var current_scene = "world" # "world" "cliff_side"
var transition_scene = false

var player_exit_cliff_side_pos_x = 199
var player_exit_cliff_side_pos_y = 29
var player_start_pos_x = 155
var player_start_pos_y = 108

var player_first_load_in = true

var found_slimes_item = false
var given_slimes_item = false

func finish_change_scenes():
	if transition_scene:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
