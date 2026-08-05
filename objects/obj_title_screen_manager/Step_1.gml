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
var _camera = view_get_camera(0);
switch (state) {
	case TITLE_STATES.BEGIN: {
		if (key_up || key_down ||  key_left || key_right || key_jump || key_restart) { state = TITLE_STATES.PAN_OVER; }
		break;
	}
	case TITLE_STATES.PAN_OVER: {
		if (camera_get_view_x(_camera) < 64) { states = TITLE_STATES.MAIN_MENU; }
		else {
			var _camera_speed = camera_get_view_speed_x(_camera);
			_camera_speed++;
			var _x_speed = min(_camera_speed, 8);
			camera_set_view_speed(_camera, _x_speed, 0);
		}
	
		break;
	}
	case TITLE_STATES.MAIN_MENU: {
		// TODO
	}
}