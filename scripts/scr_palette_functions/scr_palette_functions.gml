enum SWITCH_COLORS {
	RED,
	BLUE,
	YELLOW
}

#macro C_WHITE          make_color_rgb(239, 239, 239)
#macro C_GRAY_LIGHT     make_color_rgb(175, 175, 175)
#macro C_GRAY           make_color_rgb(95, 95, 95)
#macro C_GRAY_DARK      make_color_rgb(71, 71, 71)
#macro C_NEAR_BLACK     make_color_rgb(23, 23, 23)
#macro C_BLACK          make_color_rgb(0, 0, 0)

#macro C_SAND_LIGHT     make_color_rgb(241, 226, 175)
#macro C_SAND           make_color_rgb(222, 202, 131)
#macro C_SAND_DARK      make_color_rgb(197, 167, 31)

#macro C_YELLOW_LIGHT   make_color_rgb(247, 231, 151)
#macro C_YELLOW         make_color_rgb(240, 188, 60)
#macro C_YELLOW_DARK    make_color_rgb(136, 112, 0)
#macro C_YELLOW_DARKEST make_color_rgb(64, 44, 0)

#macro C_BROWN_LIGHT    C_YELLOW
#macro C_BROWN          C_YELLOW_DARK
#macro C_BROWN_DARK     C_YELLOW_DARKEST

#macro C_BLUE_DARKEST   make_color_rgb(15, 0, 191)
#macro C_BLUE_DARK      make_color_rgb(0, 87, 247)
#macro C_BLUE           make_color_rgb(39, 159, 255)
#macro C_BLUE_LIGHT     make_color_rgb(175, 207, 255)

#macro C_RED_DARK       make_color_rgb(143, 6, 0)
#macro C_RED            make_color_rgb(223, 23, 0)
#macro C_RED_LIGHT      make_color_rgb(255, 199, 207)

#macro C_GREEN_DARKEST  make_color_rgb(0, 71, 0)
#macro C_GREEN_DARK     make_color_rgb(23, 135, 0)
#macro C_GREEN          make_color_rgb(31, 207, 47)
#macro C_GREEN_LIGHT    make_color_rgb(175, 255, 151)

#macro C_PINK           make_color_rgb(175, 7, 207)

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
	GREEN,
	GREEN_DARK,
	SAND,
	SAND_DARK,
	BROWN,
	BROWN_DARK,
	PLAYER,
	PORTAL,
	PORTAL_DARK
}

function palettes_init() {
	global.palette_values = [
		[C_WHITE, C_WHITE, C_WHITE, C_WHITE],
		[C_WHITE, C_GRAY_LIGHT, C_GRAY, C_BLACK],
		[C_GRAY_LIGHT, C_GRAY, C_GRAY_DARK, C_BLACK],
		[C_GRAY, C_GRAY_DARK, C_NEAR_BLACK, C_BLACK],
		[C_YELLOW_LIGHT, C_YELLOW, C_YELLOW_DARK, C_BLACK],
		[C_YELLOW, C_YELLOW_DARK, C_BROWN_DARK, C_BLACK],
		[C_YELLOW_DARK, C_BROWN_DARK, C_BLACK, C_BLACK],
		[C_BLUE_LIGHT, C_BLUE, C_BLUE_DARK, C_BLACK],
		[C_BLUE, C_BLUE_DARK, C_BLUE_DARKEST, C_BLACK],
		[C_BLUE_DARK, C_BLUE_DARKEST, C_BLACK, C_BLACK],
		[C_RED_LIGHT, C_RED, C_RED_DARK, C_BLACK],
		[C_RED, C_RED_DARK, C_BLACK, C_BLACK],
		[C_GREEN_LIGHT, C_GREEN, C_GREEN_DARK, C_BLACK],
		[C_GREEN, C_GREEN_DARK, C_GREEN_DARKEST, C_BLACK],
		[C_SAND_LIGHT, C_SAND, C_SAND_DARK, C_BLACK],
		[C_SAND, C_SAND_DARK, C_BLACK, C_BLACK],
		[C_BROWN_LIGHT, C_BROWN, C_BROWN_DARK, C_BLACK],
		[C_BROWN, C_BROWN_DARK, C_BLACK, C_BLACK],
		[C_WHITE, C_BLUE, C_BLUE_DARKEST, C_BLACK],
		[C_PINK, C_BLUE, C_BLUE_DARKEST, C_BLACK],
		[C_BLUE, C_BLUE_DARKEST, C_BLACK, C_BLACK]
	];

	global.palette_uniform_values = array_create(array_length(global.palette_values));
	for (var _i = 0; _i < array_length(global.palette_values); _i++) {
	   global.palette_uniform_values[_i] = translate_palette_to_uniform_values(global.palette_values[_i]);
	}
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
	if (_palette_index == PALETTES.PLAYER) { return PALETTES.BLUE_DARKER; }
	return _palette_index+1;
}

