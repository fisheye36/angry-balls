extends Spatial


const SUCCESS_SCREEN_SCENE_PATH := 'res://Scenes/SuccessScreen.tscn'

export(PackedScene) var game_over_scene

onready var _player := $Player as Player
onready var _tween := $Player/Tween as Tween
onready var _coins := $Coins as Spatial
onready var _hud := $HUD as HUD


func _ready() -> void:
    var total_coins := _coins.get_child_count()
    _hud.set_total_score(total_coins)


func _on_body_entered_enemy(body: Node) -> void:
    if body == _player:
        _player.die()


func _on_player_death() -> void:
    var tree := get_tree()
    yield(tree.create_timer(2.0), 'timeout')
    if tree.change_scene_to(game_over_scene) != OK:
        tree.quit()


func _on_all_coins_collected() -> void:
    _player.disable()
    _tween.interpolate_property(_player, 'translation:y', null, _player.translation.y + 10.0,
                                2.0, Tween.TRANS_QUAD, Tween.EASE_IN, 0.5)
    _tween.start()


func _on_player_reached_heaven() -> void:
    var tree := get_tree()
    if tree.change_scene(SUCCESS_SCREEN_SCENE_PATH) != OK:
        tree.quit()
