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
	TWELVE,
	THIRTEEN
}

#macro C_WHITE          make_color_rgb(239, 239, 239)
#macro C_GRAY_LIGHT     make_color_rgb(175, 175, 175)
#macro C_METAL_GRAY		make_color_rgb(132, 132, 132)
#macro C_GRAY           make_color_rgb(95, 95, 95)
#macro C_GRAY_DARK      make_color_rgb(71, 71, 71)
#macro C_NEAR_BLACK     make_color_rgb(23, 23, 23)
#macro C_BLACK          make_color_rgb(0, 0, 0)

#macro C_SAND_LIGHT     make_color_rgb(241, 226, 175)
#macro C_SAND           make_color_rgb(222, 202, 131)
#macro C_SAND_DARK      make_color_rgb(197, 167, 31)
#macro C_SAND_DARKEST     make_color_rgb(146, 126, 35)

#macro C_YELLOW_LIGHT   make_color_rgb(247, 231, 151)
#macro C_YELLOW         make_color_rgb(240, 188, 60)
#macro C_YELLOW_DARK    make_color_rgb(136, 112, 0)
#macro C_YELLOW_DARKEST make_color_rgb(64, 44, 0)

#macro C_DIRT_BORDER	make_color_rgb(95, 76, 34)
#macro C_BROWN_LIGHT    C_YELLOW
#macro C_BROWN          C_YELLOW_DARK
#macro C_BROWN_DARK     C_YELLOW_DARKEST
#macro C_BROWN_DARKEST  make_color_rgb(28, 23, 10)

#macro C_MARBLE			make_color_rgb(197, 190, 171)
#macro C_ROCK_BORDER	make_color_rgb(74, 70, 55)
#macro C_ROCK_LIGHT     make_color_rgb(172, 160, 128)
#macro C_ROCK           make_color_rgb(99, 95, 77)
#macro C_ROCK_DARK      make_color_rgb(57, 54, 40)

#macro C_MAGENTA_LIGHT  make_color_rgb(183, 152, 165)
#macro C_MAGENTA		make_color_rgb(113, 72, 90)
#macro C_MAGENTA_DARK   make_color_rgb(51, 35, 42)

#macro C_SOOT_LIGHT    make_color_rgb(94, 90, 101)
#macro C_SOOT          make_color_rgb(74, 71, 80)
#macro C_SOOT_DARK     make_color_rgb(51, 49, 57)

#macro C_SOIL_LIGHT    make_color_rgb(154, 151, 109)
#macro C_SOIL          make_color_rgb(127, 124, 89)
#macro C_SOIL_DARK     make_color_rgb(94, 92, 66)

#macro C_TRASH_LIGHT    make_color_rgb(141, 156, 100)
#macro C_TRASH          make_color_rgb(103, 116, 71)
#macro C_TRASH_DARK     make_color_rgb(75, 81, 60)
#macro C_TRASH_DARKER   make_color_rgb(58, 66, 36)
#macro C_TRASH_DARKEST  make_color_rgb(34, 38, 25)

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
#macro C_RED_LIGHT      make_color_rgb(222, 116, 105) //make_color_rgb(255, 199, 207)

#macro C_BRICK_DARKEST    make_color_rgb(39, 9, 7)
#macro C_BRICK_DARK       make_color_rgb(77, 37, 31)
#macro C_BRICK            make_color_rgb(160, 67, 53)
#macro C_BRICK_LIGHT      make_color_rgb(214, 121, 106)

#macro C_GREEN_DARKEST  make_color_rgb(0, 71, 0)
#macro C_GREEN_DARK     make_color_rgb(23, 135, 0)
#macro C_GREEN          make_color_rgb(31, 207, 47)
#macro C_GREEN_LIGHT    make_color_rgb(175, 255, 151)

#macro C_PINK_DARKEST       make_color_rgb(97, 9, 33)
#macro C_PINK_DARK       make_color_rgb(143, 0, 39)
#macro C_PINK           make_color_rgb(215, 0, 87) //make_color_rgb(175, 7, 207)
#macro C_PINK_LIGHT      make_color_rgb(255, 87, 159)

#macro C_PURPLE_DARKEST       make_color_rgb(94, 29, 130)
#macro C_PURPLE_DARK       make_color_rgb(127, 0, 199)
#macro C_PURPLE            make_color_rgb(175, 7, 207)
#macro C_PURPLE_LIGHT      make_color_rgb(199, 95, 255)

#macro C_INDIGO_DARKEST      make_color_rgb(51, 15, 105)
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
	PURPLE_DARK,
	INDIGO_LIGHT,
	INDIGO,
	INDIGO_DARK,
	PINK_LIGHT,
	PINK,
	PINK_DARK,
	BRICK,
	BRICK_DARK,
	BRICK_DARKEST,
	ROCK,
	ROCK_DARK,
	MAGENTA,
	MAGENTA_DARK,
	SAND_LIGHT,
	SAND,
	SAND_DARK,
	SOIL_LIGHT,
	SOIL,
	SOOT_LIGHT,
	SOOT,
	TRASH_LIGHT,
	TRASH,
	TRASH_DARK,
	TRASH_DARKEST,
	COTTON_CANDY_LIGHT,
	COTTON_CANDY,
	// No Sand Dark
	// No Brown Light
	BROWN,
	BROWN_DARK,
	BROWN_DARKEST,
	BACKGROUND_DIRT,
	BACKGROUND_ROCK,
	PLAYER,
	METAL,
	MARBLE
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
		[C_WHITE, C_PURPLE_LIGHT, C_PURPLE, C_PURPLE_DARK, C_PURPLE_DARKEST],
		[C_WHITE, C_INDIGO_LIGHT, C_INDIGO, C_INDIGO_DARK, C_INDIGO_DARKEST],
		[C_WHITE, C_PINK_LIGHT, C_PINK, C_PINK_DARK, C_PINK_DARKEST],
		[C_BRICK_LIGHT, C_BRICK, C_BRICK_DARK, C_NEAR_BLACK, C_BLACK],
		[C_ROCK_LIGHT, C_ROCK, C_ROCK_DARK, C_NEAR_BLACK],
		[C_MAGENTA_LIGHT, C_MAGENTA, C_MAGENTA_DARK, C_NEAR_BLACK],
		[C_WHITE, C_SAND_LIGHT, C_SAND, C_SAND_DARK, C_SAND_DARKEST],
		[C_WHITE, C_SOIL_LIGHT, C_SOIL, C_SOIL_DARK],
		[C_WHITE, C_SOOT_LIGHT, C_SOOT, C_SOOT_DARK],
		[C_WHITE, C_TRASH_LIGHT, C_TRASH, C_TRASH_DARK, C_TRASH_DARKER, C_TRASH_DARKEST],
		[C_WHITE, C_COTTON_CANDY_LIGHT, C_COTTON_CANDY, C_COTTON_CANDY_DARK],
		[C_BROWN_LIGHT, C_BROWN, C_BROWN_DARK, C_BROWN_DARKEST, C_BLACK],
		[C_DIRT_BORDER, C_BROWN_DARK, C_BROWN_DARKEST],
		[C_ROCK_BORDER, C_ROCK_DARK, C_NEAR_BLACK],
		[C_WHITE, C_BLUE_PLAYER_LIGHT, C_BLUE_PLAYER],
		[C_METAL_GRAY, C_GRAY, C_GRAY_DARK],
		[C_WHITE, C_MARBLE, C_ROCK_LIGHT],
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

function translate_uniform_values_to_color(_palette, _color_index) {
	var _uniform_values = global.palette_uniform_values[_palette], _index = (_color_index * 4);
	return make_color_rgb(_uniform_values[_index]*255, _uniform_values[_index + 1]*255, _uniform_values[_index + 2]*255);
}

function translate_palette_to_uniform_values(_palette) {
	return array_concat(
		translate_color_to_uniform_values(_palette[0]),
		translate_color_to_uniform_values(_palette[1]),
		translate_color_to_uniform_values(_palette[2]),
		translate_color_to_uniform_values(_palette[3])
	);
}

global.switch_type_palettes = [PALETTES.RED, PALETTES.BLUE, PALETTES.YELLOW];
function get_switch_palette(_switch_color) {
	return global.switch_type_palettes[_switch_color];
}

global.portal_color_palettes = [
	PALETTES.BLUE,
	PALETTES.PURPLE,
	PALETTES.INDIGO,
	PALETTES.PURPLE_DARK,
	PALETTES.PINK,
	PALETTES.BLUE_LIGHT,
	PALETTES.MAGENTA,
	PALETTES.SAND,
	PALETTES.GREEN_DARK,
	PALETTES.YELLOW_DARK,
	PALETTES.RED,
	PALETTES.YELLOW,
	PALETTES.ROCK,
	PALETTES.TRASH_LIGHT
];
function get_portal_palette(_portal_color) {
	if (_portal_color >= array_length(global.portal_color_palettes)) { return PALETTES.GRAY_LIGHT; }

	return global.portal_color_palettes[_portal_color];
}

function get_darker_palette(_palette_index) {
	if (_palette_index >= PALETTES.PLAYER) { return PALETTES.BLUE_DARKEST; }
	return _palette_index+1;
}

function get_lighter_palette(_palette_index) {
	if (_palette_index <= 0) { return 0; }
	return _palette_index-1;
}