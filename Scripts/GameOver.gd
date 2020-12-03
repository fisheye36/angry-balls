extends Control

const MAIN_MENU_SCENE_PATH := 'res://Scenes/MainMenu.tscn'

export var title_max_scale_factor := 0.1
export var title_rotation_period := 1.0

var _time_elapsed := 0.0

onready var _title_label := $MarginContainer/CenterContainer/VBoxContainer/TitleLabel as Label
onready var _menu_button := $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/MenuButton as Button
onready var _quit_button := $MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/QuitButton as Button


func _ready() -> void:
    _center_title_label_pivot()


func _process(delta: float) -> void:
    _scale_title_label(delta)


func _on_menu_button_pressed() -> void:
    var tree := get_tree()
    if tree.change_scene(MAIN_MENU_SCENE_PATH) != OK:
        tree.quit()


func _on_quit_button_pressed() -> void:
    get_tree().quit(0)


func _on_title_label_resized() -> void:
    _center_title_label_pivot()


func _center_title_label_pivot() -> void:
    _title_label.rect_pivot_offset = _title_label.rect_size / 2


func _scale_title_label(delta: float) -> void:
    _time_elapsed += delta
    var scale_modifier = sin(PI / title_rotation_period * _time_elapsed) * title_max_scale_factor
    _title_label.rect_scale = Vector2.ONE * (1.0 + scale_modifier)
