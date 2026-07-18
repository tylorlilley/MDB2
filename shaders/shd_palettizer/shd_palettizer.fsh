//
// Simple Shader to Replace the Given Base Colors with Other Replacement Colors
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_replacement_colors[4];

// Base palette (PALETTES.GRAY): 239, 175, 95, 0 — must match scr_palette_shader
const vec4 BASE_0 = vec4(239.0/255.0, 239.0/255.0, 239.0/255.0, 1.0); // C_WHITE
const vec4 BASE_1 = vec4(175.0/255.0, 175.0/255.0, 175.0/255.0, 1.0); // C_GRAY_LIGHT
const vec4 BASE_2 = vec4( 95.0/255.0,  95.0/255.0,  95.0/255.0, 1.0); // C_GRAY
const vec4 BASE_3 = vec4(  0.0,         0.0,         0.0,        1.0); // C_BLACK

vec4 recolorPixel(vec4 pixel) {
    if (distance(pixel, BASE_0) < 0.1) { return u_replacement_colors[0]; }
    if (distance(pixel, BASE_1) < 0.1) { return u_replacement_colors[1]; }
    if (distance(pixel, BASE_2) < 0.1) { return u_replacement_colors[2]; }
    if (distance(pixel, BASE_3) < 0.1) { return u_replacement_colors[3]; }
    return pixel;
}

void main()
{
	vec4 pixel =  texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = v_vColour * recolorPixel(pixel);
}