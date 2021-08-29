extends Area2D

export (float) var HP

onready var _mask_control = $MaskController

func _on_EnemyBase_area_entered(area: Area2D) -> void:
    HP -= area.Damage
    if HP <= 0:
        set_physics_process(false)
        if is_instance_valid(_mask_control):
             _mask_control.delete_mask()
        queue_free()
