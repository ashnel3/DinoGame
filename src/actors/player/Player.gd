extends "res://actors/Actor.gd"
class_name player

const MAX_HEALTH = 100

# Animation tree values
enum MovementTreeAnimations {
    IDLE,
    WALK
}
enum RootTreeAnimations {
    MOVEMENT,
    KICK,
    THROW,
    STUN
}

export(int, 1, 4) var PLAYER = 1
export(float) var KICK_TIME = 1.0
export(float) var THROW_TIME = 1.0

onready var sprite = $FlipContainer/Sprite
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree

var animation_movement_state = 0
var animation_state = 0
var direction = Vector2()


func damage(v: int) -> int:
    self.health = self.health - v
    if self.health < 0:
        print("dead")
    else:
        animation_state = RootTreeAnimations.STUN
        animation_tree.set("parameters/root/current", RootTreeAnimations.STUN)
    return self.health


func kick() -> void:
    if $Timers/KickTimer.is_stopped():
        animation_state = RootTreeAnimations.KICK
        $Timers/KickTimer.start()
        animation_tree.set("parameters/root/current", RootTreeAnimations.KICK)


func throw() -> void:
    if $Timers/BombTimer.is_stopped():
        animation_state = RootTreeAnimations.THROW
        $Timers/BombTimer.start()
        animation_tree.set("parameters/root/current", RootTreeAnimations.THROW)


func __reset_animation_state() -> void:
    """Return to last movement animation"""
    animation_state = RootTreeAnimations.MOVEMENT
    animation_tree.set("parameters/root/current", animation_state)


# TODO: implement flip container
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
    if abs(direction.x) > 0 or velocity.y < 0:
        animation_movement_state = MovementTreeAnimations.WALK
    else:
        animation_movement_state = MovementTreeAnimations.IDLE
    animation_tree.set("parameters/movement/current", animation_movement_state)


func _ready():
    self.health = MAX_HEALTH
    $Timers/BombTimer.wait_time = THROW_TIME
    $Timers/KickTimer.wait_time = KICK_TIME


func _input(event):
    """Input capturing"""
    direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    if event.is_action_pressed("ui_cancel"):
        kick()
    if Input.is_action_pressed("ui_select"):
        direction.y = -1
    __flip_sprite(direction.x)


func _process(delta):
    """Process loop"""
    __animation_loop()


func _physics_process(delta):
    """Physics loop"""
    actor_move(delta, direction)
