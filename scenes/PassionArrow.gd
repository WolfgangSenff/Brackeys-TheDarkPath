class_name Passion
extends "res://scenes/LightArrow.gd"

var _current_direction = 1

func _on_physics_process(delta: float, should_recall: bool) -> void:
    if not should_recall:
        if global_rotation > (_initial_rotation + deg2rad(45)) || global_rotation < (_initial_rotation + deg2rad(-45)):
            _current_direction = -_current_direction

        global_rotation += deg2rad(15) * _current_direction * 30 * delta
        global_position += Vector2.RIGHT.rotated(global_rotation) * 250 * delta
