extends Control

const FIRST_LEVEL_SCENE_PATH := 'res://Scenes/Level.tscn'


func _ready() -> void:
    var tree := get_tree()
    yield(tree.create_timer(0.1), 'timeout')
    if tree.change_scene(FIRST_LEVEL_SCENE_PATH) != OK:
        tree.quit()
