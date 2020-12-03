class_name HUD
extends Control


signal all_coins_collected


var _score := 0
var _total_score := 0

onready var _score_label := $MarginContainer/HBoxContainer/Score as Label
onready var _total_score_label := $MarginContainer/HBoxContainer/TotalScore as Label


func _ready() -> void:
    _update_score_label()


func set_total_score(total_score: int) -> void:
    _total_score = total_score
    _total_score_label.text = '%02d' % _total_score


func on_coin_collected() -> void:
    _score += 1
    _update_score_label()
    if _score >= _total_score:
        emit_signal('all_coins_collected')


func _update_score_label() -> void:
    _score_label.text = '%02d' % _score
