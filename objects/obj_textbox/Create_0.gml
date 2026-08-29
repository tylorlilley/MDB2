#macro TEXTBOX_TRANSITION_TIME 4

max_width = SCREEN_WIDTH - GRID_SIZE * 2;
max_height = GRID_SIZE * 6;
origin_x = SCREEN_MIDDLE_X;
origin_y = SCREEN_MIDDLE_Y;
should_dim_screen = false;
depth = global.controller.depth - 1;
font = ft_pixel;
text_string = "";

progress = 0;
is_opening = false;

is_fully_open = function() { return (progress >= 1); }
is_fully_closed = function() { return (progress <= 0); }
get_current_width = function() { return progress * max_width; }
get_current_height = function() { return progress * max_height; }

// Functions
draw_screen_dim = function(_max_alpha = 0.8) {
	if (progress <= 0) { return; }

	draw_set_color(C_BLACK);
	draw_set_alpha(_max_alpha * progress);
	draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false);
	draw_set_alpha(1);
}

draw_text_box = function() {
	if (progress <= 0) { return; }

	var _width = get_width(), _height = get_height();
	var _left = origin_x - (_width / 2);
	var _top = (anchor == TEXT_BOX_ANCHORS.TOP) ? origin_y : origin_y - (_height / 2);

	draw_set_alpha(1);
	draw_set_color(C_BLACK);
	draw_rectangle(_left, _top, _left + _w, _top + _h, false);

	if (progress < 1 || string_length(text_string) == 0) { return; }

	draw_set_color(C_WHITE);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(font);
	draw_text_ext(origin_x, _top + (_h / 2), text_string, 12, _w - GRID_SIZE);
}