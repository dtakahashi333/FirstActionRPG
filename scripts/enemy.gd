extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var health = 100
var player_in_attack_range = false
var can_take_damage = true


func _physics_process(delta: float) -> void:
	
	deal_with_damage()
	update_health()
	
	if player_chase:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("walk")
		
		if player.position.x - position.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = false


func enemy() -> void:
	pass


func deal_with_damage() -> void:
	if player_in_attack_range and global.player_current_attack:
		if can_take_damage:
			can_take_damage = false
			$take_damage_cooldown.start()
			health = health - 20
			print("slime health =", health)
			if health <= 0:
				self.queue_free()


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true


func update_health() -> void:
	var health_bar = $health_bar
	health_bar.value = health
	
	if health_bar.value >= 100:
		$health_bar.visible = false
	else:
		$health_bar.visible = true
