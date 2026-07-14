//
// Simple Shader to Replace the Given Base Colors with Other Replacement Colors
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_base_colors[4];
uniform vec4 u_replacement_colors[4];

vec4 recolorPixel(vec4 pixel) {
	for (int i = 0; i < 4; i++) {
        if (distance(pixel, u_base_colors[i]) < 0.1) {
            return u_replacement_colors[i];
        }
    }
	return pixel;
}

void main()
{
	vec4 pixel =  texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = recolorPixel(pixel);
}