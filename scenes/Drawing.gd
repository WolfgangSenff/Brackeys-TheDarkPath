extends Node2D

var _draw_positions = {}

func _draw() -> void:
    if _draw_positions.empty(): return

    for _draw_position in _draw_positions.keys():
        draw_circle(_draw_position, _draw_positions[_draw_position], Color.white)

    _draw_positions.clear()

func draw_at(pos, size = 50) -> void:
    _draw_positions[pos] = size
    update()
