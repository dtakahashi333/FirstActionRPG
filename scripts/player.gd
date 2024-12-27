extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 200
var player_alive = true
const speed = 100
var cur_dir = "none"
var attack_in_progress = false


func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")


func _physics_process(delta: float) -> void:
	player_movement(delta)
	enemy_attack()
	attack()
	if health <= 0:
		player_alive = false
		health = 0
		print("player has been killed")
		self.queue_free()


func player_movement(delta: float) -> void:
	
	if Input.is_action_pressed("ui_right"):
		cur_dir = "right"
		play_amimation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		cur_dir = "left"
		play_amimation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		cur_dir = "down"
		play_amimation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		cur_dir = "up"
		play_amimation(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_amimation(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()


func play_amimation(movement: int) -> void:
	var dir = cur_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if not attack_in_progress:
				anim.play("side_idle")
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if not attack_in_progress:
				anim.play("side_idle")
	elif dir == "down":
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if not attack_in_progress:
				anim.play("front_idle")
	elif dir == "up":
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if not attack_in_progress:
				anim.play("back_idle")


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = false


func enemy_attack() -> void:
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		print(health)
		$attack_cooldown.start()


func player() -> void:
	pass


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true


func attack() -> void:
	var dir = cur_dir
	
	if Input.is_action_pressed("attack"):
		global.player_current_attack = true
		attack_in_progress = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "down":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		elif dir == "up":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
		


func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_in_progress = false
