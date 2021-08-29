extends Area2D

var _velocity
var Damage = 10

func _ready() -> void:
    set_physics_process(false)

func fire() -> void:
    set_physics_process(true)

func _physics_process(delta : float) -> void:
    global_position += _velocity * 200 * delta

func _on_VisibilityNotifier2D_screen_exited() -> void:
    queue_free()
