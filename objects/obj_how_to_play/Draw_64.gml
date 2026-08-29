draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Interpolate Text Box
var _max_text_box_width = SCREEN_WIDTH - GRID_SIZE * 2, _max_text_box_height = GRID_SIZE * 6;
var _displayed_string = text_box_strings[text_pos], _fps_ratio = global.controller.fps_ratio;
var _progress = clamp(text_box_transition_timer / (PAUSE_TRANSITION_TIME * _fps_ratio), 0, 1);
var _text_box_width = _progress * _max_text_box_width, _text_box_height = _progress * _max_text_box_height;
if (_progress < 1) { _displayed_string = ""; }
var _text_box_x = SCREEN_MIDDLE_X - (_text_box_width/2), _text_box_y = GRID_SIZE;

if (cutscene_timer > INTRO_WAIT && _progress > 0) {
	// Draw text_box
	draw_set_color(C_BLACK);
	draw_rectangle(_text_box_x, _text_box_y, _text_box_x + _text_box_width ,  _text_box_y + _text_box_height, false);
	
	// Draw Text
	draw_set_color(C_WHITE);
	draw_set_font(ft_pixel);
	draw_text(SCREEN_MIDDLE_X, _text_box_y + (_text_box_height/2), _displayed_string);
}
	
if (((cutscene_timer div 16) % 2) == 0) {
	draw_set_color(C_BLACK);
	draw_set_font(ft_pixel);

	draw_text_outlined(SCREEN_MIDDLE_X + 32, SCREEN_MIDDLE_Y + 104, cancel_string);
}

if (return_to_title) {
	draw_set_color(C_WHITE);
	draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false);
}

// set_shader_palette only takes effect inside the Draw GUI Begin/End shader bracket
set_shader_palette(PALETTES.GRAY_LIGHT);
draw_sprite(spr_controls_down, ((shown_key_down) ? 1 : 0), 4 + 16, SCREEN_HEIGHT - 4 - 16);
draw_sprite(spr_controls_up, ((shown_key_up) ? 1 : 0), 4 + 16, SCREEN_HEIGHT - 4 - 16 - 16);
draw_sprite(spr_controls_left, ((shown_key_left) ? 1 : 0), 4, SCREEN_HEIGHT - 4 - 8 - 16);
draw_sprite(spr_controls_right, ((shown_key_right) ? 1 : 0), 4 + 16 + 16, SCREEN_HEIGHT - 4 - 8 - 16);
