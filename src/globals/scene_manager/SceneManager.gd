extends Node2D

onready var animation_player = $AnimationPlayer

# TODO: implement transition delay
func set_scene(path: String, transition: String = "fade", speed: float = 1.0, delay: float = 0):
    animation_player.play(transition, -1, speed)
    yield(animation_player, "animation_finished")
    assert(get_tree().change_scene(path) == OK)
    animation_player.play(transition, -1, -speed, true)
