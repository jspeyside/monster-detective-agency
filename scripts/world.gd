extends Node2D


func _ready():
	var ellie: Node = get_node("ellie")
	var ezra: Node = get_node("ezra")
	#10 is the number of "frames" that the follower lags behind the leader
	ezra.follow(ellie, 0)


func _input(event: InputEvent):	
	if Dialogic.current_timeline != null:
		return
		
	if event is InputEventKey and event.keycode == KEY_ENTER and event.is_pressed():
		Dialogic.start('test_timeline')
		get_viewport().set_input_as_handled()
