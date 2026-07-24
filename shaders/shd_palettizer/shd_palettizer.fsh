//
// Simple Shader to Replace the Given Base Colors with Other Replacement Colors
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_replacement_colors[4];
uniform float u_tint_amount;

// Base palette (PALETTES.GRAY): 239, 175, 95, 0 — must match scr_palette_shader
const vec4 BASE_0 = vec4(239.0/255.0, 239.0/255.0, 239.0/255.0, 1.0);
const vec4 BASE_1 = vec4(175.0/255.0, 175.0/255.0, 175.0/255.0, 1.0);
const vec4 BASE_2 = vec4( 95.0/255.0,  95.0/255.0,  95.0/255.0, 1.0);
const vec4 BASE_3 = vec4(  0.0,         0.0,         0.0,        1.0);

void main()
{
    vec4 pixel = texture2D(gm_BaseTexture, v_vTexcoord);

    vec3 pal    = pixel.rgb;
    bool is_pal = true;

    if      (distance(pixel.rgb, BASE_0.rgb) < 0.1) { pal = u_replacement_colors[0].rgb; }
    else if (distance(pixel.rgb, BASE_1.rgb) < 0.1) { pal = u_replacement_colors[1].rgb; }
    else if (distance(pixel.rgb, BASE_2.rgb) < 0.1) { pal = u_replacement_colors[2].rgb; }
    else if (distance(pixel.rgb, BASE_3.rgb) < 0.1) { pal = u_replacement_colors[3].rgb; }
    // Non-palette pixels — untextured primitives (1x1 white texel) and font
    // glyphs — must keep full v_vColour modulation, or draw_rectangle /
    // draw_text colours get diluted toward the source pixel.
    else                                            { is_pal = false; }

    float tint = is_pal ? u_tint_amount : 1.0;
    gl_FragColor = vec4(mix(pal, pal * v_vColour.rgb, tint), pixel.a * v_vColour.a);
}