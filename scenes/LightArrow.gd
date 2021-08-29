extends Area2D

const Epsilon = 5.0

signal returned

export (int) var Damage
export (float) var ReturnSpeed

var _initial_rotation := 0.0
var _is_recalling = false
var _parent_position = Vector2.ZERO
var _should_stop = false

onready var _trail = $Trail
onready var _mask_control = $MaskController

func _ready() -> void:
    set_physics_process(false)

func fire() -> void:
    set_physics_process(true)
    _is_recalling = false
    global_rotation = _initial_rotation

func recall_arrow() -> void:
    _is_recalling = true
    _trail.emitting = false
    _trail.hide()

func _physics_process(delta: float) -> void:
    if not _is_recalling:
        _on_physics_process(delta, _should_stop)
    else:
        global_position = global_position.move_toward(_parent_position, delta * ReturnSpeed)
        if global_position.distance_to(_parent_position) < Epsilon:
            _is_recalling = false
            emit_signal("returned")
            delete_mask()
            queue_free()

func _on_PlayerHit_body_entered(body: Node) -> void:
    emit_signal("returned")

func delete_mask() -> void:
    if is_instance_valid(_mask_control):
        _mask_control.queue_free()

func _on_physics_process(delta: float, should_recall: bool) -> void:
    pass

func _on_Arrow_body_entered(body: Node) -> void:
    if not _is_recalling:
        _trail.emitting = false
        _should_stop = true
    else:
        delete_mask()
        queue_free()
