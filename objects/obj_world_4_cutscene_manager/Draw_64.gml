if (cutscene_timer == INTERRUPTION_FRAME) {
	draw_set_color(C_WHITE);
	draw_rectangle(0, 0, room_width, room_height, false);
}

var _text_box_width = SCREEN_WIDTH - GRID_SIZE * 2, _text_box_height = GRID_SIZE * 6;
var _text_box_x = SCREEN_MIDDLE_X - (_text_box_width/2), _text_box_y = GRID_SIZE;

if (text_pos_timer > FIRST_WAIT && text_pos_timer < next_text_trigger - TEXT_WAIT) {
	// Draw Textbox
	draw_set_color(C_BLACK);
	draw_rectangle(_text_box_x, _text_box_y, _text_box_x + _text_box_width ,  _text_box_y + _text_box_height, false);
	
	// Draw Text
	draw_set_color(C_WHITE);
	draw_set_font(ft_pixel);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var _text_box_text = actor_strings[actor] + ": " + text_box_strings[text_pos];
	draw_text_ext(SCREEN_MIDDLE_X, _text_box_y + (_text_box_height/2), _text_box_text, 12, _text_box_width - 8);
}