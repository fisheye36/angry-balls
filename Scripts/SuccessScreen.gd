extends Control

const MAIN_MENU_SCENE_PATH := 'res://Scenes/MainMenu.tscn'

export var scene_switch_delay := 4.0


func _ready() -> void:
    var tree := get_tree()
    yield(tree.create_timer(scene_switch_delay), 'timeout')
    if tree.change_scene(MAIN_MENU_SCENE_PATH) != OK:
        tree.quit()
