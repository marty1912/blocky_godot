extends Node2D

export (String) var next_level = ""
var score = 0 setget set_score, get_score
var ball_mut = Mutex.new()
var n_balls = 0
var brick_mut = Mutex.new()
var n_bricks = 0
const game_over_scene = preload("res://scenes/GameOverScreen.tscn")
const level_clear_scene = preload("res://scenes/LevelClearScreen.tscn")

func _ready():
    $Base/Bar.activate_launch_mode()
    set_score(Global.score)
    pass # Replace with function body.
    

    
    
func set_score(value):
    score = 0
    Global.score = value
    score = Global.score
    get_node("GUI/Score").set_text("SCORE: "+str(score))
        

func remove_brick():
    brick_mut.lock()
    n_bricks-=1
    var cp_n_bricks = n_bricks
    brick_mut.unlock()
    #print("rm brick, n_bricks:" + str(cp_n_bricks))
    if cp_n_bricks == 0:
        print("clear")
        var level_clear = level_clear_scene.instance()
        level_clear.next_level = next_level
        add_child(level_clear)
        get_tree().paused = true
        
    
func add_brick():
    brick_mut.lock()
    n_bricks+=1
    var cp_n_bricks = n_bricks
    brick_mut.unlock()
    #print("add brick n_bricks"+str(n_bricks))
    
    
    
    
func get_score():
    return Global.score
    
func ball_add():
    ball_mut.lock()
    n_balls+=1
    var copy_n_balls = n_balls
    ball_mut.unlock()
    print("(World) Ball add n_balls:"+str(copy_n_balls))


func ball_leave():
    ball_mut.lock()
    n_balls -= 1
    if n_balls < 0:
        n_balls = 0
    var copy_n_balls = n_balls
    ball_mut.unlock()
    print("(World) Ball leave n_balls:"+str(copy_n_balls))
    if copy_n_balls == 0:
        $cam.shake()
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
    $Base/Bar.activate_launch_mode()
    # play shaky screen animation or something
    $Base/Bar.can_launch_ball = true
    
    
    