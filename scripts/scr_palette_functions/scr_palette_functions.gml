enum SWITCH_COLORS {
	RED,
	BLUE,
	YELLOW
}

#macro C_WHITE          $EFEFEF
#macro C_GRAY_LIGHT     $AFAFAF
#macro C_GRAY           $5F5F5F
#macro C_GRAY_DARK      $474747
#macro C_NEAR_BLACK     $171717
#macro C_BLACK          $000000

#macro C_SAND_LIGHT     $AFE2F1
#macro C_SAND           $83CADE
#macro C_SAND_DARK      $1FA7C5

#macro C_YELLOW_LIGHT   $97E7F7
#macro C_YELLOW         $3CBCF0
#macro C_YELLOW_DARK    $007088
#macro C_YELLOW_DARKEST $002C40

#macro C_BROWN_LIGHT    C_YELLOW
#macro C_BROWN          C_YELLOW_DARK
#macro C_BROWN_DARK     C_YELLOW_DARKEST

#macro C_BLUE_DARKEST   $BF000F
#macro C_BLUE_DARK      $F75700
#macro C_BLUE           $FF9F27
#macro C_BLUE_LIGHT     $FFCFAF

#macro C_RED_DARK       $00068F
#macro C_RED            $0017DF
#macro C_RED_LIGHT      $CFC7FF

#macro C_GREEN_DARKEST  $004700
#macro C_GREEN_DARK     $008717
#macro C_GREEN          $2FCF1F
#macro C_GREEN_LIGHT    $97FFAF
#macro C_PINK           $CF07AF

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

global.palette_uniform_values = array_create(array_length(palette_values));
for (var _i = 0; _i < array_length(palette_values); _i++) {
   global.palette_uniform_values[_i] = translate_palette_to_uniform_values(palette_values[_i]);
}
