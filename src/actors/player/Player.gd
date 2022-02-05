extends "res://actors/Actor.gd"
class_name player

const MAX_HEALTH = 100

# Animation tree types
enum MovementTreeAnimations {
    IDLE,
    WALK
}
enum ActionTreeAnimations {
    KICK,
    THROW,
    STUN
}
enum RootTreeAnimations {
    MOVEMENT,
    ACTIONS
}

export(int, 1, 4) var PLAYER = 1

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree

var animation_state = 0
var direction = Vector2()


func flip_sprite(x: int) -> void:
    """Flip player sprite
    x - x direction
    """
    if x < 1:
        sprite.flip_h = true
    else:
        sprite.flip_h = false


func _ready():
    self.health = MAX_HEALTH


func _input(event):
    """Input capturing"""
    direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    if event.is_action_pressed("ui_select"):
        direction.y = -1
    flip_sprite(direction.x)


func _process(delta):
    """Process loop *(1 / frame)*"""
    pass


func _physics_process(delta):
    """Physics loop"""
    actor_move(delta, direction)
