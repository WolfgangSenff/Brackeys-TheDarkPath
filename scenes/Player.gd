extends KinematicBody2D

const Gravity = 200
const MaxMoveSpeed = 120
const Acceleration = 60
const Friction = 100


var CurrentHP = 100
var _velocity = Vector2.ZERO
var _previous_facing = 1
var _arrow_fired = false
const Arrow = preload("res://scenes/LightArrow.tscn")

var _arrow_timeout = 0

func _physics_process(delta: float) -> void:
    if _arrow_fired:
        _arrow_timeout += delta
        if _arrow_timeout > .05:
            _arrow_fired = false
            _arrow_timeout = 0

    var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    var jump_input = Input.is_action_pressed("jump")
    _velocity += Gravity * Vector2.DOWN * delta
    _velocity.x = x_input * MaxMoveSpeed
    _velocity.y = move_and_slide(_velocity, Vector2.UP, true).y

    if x_input != 0:
        _previous_facing = sign(x_input)
