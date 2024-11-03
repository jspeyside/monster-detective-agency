extends Node2D


func _ready():
	var ellie: Node = get_node("ellie")
	var ezra: Node = get_node("ezra")
	#10 is the number of "frames" that the follower lags behind the leader
	ezra.follow(ellie, 0)
