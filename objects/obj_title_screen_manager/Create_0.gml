enum TITLE_STATES {
	BEGIN,
	PAN_OVER,
	MAIN_MENU
}

event_inherited();

depth = global.controller.depth + 1;
state = TITLE_STATES.BEGIN;
prev_state = state;
camera_x = camera_get_view_x(view_camera[0]);
camera_speed = 0;
bounce_count = 0;
menu_pos = 0;
text_shake_timer = 0;
title_sway_timer = irandom(23);
cursor_sway_timer = -(irandom(60) + 60);

key_right = false;
key_left = false;
key_up = false;
key_down = false;
key_jump = false;
key_restart = false;

draw_text_outlined = function(_x, _y, _text, _text_color = C_WHITE, _outline_color = C_BLACK) {
	draw_set_color(_outline_color);
	for (var _x_offset = -1; _x_offset < 2; _x_offset++) {
		for (var _y_offset = -1; _y_offset < 4; _y_offset++) {
			if (_x_offset == 0 && _y_offset == 0) { continue; }
			draw_text(_x + _x_offset, _y + _y_offset, _text);
		}
	}
	draw_set_color(_text_color);
	draw_text(_x, _y, _text);
}
