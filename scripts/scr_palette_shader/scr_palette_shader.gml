enum SWITCH_COLORS {
	RED,
	BLUE,
	YELLOW
}

#macro C_WHITE color_uniform_values(make_colour_rgb(239, 239, 239))
#macro C_GRAY_LIGHT color_uniform_values(make_colour_rgb(175, 175, 175))
#macro C_GRAY color_uniform_values(make_colour_rgb(95, 95, 95))
#macro C_GRAY_DARK color_uniform_values(make_colour_rgb(71, 71, 71))
#macro C_NEAR_BLACK color_uniform_values(make_colour_rgb(23, 23, 23))
#macro C_BLACK color_uniform_values(make_colour_rgb(0, 0, 0))

#macro C_YELLOW_LIGHT color_uniform_values(make_colour_rgb(247, 231, 151))
#macro C_YELLOW color_uniform_values(make_colour_rgb(207, 167, 0))
#macro C_YELLOW_DARK color_uniform_values(make_colour_rgb(135, 103, 0))

#macro C_BLUE_DARK color_uniform_values(make_colour_rgb(0, 87, 247))
#macro C_BLUE color_uniform_values(make_colour_rgb(39, 159, 255))
#macro C_BLUE_LIGHT color_uniform_values(make_colour_rgb(175, 207, 255))

#macro C_RED_DARK color_uniform_values(make_colour_rgb(143, 6, 0))
#macro C_RED color_uniform_values(make_colour_rgb(223, 23, 0))
#macro C_RED_LIGHT color_uniform_values(make_colour_rgb(255, 199, 207))

#macro ALL_WHITE_PALETTE array_concat(C_WHITE, C_WHITE, C_WHITE, C_WHITE)
#macro GRAYSCALE_PALETTE array_concat(C_WHITE, C_GRAY_LIGHT, C_GRAY, C_BLACK)

#macro YELLOW_BLOCK_PALETTE array_concat(C_YELLOW_LIGHT, C_YELLOW, C_YELLOW_DARK, C_BLACK)
#macro BLUE_BLOCK_PALETTE array_concat(C_BLUE_LIGHT, C_BLUE, C_BLUE_DARK, C_BLACK)
#macro RED_BLOCK_PALETTE array_concat(C_RED_LIGHT, C_RED, C_RED_DARK, C_BLACK)

function color_uniform_values(_color) {
	return [color_get_red(_color)/255, color_get_green(_color)/255, color_get_blue(_color)/255, 1];
}

function get_switch_palette(_switch_color) {
	switch (_switch_color) {
		case SWITCH_COLORS.RED: { return RED_BLOCK_PALETTE; }
		case SWITCH_COLORS.BLUE: { return BLUE_BLOCK_PALETTE; }
		case SWITCH_COLORS.YELLOW: { return YELLOW_BLOCK_PALETTE; }
	}
}