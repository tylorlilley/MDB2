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

global.C_SAND = make_color_rgb(247, 231, 151);
global.C_YELLOW_LIGHT = make_color_rgb(247, 231, 151);
global.C_YELLOW = make_color_rgb(207, 167, 0);
global.C_YELLOW_DARK = make_color_rgb(135, 103, 0);
global.C_BROWN_DARK = make_color_rgb(71, 63, 0);

global.C_BLUE_DARK = make_color_rgb(0, 87, 247);
global.C_BLUE = make_color_rgb(39, 159, 255);
global.C_BLUE_LIGHT = make_color_rgb(175, 207, 255);

global.C_RED_DARK = make_color_rgb(143, 6, 0);
global.C_RED = make_color_rgb(223, 23, 0);
global.C_RED_LIGHT = make_color_rgb(255, 199, 207);

global.PALETTE_ALL_WHITE = [global.C_WHITE, global.C_WHITE, global.C_WHITE, global.C_WHITE];
global.PALETTE_GRAYSCALE = [global.C_WHITE, global.C_GRAY_LIGHT, global.C_GRAY, global.C_BLACK];
global.PALETTE_SAND = [global.C_SAND, global.C_YELLOW_LIGHT, global.C_YELLOW, global.C_BLACK];
global.PALETTE_YELLOW = [global.C_YELLOW_LIGHT, global.C_YELLOW, global.C_YELLOW_DARK, global.C_BLACK];
global.PALETTE_WOOD = [global.C_YELLOW, global.C_YELLOW_DARK, global.C_BROWN_DARK, global.C_BLACK];
global.PALETTE_BLUE = [global.C_BLUE_LIGHT, global.C_BLUE, global.C_BLUE_DARK, global.C_BLACK];
global.PALETTE_DARK_BLUE = [global.C_BLUE, global.C_BLUE_DARK, global.C_BLACK, global.C_BLACK];
global.PALETTE_RED = [global.C_RED_LIGHT, global.C_RED, global.C_RED_DARK, global.C_BLACK];

function color_uniform_values(_color) {
	return [color_get_red(_color)/255, color_get_green(_color)/255, color_get_blue(_color)/255, 1];
}

function palette_uniform_values(_palette) {
	var _uniform_values = array_concat(
		color_uniform_values(_palette[0]),
		color_uniform_values(_palette[1]),
		color_uniform_values(_palette[2]),
		color_uniform_values(_palette[3]),
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