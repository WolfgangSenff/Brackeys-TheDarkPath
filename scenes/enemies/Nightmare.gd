extends "res://scenes/enemies/EnemyBase.gd"

onready var _timer = $Timer
onready var _right = $Right
onready var _down = $Down
onready var _left = $Left
onready var _up = $Up
onready var _sprite = $AnimatedSprite
onready var _collision_normals = [_right, _down, _left, _up]

var _velocity = Vector2.RIGHT * 75

const NightmareShotScene = preload("res://scenes/enemies/NightmareShot.tscn")

func fire() -> void:
    set_physics_process(false)
    _sprite.play("fire")
    for x in 3:
        var projectile = NightmareShotScene.instance()
        get_tree().root.add_child(projectile)
        projectile.global_position = global_position
        projectile._velocity = Vector2.RIGHT.rotated(deg2rad(rand_range(180.0, 360.0)))
        projectile.set_physics_process(true)
        yield(get_tree().create_timer(0.1), "timeout")

    set_physics_process(true)
    _sprite.play("default")


func _physics_process(delta: float) -> void:
    var collision_normal = get_collision_normal()
    if collision_normal:
        _velocity = _velocity.bounce(collision_normal)

    global_position += _velocity * delta

func get_collision_normal():
    for collider in _collision_normals:
        if collider.is_colliding():
            return collider.get_collision_normal()

    return null

func _on_Timer_timeout() -> void:
    fire()

func _on_VisibilityNotifier2D_screen_entered() -> void:
    _timer.start(-1)
    set_physics_process(true)

func _on_VisibilityNotifier2D_screen_exited() -> void:
    _timer.stop()
    set_physics_process(false)
