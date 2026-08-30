#macro TEXTBOX_TRANSITION_TIME 4

max_width = SCREEN_WIDTH - GRID_SIZE * 2;
max_height = GRID_SIZE * 6;
origin_y = SCREEN_MIDDLE_Y; // GRID_SIZE + (max_height/2)
origin_x = SCREEN_MIDDLE_X;

depth = global.controller.depth - 1;
font = ft_pixel;
text_string = "";
should_dim_screen = false;

progress = 0;
is_opening = true;

// Functions
draw_screen_dim = function(_max_alpha = 0.8) {
	if (!should_dim_screen || progress <= 0) { return; }

	matrix_set(matrix_world, matrix_build_identity());
	var _p = application_get_position();
	draw_set_color(C_BLACK);
	draw_set_alpha(_max_alpha * progress);
	draw_rectangle(-1, -1, SCREEN_WIDTH+2, SCREEN_HEIGHT+2, false);
	draw_set_alpha(1);
}
	
draw_text_box = function() {
	if (progress <= 0) { return; }

	var _width =  progress * max_width, _height = progress * max_height;
	var _left = origin_x - (_width / 2);
	var _top = origin_y - (_height / 2);

	draw_set_alpha(1);
	draw_set_color(C_BLACK);
	draw_rectangle(_left, _top, _left + _width, _top + _height, false);

	if (progress < 1 || string_length(text_string) == 0) { return; }

	draw_set_color(C_WHITE);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(font);
	draw_text_ext(origin_x, _top + (_height / 2), text_string, 12, _width - GRID_SIZE);
}