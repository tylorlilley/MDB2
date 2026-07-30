enum SWITCH_COLORS {
	RED,
	BLUE,
	YELLOW
}

enum PORTAL_COLORS {
	ONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	ELEVEN,
	TWELVE
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

#macro C_ROCK_LIGHT    make_color_rgb(204, 187, 143)
#macro C_ROCK          make_color_rgb(117, 111, 84)
#macro C_ROCK_DARK     make_color_rgb(51, 35, 42)

#macro C_SOOT_LIGHT    make_color_rgb(94, 90, 101)
#macro C_SOOT          make_color_rgb(74, 71, 80)
#macro C_SOOT_DARK     make_color_rgb(51, 49, 57)

#macro C_SOIL_LIGHT    make_color_rgb(142, 137, 76)
#macro C_SOIL          make_color_rgb(114, 111, 66)
#macro C_SOIL_DARK     make_color_rgb(88, 92, 61)

#macro C_TRASH_LIGHT    make_color_rgb(128, 143, 88)
#macro C_TRASH          make_color_rgb(103, 116, 71)
#macro C_TRASH_DARK     make_color_rgb(75, 81, 60)

#macro C_COTTON_CANDY_LIGHT    make_color_rgb(215, 146, 212)
#macro C_COTTON_CANDY         make_color_rgb(178, 121, 175)
#macro C_COTTON_CANDY_DARK     make_color_rgb(137, 91, 135)

#macro C_BLUE_PLAYER    make_color_rgb(18, 75, 186)
#macro C_BLUE_PLAYER_LIGHT    make_color_rgb(65, 168, 251)
#macro C_BLUE_DARKEST   make_color_rgb(15, 0, 191)
#macro C_BLUE_DARK      make_color_rgb(0, 87, 247)
#macro C_BLUE           make_color_rgb(39, 159, 255)
#macro C_BLUE_LIGHT     make_color_rgb(175, 207, 255)

#macro C_RED_DARKEST    make_color_rgb(73, 6, 0)
#macro C_RED_DARK       make_color_rgb(143, 6, 0)
#macro C_RED            make_color_rgb(223, 23, 0)
#macro C_RED_LIGHT      make_color_rgb(255, 199, 207)

#macro C_BRICK_DARKEST    make_color_rgb(57, 36, 32)
#macro C_BRICK_DARK       make_color_rgb(82, 41, 35)
#macro C_BRICK            make_color_rgb(175, 80, 65)
#macro C_BRICK_LIGHT      make_color_rgb(220, 123, 108)

#macro C_GREEN_DARKEST  make_color_rgb(0, 71, 0)
#macro C_GREEN_DARK     make_color_rgb(23, 135, 0)
#macro C_GREEN          make_color_rgb(31, 207, 47)
#macro C_GREEN_LIGHT    make_color_rgb(175, 255, 151)

#macro C_PINK_DARK       make_color_rgb(143, 0, 39)
#macro C_PINK           make_color_rgb(215, 0, 87) //make_color_rgb(175, 7, 207)
#macro C_PINK_LIGHT      make_color_rgb(255, 87, 159)

#macro C_PURPLE_DARK       make_color_rgb(127, 0, 199)
#macro C_PURPLE            make_color_rgb(175, 7, 207)
#macro C_PURPLE_LIGHT      make_color_rgb(199, 95, 255)

#macro C_INDIGO_DARK       make_color_rgb(67, 0, 167)
#macro C_INDIGO          make_color_rgb(103, 31, 247)
#macro C_INDIGO_LIGHT      make_color_rgb(135, 111, 255)

enum PALETTES {
	ALL_WHITE,
	ALL_BLACK,
	GRAY_LIGHT,
	GRAY,
	GRAY_DARK,
	YELLOW_LIGHT,
	YELLOW,
	YELLOW_DARK,
	BLUE_LIGHT,
	BLUE,
	BLUE_DARK,
	BLUE_DARKEST,
	GREEN_LIGHT,
	GREEN,
	GREEN_DARK,
	GREEN_DARKEST,
	RED_LIGHT,
	RED,
	RED_DARK,
	PURPLE_LIGHT,
	PURPLE,
	INDIGO_LIGHT,
	INDIGO,
	PINK_LIGHT,
	PINK,
	BRICK_LIGHT,
	BRICK,
	BRICK_DARK,
	ROCK_LIGHT,
	ROCK,
	SAND_LIGHT,
	SAND,
	SOIL_LIGHT,
	SOIL,
	SOOT_LIGHT,
	SOOT,
	TRASH_LIGHT,
	TRASH,
	COTTON_CANDY_LIGHT,
	COTTON_CANDY,
	// No Sand Dark
	// No Brown Light
	BROWN,
	BROWN_DARK,
	PLAYER,
}

function palettes_init() {
	var _full_palettes = [
		[C_WHITE, C_WHITE, C_WHITE],
		[C_BLACK, C_BLACK, C_BLACK],
		[C_WHITE, C_GRAY_LIGHT, C_GRAY, C_GRAY_DARK, C_NEAR_BLACK],
		[C_WHITE, C_YELLOW_LIGHT, C_YELLOW, C_YELLOW_DARK, C_YELLOW_DARKEST],
		[C_WHITE, C_BLUE_LIGHT, C_BLUE, C_BLUE_DARK, C_BLUE_DARKEST, C_BLACK],
		[C_WHITE, C_GREEN_LIGHT, C_GREEN, C_GREEN_DARK, C_GREEN_DARKEST, C_BLACK],
		[C_WHITE, C_RED_LIGHT, C_RED, C_RED_DARK, C_RED_DARKEST],
		[C_WHITE, C_PURPLE_LIGHT, C_PURPLE, C_PURPLE_DARK],
		[C_WHITE, C_INDIGO_LIGHT, C_INDIGO, C_INDIGO_DARK],
		[C_WHITE, C_PINK_LIGHT, C_PINK, C_PINK_DARK],
		[C_WHITE, C_BRICK_LIGHT, C_BRICK, C_BRICK_DARK, C_BRICK_DARKEST],
		[C_WHITE, C_ROCK_LIGHT, C_ROCK, C_ROCK_DARK],
		[C_WHITE, C_SAND_LIGHT, C_SAND, C_SAND_DARK],
		[C_WHITE, C_SOIL_LIGHT, C_SOIL, C_SOIL_DARK],
		[C_WHITE, C_SOOT_LIGHT, C_SOOT, C_SOOT_DARK],
		[C_WHITE, C_TRASH_LIGHT, C_TRASH, C_TRASH_DARK],
		[C_WHITE, C_COTTON_CANDY_LIGHT, C_COTTON_CANDY, C_COTTON_CANDY_DARK],
		[C_BROWN_LIGHT, C_BROWN, C_BROWN_DARK, C_BLACK],
		
		[C_WHITE, C_BLUE_PLAYER_LIGHT, C_BLUE_PLAYER],
	];
	
	global.palette_uniform_values = [];
	for (var _palette_number = 0; _palette_number < array_length(_full_palettes); _palette_number++) {
		var _full_palette_to_transform = _full_palettes[_palette_number];
		for (var _start_color_pos = 0; _start_color_pos < array_length(_full_palette_to_transform)-2; _start_color_pos++) {
			var _color_array = [C_BLACK, C_BLACK, C_BLACK, ((_palette_number == 0) ? C_WHITE : C_BLACK)];
			array_copy(_color_array, 0, _full_palette_to_transform, _start_color_pos, 3);
			array_push(global.palette_uniform_values, translate_palette_to_uniform_values(_color_array));
		}
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

function get_portal_palette(_portal_color) {
	switch (_portal_color) {
		case PORTAL_COLORS.ONE: { return PALETTES.BLUE; }
		case PORTAL_COLORS.TWO: { return PALETTES.INDIGO; }
		case PORTAL_COLORS.THREE: { return PALETTES.PURPLE; }
		case PORTAL_COLORS.FOUR: { return PALETTES.BLUE_DARK; }
		case PORTAL_COLORS.FIVE: { return PALETTES.PINK; }
		case PORTAL_COLORS.SIX: { return PALETTES.BLUE_LIGHT; }
		case PORTAL_COLORS.SEVEN: { return PALETTES.SAND; }
		case PORTAL_COLORS.EIGHT: { return PALETTES.GREEN_DARK; }
		case PORTAL_COLORS.NINE: { return PALETTES.YELLOW_DARK; }
		case PORTAL_COLORS.TEN: { return PALETTES.RED; }
		case PORTAL_COLORS.ELEVEN: { return PALETTES.YELLOW; }
		case PORTAL_COLORS.TWELVE: { return PALETTES.GRAY_LIGHT; }
	}
}

function get_darker_palette(_palette_index) {
	if (_palette_index >= PALETTES.PLAYER) { return PALETTES.BLUE_DARKEST; }
	return _palette_index+1;
}

function get_lighter_palette(_palette_index) {
	if (_palette_index <= 0) { return 0; }
	return _palette_index-1;
}