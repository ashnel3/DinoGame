extends Node2D

onready var animation_player = $AnimationPlayer

# TODO: implement transition delay
# FIXME: scene changes before animation is finished
func set_scene(path: String, transition: String = "fade", speed: float = 1.0, delay: float = 0):
    animation_player.playback_speed = speed
    animation_player.play(transition)
    yield(animation_player, "animation_finished")
    assert(get_tree().change_scene(path) == OK)
    animation_player.play_backwards(transition)
