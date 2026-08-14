event_inherited();
// Poll for Gamepad
determine_gamepad();

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
	case TITLE_STATES.SETTINGS_MENU:
	case TITLE_STATES.MAIN_MENU: {
		// Update Menu Position
		if (text_shake_timer == 0) {
			var _prev_menu_pos = menu_pos, _skip_continue = (saved_room == -1), _menu_change = 0;
			var _min_menu_pos = (progress_level == 0) ? MENU_OPTIONS.START_GAME : MENU_OPTIONS.START_CLASSIC, _max_menu_pos = (state == TITLE_STATES.MAIN_MENU) ? MENU_OPTIONS.SETTINGS : SETTINGS_OPTIONS.RETURN;
			if (key_up && !key_down) { _menu_change = -1; }
			else if (key_down && ! key_up) { _menu_change = 1; }
			menu_pos += _menu_change;
			if (menu_pos == MENU_OPTIONS.LOAD_GAME && _skip_continue) { menu_pos += _menu_change; }
			if (menu_pos > _max_menu_pos || menu_pos < _min_menu_pos) { 
				menu_pos = clamp(menu_pos, _min_menu_pos, _max_menu_pos);
				if !(audio_is_playing(snd_solid_invulnerable)) { play_global_sound(snd_solid_invulnerable); } // TODO: // This fires constantly?
			}
			if (menu_pos != _prev_menu_pos) {
				play_global_sound(snd_player_ladder_step);
				text_shake_timer = 8;
				cursor_sway_timer = 0;
			}
		}
		
		// Make Menu Selection
		if (state == TITLE_STATES.MAIN_MENU) {
			var _next_level = (menu_pos == MENU_OPTIONS.START_CLASSIC) ? rm_old_w1_1 : rm_mdb_1_1;
			if (menu_pos == MENU_OPTIONS.LOAD_GAME) { _next_level = saved_room; }
			with (obj_player) { visible = (other.menu_pos > MENU_OPTIONS.START_GAME); }
		
			if (global.controller.transition_timer == 0 && (key_jump || key_restart)) {
				switch (menu_pos) {
					case MENU_OPTIONS.START_CLASSIC:
					case MENU_OPTIONS.START_GAME:
					case MENU_OPTIONS.LOAD_GAME: {
						// Go To Next Room
						with (obj_player) {
							global.controller.x = x;
							global.controller.y = y;
						}
						global.controller.target_room = _next_level;
						global.controller.transition_timer = TRANSITION_DELAY-1;
						if (menu_pos == MENU_OPTIONS.START_CLASSIC) { global.controller.classic_level = true; } // TODO: move this into room info array to fix loading to a classic level
						if (menu_pos == MENU_OPTIONS.LOAD_GAME) { global.controller.level_number = level_number; }
						stop_sound(bgm_title);
					
						break;
					}
					case MENU_OPTIONS.SETTINGS: {
						play_global_sound(snd_explosion);
						state = TITLE_STATES.SETTINGS_MENU;
						menu_pos = 0;
					
						break;
					}
				}
			}
		}
		else if (state == TITLE_STATES.SETTINGS_MENU) {
			var _menu_change = 0, _min_option_pos = 0, _current_option_pos = 0, _max_option_pos = 0;
			if (menu_pos == SETTINGS_OPTIONS.FULL_SCREEN) { _max_option_pos = FULL_SCREEN_OPTIONS.WINDOWED; _current_option_pos = full_screen_option; }
			else if (menu_pos == SETTINGS_OPTIONS.SCREEN_SCALE) { _max_option_pos = max_scaling_size; _current_option_pos = screen_scale_option; }
			var _prev_menu_pos = _current_option_pos;
			
			// Change menu options
			if (key_left && !key_right) { _menu_change = -1; }
			else if (key_right && ! key_left) { _menu_change = 1; }
			if (menu_pos == SETTINGS_OPTIONS.SKIP_THIS) { _current_option_pos += _menu_change; }
			_current_option_pos += _menu_change;
			if (_current_option_pos > _max_option_pos || _current_option_pos < _min_option_pos) { 
				_current_option_pos = clamp(_current_option_pos, _min_option_pos, _max_option_pos);
				if !(audio_is_playing(snd_solid_invulnerable)) { play_global_sound(snd_solid_invulnerable); }
			}
			if (_current_option_pos != _prev_menu_pos) {
				play_global_sound(snd_player_ladder_step);
				text_shake_timer = 8;
				cursor_sway_timer = 0;
				if (menu_pos == SETTINGS_OPTIONS.FULL_SCREEN) { full_screen_option = _current_option_pos; }
				else if (menu_pos == SETTINGS_OPTIONS.SCREEN_SCALE) { screen_scale_option = _current_option_pos; }
				
				// Apply and Save Menu Choices
				update_screen_size(full_screen_option, screen_scale_option);

				ini_open("mdb.ini");
				progress_level = ini_write_real("progress", "progress_level", 1);
				full_screen_option = ini_write_real("settings", "full_screen", full_screen_option);
				screen_scale_option = ini_write_real("settings", "screen_scale", screen_scale_option);
				ini_close();
			}
			
			// Handle Return Selection
			if (global.controller.transition_timer == 0 && (key_jump || key_restart)) {
				play_global_sound(snd_explosion);
				state = TITLE_STATES.MAIN_MENU;
				menu_pos = MENU_OPTIONS.SETTINGS;
			}
		}
	}
}