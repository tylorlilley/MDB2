event_inherited();

// Make Player Ignore Controls
with (obj_player) {
	is_left = false;
	if (transition_timer == 0) { transition_timer = 4; }
	sprite_index = spr_player_walk;
	image_index = 1;
	if (cape_state != CAPE_STATES.FLUTTER) { start_cape_flutter(); }
}

// Update Timers
cursor_sway_timer++;
if (cursor_sway_timer > 32) { cursor_sway_timer = -(irandom(60) + 60); }
title_sway_timer = (title_sway_timer + 1) % 24;
if (text_shake_timer > 0) { text_shake_timer--; }

// Tackle Input in Different States
prev_state = state;
switch (state) {
	case TITLE_STATES.BEGIN: {
		if (key_up || key_down ||  key_left || key_right || key_jump || key_restart) { play_sound(snd_key); state = TITLE_STATES.PAN_OVER; }

		break;
	}
	case TITLE_STATES.PAN_OVER: {
		var _view_y_pos = camera_get_view_y(view_camera[0]), _target_x_pos = 74;
		if (camera_x >= _target_x_pos) {
			if (bounce_count >= 3) { state = TITLE_STATES.MAIN_MENU; play_sound(snd_explosion); cursor_sway_timer = 0; }
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
		if (text_shake_timer == 0) {
			var _prev_menu_pos = menu_pos, _skip_continue = (saved_room == noone), _menu_change = 0;
			var _min_menu_pos = (progress_level == 0) ? 1 : 0, _max_menu_pos = 4;
			if (key_up && !key_down) { _menu_change = -1; }
			else if (key_down && ! key_up) { _menu_change = 1; }
			menu_pos += _menu_change;
			if (menu_pos == 2 && _skip_continue) { menu_pos += _menu_change; }
			if (menu_pos > _max_menu_pos || menu_pos < _min_menu_pos) { 
				menu_pos = clamp(menu_pos, _min_menu_pos, _max_menu_pos);
				audio_play_sound(snd_solid_invulnerable, 2, false);
			}
			if (menu_pos != _prev_menu_pos) {
				audio_play_sound(snd_player_ladder_step, 2, false);
				text_shake_timer = 8;
				cursor_sway_timer = 0;
			}
		}
		
		// Make Menu Selection
		var _next_level = (menu_pos == 0) ? rm_old_w1_1 : rm_mdb_1_1;
		if (menu_pos == 2) { _next_level = saved_room; }
		
		if (global.controller.transition_timer == 0 && (key_jump || key_restart)) {
			switch (menu_pos) {
				case 0:
				case 1:
				case 2: {
					// Go To Next Room
					with (obj_player) {
						global.controller.x = x;
						global.controller.y = y;
					}
					global.controller.target_room = _next_level;
					global.controller.transition_timer = TRANSITION_DELAY-1;
					if (menu_pos == 0) { global.controller.classic_levels = true; }
					if (menu_pos == 2) { global.controller.level_number = level_number; }
					audio_stop_sound(bgm_title);
					
					break;
				}
			}
		}
	}
}