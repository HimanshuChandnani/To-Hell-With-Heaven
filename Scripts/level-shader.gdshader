shader_type canvas_item;

uniform vec4 color1 = vec4(1.0, 1.0, 1.0, 1.0); // White
uniform vec4 color2 = vec4(1.0, 0.0, 0.0, 1.0); // Red

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy;

    if (uv.y < 0.5) {
        // Top 50%
        COLOR = color1;
    } else {
        // Bottom 50%
        COLOR = color2;
    }
}
