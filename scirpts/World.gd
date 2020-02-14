extends Node2D


var score = 0 setget set_score, get_score
const level_to_load = preload("res://levels/Level1.tscn")


func _ready():
	var level = level_to_load.instance()
	add_child(level)
	pass # Replace with function body.

func _process(delta):
	pass
	
func set_score(value):
	score = value
	get_node("GUI/Score").set_text("Score: "+str(score))
	
	
	
func get_score():
	return score
