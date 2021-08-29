extends RemoteTransform2D

export (PackedScene) onready var MaskTexture
export (bool) var ShouldRemoveParent
export (bool) var ShouldDeleteMask = true
export (bool) var ShouldHide

var _placed_light_mask

func _ready() -> void:
    _placed_light_mask = MaskTexture.instance()
    get_tree().call_group("FogSurface", "add_child", _placed_light_mask)
    yield(get_tree(), "idle_frame")
    remote_path = _placed_light_mask.get_path()

func queue_free() -> void:
    if is_instance_valid(_placed_light_mask):
        _placed_light_mask.queue_free()

    .queue_free()

func _on_VisibilityNotifier2D_screen_entered() -> void:
    if not ShouldRemoveParent and is_instance_valid(get_parent()):
        get_parent().show()
        if is_instance_valid(_placed_light_mask):
            _placed_light_mask.show()
