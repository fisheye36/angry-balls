extends Control

const LOADING_SCREEN_SCENE_PATH := 'res://Scenes/LoadingScreen.tscn'

export var title_max_rotation_deg := 8.0
export var title_rotation_period := 3.0

var _time_elapsed := 0.0

onready var _title_label := $MarginContainer/VBoxContainer/TitleLabel as Label
onready var _play_button := $MarginContainer/VBoxContainer/PlayButton as Button


func _ready() -> void:
    _center_title_label_pivot()


func _process(delta: float) -> void:
    _rotate_title_label(delta)


func _on_play_button_pressed() -> void:
    _play_button.disabled = true
    var tree := get_tree()
    yield(tree.create_timer(0.5), 'timeout')
    if tree.change_scene(LOADING_SCREEN_SCENE_PATH) != OK:
        tree.quit()


func _on_title_label_resized() -> void:
    _center_title_label_pivot()


func _center_title_label_pivot() -> void:
    _title_label.rect_pivot_offset = _title_label.rect_size / 2


func _rotate_title_label(delta: float) -> void:
    _time_elapsed += delta
    var rotation := sin(PI / title_rotation_period * _time_elapsed) * title_max_rotation_deg
    _title_label.rect_rotation = rotation
