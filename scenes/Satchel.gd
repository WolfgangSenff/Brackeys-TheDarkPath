extends Node2D

var _current_arrow_count = 4
var _current_arrow_index = 0
onready var _normal_arrow = $NormalArrow
onready var _passion_arrow = $PassionArrow
onready var _squarrow = $Squarrow
onready var _piercing_arrow = $PiercingArrow

onready var _arrow_to_projectile_map = {
    $NormalArrow : preload("res://scenes/NormalArrow.tscn"),
    $PassionArrow : preload("res://scenes/PassionArrow.tscn"),
    $Squarrow : preload("res://scenes/Squarrow.tscn"),
    $PiercingArrow : preload("res://scenes/PiercingArrow.tscn")
   }

var _active_arrows = []

func _physics_process(delta: float) -> void:

    for arrow in _active_arrows:
        if not is_instance_valid(arrow):
            _active_arrows.erase(arrow)

    if _current_arrow_count > 0:
        global_rotation_degrees += delta * 200.0 / _current_arrow_count
    var arrow_instance = null
    var arrow_sprite = null
    var placement = null
    if Input.is_action_just_pressed("arrow1") and _normal_arrow.visible:
        arrow_sprite = _normal_arrow
        arrow_instance = _arrow_to_projectile_map[_normal_arrow]
    elif Input.is_action_just_pressed("arrow2") and _passion_arrow.visible:
        arrow_sprite = _passion_arrow
        arrow_instance = _arrow_to_projectile_map[_passion_arrow]
    elif Input.is_action_just_pressed("arrow3") and _squarrow.visible:
        arrow_sprite = _squarrow
        arrow_instance = _arrow_to_projectile_map[_squarrow]
    elif Input.is_action_just_pressed("arrow4") and _piercing_arrow.visible:
        arrow_sprite = _piercing_arrow
        arrow_instance = _arrow_to_projectile_map[_piercing_arrow]

    if Input.is_action_just_pressed("recall_all_arrows"):
        for arrow in _active_arrows:
            if is_instance_valid(arrow): # Just in case
                arrow.recall_arrow()

    if arrow_sprite != null:
        arrow_instance = arrow_instance.instance()
        get_tree().root.add_child(arrow_instance)
        arrow_instance.global_position = arrow_sprite.global_position
        arrow_instance._parent_position = arrow_sprite.global_position
        arrow_instance._initial_rotation = arrow_sprite.global_rotation
        arrow_instance.fire()
        arrow_instance.connect("returned", self, "_on_arrow_returned", [arrow_instance], CONNECT_ONESHOT)
        arrow_sprite.hide()
        _active_arrows.push_back(arrow_instance)
        _current_arrow_count -= 1

func _on_arrow_returned(arrow) -> void:
    if arrow is Normal:
        _normal_arrow.show()
        _current_arrow_count += 1
    elif arrow is Passion:
        _passion_arrow.show()
        _current_arrow_count += 1
    elif arrow is Squarrow:
        _squarrow.show()
        _current_arrow_count += 1
    elif arrow is Piercing:
        _piercing_arrow.show()
        _current_arrow_count += 1
