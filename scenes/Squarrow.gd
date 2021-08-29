class_name Squarrow
extends "res://scenes/LightArrow.gd"


func _on_physics_process(delta: float, should_recall: bool) -> void:
    if not should_recall:
        global_position += Vector2.RIGHT.rotated(_initial_rotation) * delta * 100
        global_rotation += deg2rad(50) * delta
