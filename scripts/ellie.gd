extends CharacterBody2D

signal history_updated


const speed = 100
var current_direction = "down"
var position_history = []
var max_history_length = 25


func _physics_process(delta: float) -> void:
	var character_moved = false
	character_moved = player_movement(delta)
	
	if character_moved:
		add_position_to_history()
		emit_signal("history_updated", position_history)


func add_position_to_history():
	# Add the character position to the history so that the follower
	# can follow the lead character
	var past_position = {"x": position.x, "y": position.y , "direction": current_direction}
	position_history.append(past_position)
	
	if position_history.size() > max_history_length:
		position_history.pop_front()

func play_animation(animation):
	var sprite = $AnimatedSprite2D
	sprite.play(animation)


func player_movement(delta) -> bool:
	var character_moved = true
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
		character_moved = false
		play_animation("idle_" + current_direction)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()
	return character_moved
