extends Node2D


var score = 0 setget set_score, get_score
var ball_mut = Mutex.new()
var n_balls = 0
const game_over_scene = preload("res://scenes/GameOverScreen.tscn")

func _ready():
    pass # Replace with function body.

func _process(delta):
    pass
    
func set_score(value):
    score = 0
    Global.score = value
    score = Global.score
    get_node("GUI/Score").set_text("SCORE: "+str(score))
    
    
    
func get_score():
    return Global.score
    
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
        print("no balls left")
        Global.lifes -= 1
        print("lifes: " +str(Global.lifes))
        $GUI/LifesHbox.lifes = Global.lifes
        if Global.lifes == 0:
            print("game_over")
            #get_node("PauseScreen").set_process_input(false)
            var game_over = game_over_scene.instance()
            add_child(game_over)
            get_tree().paused = true
        else:
            reset_game()
            
func reset_game():
    # play shaky screen animation or something
    $Base/Bar.can_launch_ball = true
    
    
    