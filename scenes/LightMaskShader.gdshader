shader_type canvas_item;

void fragment() {
    COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
    COLOR.a = texture(TEXTURE, UV).a;
}