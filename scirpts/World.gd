extends Node2D


var score = 0 setget set_score, get_score
var ball_mut = Mutex.new()
var n_balls = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func set_score(value):
	score = value
	get_node("GUI/Score").set_text("Score: "+str(score))
	
	
	
func get_score():
	return score
	
func ball_add():
	ball_mut.lock()
	n_balls+=1
	ball_mut.unlock()

func ball_leave():
	ball_mut.lock()
	n_balls-=1
	var copy_n_balls = n_balls
	ball_mut.unlock()
	if copy_n_balls == 0:
		print("game_over")
		get_tree().paused = true
		