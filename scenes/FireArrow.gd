extends Area2D

const Speed = 250
const VerticalSpeed = 100
const Gravity = 200
const TurnSpeed = 50
const Damage = 1
var facing = 1

var down_force = Vector2.ZERO

func setup(_facing : int) -> void:
    facing = _facing
    global_rotation = deg2rad(-25) if facing > 0 else deg2rad(-155)
    set_physics_process(false)

func _physics_process(delta: float) -> void:
    global_position += facing * delta * Speed * Vector2.RIGHT
    down_force += Gravity * Vector2.DOWN * delta
    global_position += (VerticalSpeed * Vector2.UP + down_force) * delta
    global_rotation += delta * deg2rad(TurnSpeed) * facing
