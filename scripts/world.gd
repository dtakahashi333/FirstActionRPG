extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.player_first_load_in:
		$player.position.x = global.player_start_pos_x
		$player.position.y = global.player_start_pos_y
	else:
		$player.position.x = global.player_exit_cliff_side_pos_x
		$player.position.y = global.player_exit_cliff_side_pos_y		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()


func _on_cliff_side_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true


#func _on_cliff_side_transition_point_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
		#global.transition_scene = false


func change_scene():
	if global.transition_scene:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
			global.player_first_load_in = false
			global.finish_change_scenes()
