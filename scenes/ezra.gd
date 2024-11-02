extends CharacterBody2D

const speed = 100
var current_direction = "down"


func _physics_process(delta: float) -> void:
	player_movement(delta)


func play_animation(animation):
	var sprite = $AnimatedSprite2D
	sprite.play(animation)


func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation("walk_right")
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation("walk_left")
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation("walk_down")
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation("walk_up")
		velocity.x = 0
		velocity.y = -speed
	else:
		play_animation("idle_" + current_direction)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()
