enum SWITCH_COLORS {
	RED,
	BLUE,
	YELLOW
}

global.C_WHITE = color_uniform_values(make_colour_rgb(239, 239, 239));
global.C_GRAY_LIGHT = color_uniform_values(make_colour_rgb(175, 175, 175));
global.C_GRAY = color_uniform_values(make_colour_rgb(95, 95, 95));
global.C_GRAY_DARK = color_uniform_values(make_colour_rgb(71, 71, 71));
global.C_NEAR_BLACK = color_uniform_values(make_colour_rgb(23, 23, 23));
global.C_BLACK = color_uniform_values(make_colour_rgb(0, 0, 0));

global.GML_YELLOW = make_colour_rgb(207, 167, 0);
global.C_YELLOW_LIGHT = color_uniform_values(make_colour_rgb(247, 231, 151));
global.C_YELLOW = color_uniform_values(global.GML_YELLOW);
global.C_YELLOW_DARK = color_uniform_values(make_colour_rgb(135, 103, 0));

global.GML_BLUE = make_colour_rgb(39, 159, 255);
global.C_BLUE_DARK = color_uniform_values(make_colour_rgb(0, 87, 247));
global.C_BLUE = color_uniform_values(global.GML_BLUE);
global.C_BLUE_LIGHT = color_uniform_values(make_colour_rgb(175, 207, 255));

global.GML_RED = make_colour_rgb(223, 23, 0);
global.C_RED_DARK = color_uniform_values(make_colour_rgb(143, 6, 0));
global.C_RED = color_uniform_values(global.GML_RED);
global.C_RED_LIGHT = color_uniform_values(make_colour_rgb(255, 199, 207));

global.ALL_WHITE_PALETTE = array_concat(C_WHITE, C_WHITE, C_WHITE, C_WHITE);
global.GRAYSCALE_PALETTE = array_concat(C_WHITE, C_GRAY_LIGHT, C_GRAY, C_BLACK);

global.YELLOW_BLOCK_PALETTE = array_concat(C_YELLOW_LIGHT, C_YELLOW, C_YELLOW_DARK, C_BLACK);
global.BLUE_BLOCK_PALETTE = array_concat(C_BLUE_LIGHT, C_BLUE, C_BLUE_DARK, C_BLACK);
global.RED_BLOCK_PALETTE = array_concat(C_RED_LIGHT, C_RED, C_RED_DARK, C_BLACK);

function color_uniform_values(_color) {
	return [color_get_red(_color)/255, color_get_green(_color)/255, color_get_blue(_color)/255, 1];
}

function get_switch_palette(_switch_color) {
	switch (_switch_color) {
		case SWITCH_COLORS.RED: { return global.RED_BLOCK_PALETTE; }
		case SWITCH_COLORS.BLUE: { return global.BLUE_BLOCK_PALETTE; }
		case SWITCH_COLORS.YELLOW: { return global.YELLOW_BLOCK_PALETTE; }
	}
}

function get_switch_color(_switch_color) {
	switch (_switch_color) {
		case SWITCH_COLORS.RED: { return global.GML_RED; }
		case SWITCH_COLORS.BLUE: { return global.GML_BLUE; }
		case SWITCH_COLORS.YELLOW: { return global.GML_YELLOW; }
	}
}