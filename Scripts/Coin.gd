extends Area

signal collected

const FLOAT_ANIM_NAME := 'Float'

export var rotation_deg_per_sec := 180.0

onready var _mesh := $MeshInstance as MeshInstance
onready var _collision := $CollisionShape as CollisionShape
onready var _animation := $MeshInstance/AnimationPlayer as AnimationPlayer


func _process(delta: float) -> void:
    _mesh.rotate_y(deg2rad(rotation_deg_per_sec * delta))


func collected_by(body: Node) -> void:
    if body is Player:
        _collision.set_deferred('disabled', true)
        _animation.play(FLOAT_ANIM_NAME)
        emit_signal('collected')


func _on_animation_finished(anim_name: String) -> void:
    if anim_name == FLOAT_ANIM_NAME:
        queue_free()
