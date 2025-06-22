shader_type canvas_item;

uniform vec4 highlight_color : source_color = vec4(1.0, 1.0, 0.0, 1.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float luminance = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
    if (luminance < 0.5) {
        COLOR = vec4(highlight_color.rgb, tex_color.a*0.5);
    } else {
        discard;
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
