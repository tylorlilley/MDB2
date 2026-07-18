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
global.C_YELLOW_DARKEST = make_color_rgb(64, 44, 0); // make_color_rgb(135, 103, 0);

global.C_BROWN_LIGHT = global.C_YELLOW;
global.C_BROWN = global.C_YELLOW_DARK;
global.C_BROWN_DARK = global.C_YELLOW_DARKEST; // make_color_rgb(71, 63, 0);

global.C_BLUE_DARKEST = make_color_rgb(15, 0, 191);
global.C_BLUE_DARK = make_color_rgb(0, 87, 247);
global.C_BLUE = make_color_rgb(39, 159, 255);
global.C_BLUE_LIGHT = make_color_rgb(175, 207, 255);

global.C_RED_DARK = make_color_rgb(143, 6, 0);
global.C_RED = make_color_rgb(223, 23, 0);
global.C_RED_LIGHT = make_color_rgb(255, 199, 207);

enum PALETTES {
	ALL_WHITE,
	GRAY,
	GRAY_DARK,
	ALL_BLACK,
	YELLOW,
	YELLOW_DARK,
	YELLOW_DARKER,
	BLUE,
	BLUE_DARK,
	BLUE_DARKER,
	RED,
	RED_DARK,
	SAND,
	SAND_DARK,
	BROWN,
	BROWN_DARK,
	PLAYER,
}

global.palette_values = [
	[global.C_WHITE, global.C_WHITE, global.C_WHITE, global.C_WHITE],
	[global.C_WHITE, global.C_GRAY_LIGHT, global.C_GRAY, global.C_BLACK],
	[global.C_GRAY_LIGHT, global.C_GRAY, global.C_GRAY_DARK, global.C_BLACK],
	[global.C_GRAY, global.C_GRAY_DARK, global.C_BLACK, global.C_BLACK],
	[global.C_YELLOW_LIGHT, global.C_YELLOW, global.C_YELLOW_DARK, global.C_BLACK],
	[global.C_YELLOW, global.C_YELLOW_DARK, global.C_BROWN_DARK, global.C_BLACK],
	[global.C_YELLOW_DARK, global.C_BROWN_DARK, global.C_BLACK, global.C_BLACK],
	[global.C_BLUE_LIGHT, global.C_BLUE, global.C_BLUE_DARK, global.C_BLACK],
	[global.C_BLUE, global.C_BLUE_DARK, global.C_BLUE_DARKEST, global.C_BLACK],
	[global.C_BLUE_DARK, global.C_BLUE_DARKEST, global.C_BLACK, global.C_BLACK],
	[global.C_RED_LIGHT, global.C_RED, global.C_RED_DARK, global.C_BLACK],
	[global.C_RED, global.C_RED_DARK, global.C_BLACK, global.C_BLACK],
	[global.C_SAND_LIGHT, global.C_SAND, global.C_SAND_DARK, global.C_BLACK],
	[global.C_SAND, global.C_SAND_DARK, global.C_BLACK, global.C_BLACK],
	[global.C_BROWN_LIGHT, global.C_BROWN, global.C_BROWN_DARK, global.C_BLACK],
	[global.C_BROWN, global.C_BROWN_DARK, global.C_BLACK, global.C_BLACK],
	[global.C_WHITE, global.C_BLUE, global.C_BLUE_DARKEST, global.C_BLACK]
];

global.palette_uniform_values = array_create(array_length(global.palette_values));
for (var _i = 0; _i < array_length(global.palette_values); _i++) {
    global.palette_uniform_values[_i] = translate_palette_to_uniform_values(global.palette_values[_i]);
}

function translate_color_to_uniform_values(_color) {
	return [color_get_red(_color)/255, color_get_green(_color)/255, color_get_blue(_color)/255, 1];
}

function translate_palette_to_uniform_values(_palette) {
	return array_concat(
		translate_color_to_uniform_values(_palette[0]),
		translate_color_to_uniform_values(_palette[1]),
		translate_color_to_uniform_values(_palette[2]),
		translate_color_to_uniform_values(_palette[3])
	);
}

function get_switch_palette(_switch_color) {
	switch (_switch_color) {
		case SWITCH_COLORS.RED: { return PALETTES.RED; }
		case SWITCH_COLORS.BLUE: { return PALETTES.BLUE; }
		case SWITCH_COLORS.YELLOW: { return PALETTES.YELLOW; }
	}
}

function get_darker_palette(_palette_index) {
	switch (_palette_index) {
		case PALETTES.ALL_WHITE: { return PALETTES.GRAY; }
		case PALETTES.GRAY: { return PALETTES.GRAY_DARK; }
		case PALETTES.GRAY_DARK: { return PALETTES.ALL_BLACK; }
		case PALETTES.YELLOW: { return PALETTES.YELLOW_DARK; }
		case PALETTES.YELLOW_DARK: { return PALETTES.YELLOW_DARKER; }
		case PALETTES.PLAYER:
		case PALETTES.BLUE: { return PALETTES.BLUE_DARK; }
		case PALETTES.BLUE_DARK: { return PALETTES.BLUE_DARKER; }
		case PALETTES.RED: { return PALETTES.RED_DARK; }
		case PALETTES.SAND: { return PALETTES.SAND_DARK; }
		case PALETTES.BROWN: { return PALETTES.BROWN_DARK; }
		default: { return PALETTES.ALL_BLACK; }
	}
}
