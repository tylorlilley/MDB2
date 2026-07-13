//
// Simple Shader to Replace Black Pixels with White Pixels
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
	if (texColor.r == 0.0 && texColor.g == 0.0 && texColor.b == 0.0) {
		gl_FragColor = vec4(1.0, 1.0, 1.0, texColor.a);
	}
}