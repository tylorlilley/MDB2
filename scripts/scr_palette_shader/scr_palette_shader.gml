enum SWITCH_COLORS {
	RED,
	BLUE,
	YELLOW
}

global.C_WHITE = make_color_rgb(239, 239, 239);
global.C_GRAY_LIGHT = make_color_rgb(175, 175, 175);
global.C_GRAY = make_color_rgb(95, 95, 95);
global.C_GRAY_DARK = make_color_rgb(71, 71, 71);
global.C_NEAR_BLACK = make_color_rgb(23, 23, 23);
global.C_BLACK = make_color_rgb(0, 0, 0);

global.C_SAND_LIGHT = make_color_rgb(241, 226, 175); // make_color_rgb(247, 231, 151);
global.C_SAND = make_color_rgb(222, 202, 131); // C_YELLOW_LIGHT
global.C_SAND_DARK = make_color_rgb(197, 167, 31); // C_YELLOW

global.C_YELLOW_LIGHT = make_color_rgb(247, 231, 151); // make_color_rgb(247, 231, 151);
global.C_YELLOW = make_color_rgb(240, 188, 60); // make_color_rgb(207, 167, 0);
global.C_YELLOW_DARK = make_color_rgb(136, 112, 0); // make_color_rgb(135, 103, 0);

global.C_BROWN_LIGHT = global.C_YELLOW;
global.C_BROWN = global.C_YELLOW_DARK;
global.C_BROWN_DARK = make_color_rgb(64, 44, 0); // make_color_rgb(71, 63, 0);

global.C_BLUE_DARK = make_color_rgb(0, 87, 247);
global.C_BLUE = make_color_rgb(39, 159, 255);
global.C_BLUE_LIGHT = make_color_rgb(175, 207, 255);

global.C_RED_DARK = make_color_rgb(143, 6, 0);
global.C_RED = make_color_rgb(223, 23, 0);
global.C_RED_LIGHT = make_color_rgb(255, 199, 207);

global.PALETTE_ALL_WHITE = [global.C_WHITE, global.C_WHITE, global.C_WHITE, global.C_WHITE];
global.PALETTE_GRAYSCALE = [global.C_WHITE, global.C_GRAY_LIGHT, global.C_GRAY, global.C_BLACK];
global.PALETTE_SAND = [global.C_SAND_LIGHT, global.C_SAND, global.C_SAND_DARK, global.C_BLACK];
global.PALETTE_YELLOW = [global.C_YELLOW_LIGHT, global.C_YELLOW, global.C_YELLOW_DARK, global.C_BLACK];
global.PALETTE_BROWN = [global.C_BROWN_LIGHT, global.C_BROWN, global.C_BROWN_DARK, global.C_BLACK];
global.PALETTE_BLUE = [global.C_BLUE_LIGHT, global.C_BLUE, global.C_BLUE_DARK, global.C_BLACK];
global.PALETTE_RED = [global.C_RED_LIGHT, global.C_RED, global.C_RED_DARK, global.C_BLACK];

function darken_palette(_palette) {
	return [_palette[1], _palette[2], _palette[3], global.C_BLACK]; 
}

function color_uniform_values(_color) {
	return [color_get_red(_color)/255, color_get_green(_color)/255, color_get_blue(_color)/255, 1];
}

function palette_uniform_values(_palette) {
	return array_concat(
		color_uniform_values(_palette[0]),
		color_uniform_values(_palette[1]),
		color_uniform_values(_palette[2]),
		color_uniform_values(_palette[3])
	);
}

function get_switch_palette(_switch_color) {
	switch (_switch_color) {
		case SWITCH_COLORS.RED: { return global.PALETTE_RED; }
		case SWITCH_COLORS.BLUE: { return global.PALETTE_BLUE; }
		case SWITCH_COLORS.YELLOW: { return global.PALETTE_YELLOW; }
	}
}

function get_switch_color(_switch_color) {
	switch (_switch_color) {
		case SWITCH_COLORS.RED: { return global.C_RED; }
		case SWITCH_COLORS.BLUE: { return global.C_BLUE; }
		case SWITCH_COLORS.YELLOW: { return global.C_YELLOW; }
	}
}