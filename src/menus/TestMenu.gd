extends Control


func _on_StartButton_pressed():
    SceneManager.set_scene("res://scenes/level2/Level2.tscn", "fade")


func _on_QuitButton_pressed():
    get_tree().quit(0)
