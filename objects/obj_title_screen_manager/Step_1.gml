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
	if (transition_timer == 0) { transition_timer = 4; }
	reset_controls();
	sprite_index = spr_player_walk;
	image_index = 1;
	if (cape_state != CAPE_STATES.FLUTTER) { start_cape_flutter(); }
}

// Tackle Input
switch (state) {
	case TITLE_STATES.BEGIN: {
		if (key_up || key_down ||  key_left || key_right || key_jump || key_restart) { play_sound(snd_key); state = TITLE_STATES.PAN_OVER; }
		break;
	}
	case TITLE_STATES.PAN_OVER: {
		var _view_y_pos = camera_get_view_y(view_camera[0]), _target_x_pos = 74;
		if (camera_x >= _target_x_pos) {
			if (bounce_count >= 3) { state = TITLE_STATES.MAIN_MENU; play_sound(snd_explosion); }
			else {
				var _bounce_speed = [4, 2, 1][bounce_count];
				camera_speed = -_bounce_speed;
				bounce_count += 1;
				play_sound(snd_soft_thud);
			}
		}
		else { camera_speed += 0.5 }
		
		camera_x += camera_speed;
		camera_set_view_pos(view_camera[0], camera_x, _view_y_pos);
	
		break;
	}
	case TITLE_STATES.MAIN_MENU: {
		// Update Menu Position
		_prev_menu_pos = menu_pos;
		if (key_up && !key_down) { menu_pos--; }
		else if (key_down && ! key_up) { menu_pos++; }	
		menu_pos = clamp(menu_pos, 0, 3);
		if (menu_pos != _prev_menu_pos) { audio_play_sound(snd_player_ladder_step, 2, false); }
	}
}