with (obj_player) {
	update_controls();
	other.key_right = key_right;
	other.key_left = key_left;
	other.key_up = key_up;
	other.key_down = key_down;
	other.key_jump = key_jump;
	other.key_restart = key_restart;
}

event_inherited();
audio_stop_sound(bgm_transition);

with (obj_player) {
	reset_controls();
	sprite_index = spr_player_walk;
	image_index = 1;
	if (cape_state != CAPE_STATES.FLUTTER) { start_cape_flutter(); }
}

// Tackle Input
switch (state) {
	case TITLE_STATES.BEGIN: {
		if (key_up || key_down ||  key_left || key_right || key_jump || key_restart) { state = TITLE_STATES.PAN_OVER; }
		break;
	}
	case TITLE_STATES.PAN_OVER: {
		var _view_x_pos = camera_get_view_x(view_camera[0]), _view_y_pos = camera_get_view_y(view_camera[0]);
		var _bounce_offset = (3-bounce_count) * 2;
		if (_view_x_pos >= 72 && bounce_count >= 3) { states = TITLE_STATES.MAIN_MENU; }
		else {
			if (_view_x_pos >= 74) {
				camera_speed = -_bounce_offset;
				bounce_count += 1;
			}
			else {
				camera_speed = min(camera_speed+1, 8);
			}
			camera_set_view_pos(view_camera[0], _view_x_pos + _bounce_offset, _view_y_pos);
		}
	
		break;
	}
	case TITLE_STATES.MAIN_MENU: {
		// TODO
	}
}