//
// Simple Shader to Replace the Given Base Colors with Other Replacement Colors
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_replacement_colors[4];
uniform float u_tint_amount;

// Base palette (PALETTES.GRAY): 239, 175, 95, 0 — must match scr_palette_shader
const vec4 BASE_0 = vec4(239.0/255.0, 239.0/255.0, 239.0/255.0, 1.0); // C_WHITE
const vec4 BASE_1 = vec4(175.0/255.0, 175.0/255.0, 175.0/255.0, 1.0); // C_GRAY_LIGHT
const vec4 BASE_2 = vec4( 95.0/255.0,  95.0/255.0,  95.0/255.0, 1.0); // C_GRAY
const vec4 BASE_3 = vec4(  0.0,         0.0,         0.0,        1.0); // C_BLACK

vec4 recolorPixel(vec4 pixel) {
    if (distance(pixel.rgb, BASE_0.rgb) < 0.1) { return vec4(u_replacement_colors[0].rgb, pixel.a); }
    if (distance(pixel.rgb, BASE_1.rgb) < 0.1) { return vec4(u_replacement_colors[1].rgb, pixel.a); }
    if (distance(pixel.rgb, BASE_2.rgb) < 0.1) { return vec4(u_replacement_colors[2].rgb, pixel.a); }
    if (distance(pixel.rgb, BASE_3.rgb) < 0.1) { return vec4(u_replacement_colors[3].rgb, pixel.a); }
    return pixel;
}

void main()
{
    vec4 base = recolorPixel(texture2D(gm_BaseTexture, v_vTexcoord));
    vec3 _rgb = mix(base.rgb, v_vColour.rgb, u_tint_amount);
	if (v_vColour.rgb == vec3(1.0, 1.0, 1.0)) { _rgb = base.rgb; }
    gl_FragColor = vec4(_rgb, base.a * v_vColour.a);
}