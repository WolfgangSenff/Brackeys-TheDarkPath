extends Viewport

var _display_width = ProjectSettings.get("display/window/size/width")
var _display_height = ProjectSettings.get("display/window/size/height")

func _ready() -> void:
    size = Vector2(_display_width, _display_height)
