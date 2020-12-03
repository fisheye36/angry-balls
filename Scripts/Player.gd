class_name Player
extends KinematicBody


signal died

export var speed := 10.0
export var acceleration := 10.0
export var deceleration := 5.0
export var rotation_modifier := 1.0

var _velocity := Vector3.ZERO
var _is_disabled := false

onready var _mesh := $MeshInstance as MeshInstance
onready var _collision := $CollisionShape as CollisionShape


func _physics_process(delta: float) -> void:
    if _is_disabled:
        return

    var direction := Vector3(
        Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left'),
        0,
        Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
    )

    if direction:
        var desired_velocity: Vector3 = direction.normalized() * speed
        _velocity = _velocity.linear_interpolate(desired_velocity, acceleration * delta)
    else:
        _velocity = _velocity.linear_interpolate(Vector3.ZERO, deceleration * delta)

    if _velocity:
        _mesh.rotate(_velocity.cross(Vector3.DOWN).normalized(),
                     _velocity.length() * rotation_modifier * delta)
    _velocity = move_and_slide(_velocity)


func die() -> void:
    disable()
    hide()
    emit_signal('died')


func disable() -> void:
    _is_disabled = true
    _collision.set_deferred('disabled', true)
