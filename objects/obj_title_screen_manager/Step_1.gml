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
var _controller = global.controller;
if (_controller.screen_resize_timer > 0) { exit; }

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
			// Determine Direction of Menu change
			var _prev_menu_pos = menu_pos, _skip_continue = (saved_room == -1), _menu_change = 0;
			var _min_menu_pos = (state == TITLE_STATES.MAIN_MENU && progress_level == 0) ? MENU_OPTIONS.START_GAME : MENU_OPTIONS.START_CLASSIC, _max_menu_pos = (state == TITLE_STATES.MAIN_MENU) ? MENU_OPTIONS.SETTINGS : SETTINGS_OPTIONS.RETURN;
			if (key_up && !key_down) { _menu_change = -1; }
			else if (key_down && ! key_up) { _menu_change = 1; }
			
			// Clamp New Menu Position to Certain Optyions
			if (abs(_menu_change) > 0) {
				var _should_skip = true;
				while (_should_skip) {
					_should_skip = false;
					menu_pos += _menu_change;
				
					// Pass Over Certain Options
					if (state == TITLE_STATES.MAIN_MENU && menu_pos == MENU_OPTIONS.LOAD_GAME && _skip_continue) { _should_skip = true; }
					if (state == TITLE_STATES.SETTINGS_MENU && menu_pos == SETTINGS_OPTIONS.SCREEN_SCALE && _controller.window_fullscreen_setting != FULL_SCREEN_OPTIONS.WINDOWED) { _should_skip = true; }
					if (state == TITLE_STATES.SETTINGS_MENU && menu_pos == SETTINGS_OPTIONS.SKIP_THIS) { _should_skip = true; }
				}
			}
			
			// Clamp to Acceptable Values
			if (menu_pos > _max_menu_pos || menu_pos < _min_menu_pos) { 
				menu_pos = clamp(menu_pos, _min_menu_pos, _max_menu_pos);
				if !(audio_is_playing(snd_solid_invulnerable)) { play_global_sound(snd_solid_invulnerable); }
			}
			
			// If cursor position changed, update menu position
			if (menu_pos != _prev_menu_pos) {
				play_global_sound(snd_player_ladder_step);
				text_shake_timer = 8;
				cursor_sway_timer = 0;
			}
		}
		
		// Make Menu Selection
		if (state == TITLE_STATES.MAIN_MENU) {
			var _next_level = (menu_pos == MENU_OPTIONS.START_CLASSIC) ? rm_old_prelude : rm_mdb_prelude;
			if (menu_pos == MENU_OPTIONS.LOAD_GAME) { _next_level = saved_room; }
			if (menu_pos == MENU_OPTIONS.CONTROLS) { _next_level = rm_how_to_play; }
			with (obj_player) { visible = (other.menu_pos > MENU_OPTIONS.START_GAME); }
		
			if (global.controller.transition_timer == 0 && (key_jump || key_restart)) {
				switch (menu_pos) {
					case MENU_OPTIONS.CONTROLS:
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
						stop_sound(bgm_mdb_title);
					
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
			if (menu_pos == SETTINGS_OPTIONS.FULL_SCREEN) { _min_option_pos = FULL_SCREEN_OPTIONS.FULL_SCREEN; _max_option_pos = FULL_SCREEN_OPTIONS.WINDOWED; _current_option_pos = _controller.window_fullscreen_setting; }
			else if (menu_pos == SETTINGS_OPTIONS.SCREEN_SCALE) { _min_option_pos = 1; _max_option_pos = max_scaling_size; _current_option_pos = _controller.window_scale_setting; }
			var _prev_menu_pos = _current_option_pos;
			
			// Change menu options
			if (key_left && !key_right) { _menu_change = -1; }
			else if (key_right && ! key_left) { _menu_change = 1; }
			_current_option_pos += _menu_change;
			if (_current_option_pos > _max_option_pos || _current_option_pos < _min_option_pos) { 
				_current_option_pos = clamp(_current_option_pos, _min_option_pos, _max_option_pos);
				if !(audio_is_playing(snd_solid_invulnerable)) { play_global_sound(snd_solid_invulnerable); }
			}
			if (_current_option_pos != _prev_menu_pos) {
				play_global_sound(snd_player_ladder_step);
				text_shake_timer = 8;
				cursor_sway_timer = 0;
				
				// Apply and Write Updated Settings
				if (menu_pos == SETTINGS_OPTIONS.FULL_SCREEN) { _controller.window_fullscreen_setting = _current_option_pos;  _controller.update_window_fullscreen(); }
				else if (menu_pos == SETTINGS_OPTIONS.SCREEN_SCALE) { _controller.window_scale_setting = _current_option_pos; _controller.update_window_size(); }
				_controller.write_window_options();
				
			}
			
			// Handle Return Selection
			if (global.controller.transition_timer == 0 && (key_jump || key_restart)) {
				if (menu_pos = SETTINGS_OPTIONS.RETURN) {
					play_global_sound(snd_explosion);
					state = TITLE_STATES.MAIN_MENU;
					menu_pos = MENU_OPTIONS.SETTINGS;
				}
				else { play_global_sound(snd_solid_invulnerable); }
			}
		}
	}
}