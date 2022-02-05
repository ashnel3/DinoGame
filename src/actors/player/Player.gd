extends "res://actors/Actor.gd"

var direction = Vector2()


func _ready():
    pass


func _process(delta):
    pass


func _physics_process(delta):
    direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    if Input.is_action_pressed("ui_select"):
        direction.y = -1
    actor_move(delta, direction)
