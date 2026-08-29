// Poll for Gamepad
determine_gamepad();

// Update Framerate
var _fast_forward_button_held = (keyboard_check(vk_shift) || gamepad_button_check(global.gamepad, gp_shoulderl) || gamepad_button_check(global.gamepad, gp_shoulderr) || gamepad_button_check(global.gamepad, gp_shoulderlb) || gamepad_button_check(global.gamepad, gp_shoulderrb));
fast_forward_enabled = can_fast_forward && (_fast_forward_button_held && !paused && window_fps_setting >= 60);
var _new_logical_fps = (fast_forward_enabled) ? 60 : 30;
if (_new_logical_fps != logical_fps) {
	var _old_ratio = fps_ratio;
	logical_fps = _new_logical_fps;
	fps_ratio = max(1, (window_fps_setting div logical_fps));
	fps_timer = 0;
	recalculate_engine_speeds(_old_ratio);
}

// Handle Game Pause
var _can_pause = (!fast_forward_enabled && room != rm_controller && (!is_cutscene_room() || room == rm_how_to_play || room == rm_title));
if (paused && !_can_pause) { unpause_game(); }

if (unpausing) {
	if (instance_exists(paused_textbox)) { paused_textbox.is_opening = false; }
	else { unpause_game(); }
}
else {
	if (paused) {
		// Create Pause Textbox
		if (!instance_exists(paused_textbox)) {
			paused_textbox = instance_create(0, 0, obj_textbox);
			paused_textbox.should_dim_screen = true;
			paused_textbox.max_width = SCREEN_WIDTH - (GRID_SIZE * 3);
			paused_textbox.max_height = GRID_SIZE * 8;
			paused_textbox.origin_y = SCREEN_MIDDLE_Y;
			paused_textbox.font = ft_block_blueprint;
			paused_textbox.text_string = (room == rm_title) ? TITLE_PAUSE_MESSAGE_STRING : PAUSE_MESSAGE_STRING;	
		}
		else if (paused_textbox.progress >= 1) {
			if (get_restart_released()) {
				// Quit Game
				if (room == rm_title) { game_end(); }
				// Return to Title
				else {
					paused = false;
					unpausing = false;
					paused_layers = [];
					return_to_title();
					play_global_sound(snd_explosion);
				}
			}
			else if (get_jump_released() || get_pause_released() || get_up_released() || get_down_released() || get_left_released() || get_right_released()) {
				unpausing = true;
				audio_stop_sound(snd_pause);
				audio_play_sound(snd_unpause, 0, false);
			}
		}
	}
	else if (_can_pause && get_pause_released()) { pause_game(); }
}
	