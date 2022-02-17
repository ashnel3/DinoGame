extends "res://actors/Actor.gd"
class_name player

const MAX_HEALTH = 100

# Animation tree values
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


func __reset_animation_state() -> void:
    """Return to last movement animation"""
    animation_state = 0


func __flip_sprite(x: int) -> void:
    """Flip player sprite
    x - x direction
    """
    if x == 0: return
    if x < 1:
        sprite.flip_h = true
    else:
        sprite.flip_h = false


func __animation_loop() -> void:
    if abs(direction.x) > 0 or abs(direction.y) > 0:
        animation_tree.set("parameters/movement/current", 1)
    else:
        animation_tree.set("parameters/movement/current", 0)


func _ready():
    self.health = MAX_HEALTH


func _input(event):
    """Input capturing"""
    direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    if Input.is_action_pressed("ui_select"):
        direction.y = -1
    __flip_sprite(direction.x)


func _process(delta):
    """Process loop"""
    __animation_loop()


func _physics_process(delta):
    """Physics loop"""
    actor_move(delta, direction)
