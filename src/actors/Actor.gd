extends KinematicBody2D
class_name Actor

export(float, 0, 1) var ACCELERATION = 0.1
export(float) var SPEED = 3.0
export(int) var GRAVITY = 1

export(int) var health = 100

var velocity = Vector2()


func actor_fly(delta: float, direction: Vector2):
    velocity = direction / delta * SPEED
    velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)


func actor_move(delta: float, direction: Vector2):
    if direction.y == -1 and is_on_floor():
        velocity.y =  100 * -SPEED
    else:
        velocity.y += GRAVITY / delta * 0.3
    velocity.x = lerp(direction.x / delta * SPEED, 0, ACCELERATION)
    velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
