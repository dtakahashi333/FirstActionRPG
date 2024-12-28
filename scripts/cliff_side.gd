extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()


func change_scene():
	if global.transition_scene:
		if global.current_scene == "cliff_side":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.finish_change_scenes()


func _on_cliff_side_exit_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true


#func _on_cliff_side_exit_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
		#global.transition_scene = false
