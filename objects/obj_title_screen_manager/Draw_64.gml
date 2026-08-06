draw_set_color(C_BLACK);
draw_set_font(ft_title);
draw_set_halign(fa_center);
draw_set_valign(fa_top);


var _view_x_pos = camera_get_view_x(view_camera[0]), _view_y_pos = camera_get_view_y(view_camera[0]);
var _selected_color = ((transition_timer div 4) % 2 == 0) ? C_RED : C_WHITE, _title_y_pos = 8;
draw_text_outlined(SCREEN_MIDDLE_X, _title_y_pos, "MIGHTY\nDIVE BOMBER", _selected_color);

if (state > TITLE_STATES.PAN_OVER) {
	draw_set_font(ft_block_blueprint);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var _option_strings = [
		 "START CLASSIC GAME",
		 "START NEW GAME",
		 "CONTINUE GAME",
		 "VIEW CONTROLS",
		 "SETTINGS",
	]
	for (var _i = 0; _i < array_length(_option_strings); _i++) {
		//if (i == 0) { continue; } // TODO: Unlock Option After Beating Game
		var _y_offset = _i * 16, _option_string = _option_strings[_i];
		draw_text_outlined(SCREEN_MIDDLE_X-16, SCREEN_MIDDLE_Y+_y_offset, "START NEW GAME", ((menu_pos == _i) ? _selected_color : C_GRAY_LIGHT));
	}
}