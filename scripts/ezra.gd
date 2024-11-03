extends CharacterBody2D

const speed = 100
var current_direction = "down"

var party_leader: Node
var tracking_index = 10


func _physics_process(delta: float) -> void:
	player_movement(delta)

func follow(party_leader: Node, tracking_index: int):
	self.party_leader = party_leader
	self.tracking_index = tracking_index
	party_leader.connect("history_updated", on_leader_history_updated)


func on_leader_history_updated(position_history):
	var past_position
	if (position_history.size() < tracking_index + 1):
		return
		
	var current_x = position.x
	var current_y = position.y
	past_position = position_history[tracking_index]
	
	var animation = "idle_down"
	if(past_position["x"] > position.x):
		animation = "walk_right"
	elif(past_position["x"] < position.x):
		animation = "walk_left"
	elif(past_position["y"] > position.y):
		animation = "walk_down"
	elif(past_position["y"] < position.y):
		animation = "walk_up"
	else:
		animation = "idle_" + past_position["direction"]
	current_direction = past_position["direction"]
		
	position = Vector2(past_position["x"], past_position["y"])
	
	play_animation(animation)


func play_animation(animation):
	var sprite = $AnimatedSprite2D
	sprite.play(animation)


func player_movement(delta):
	if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")  or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up")):
		play_animation("idle_" + current_direction)
