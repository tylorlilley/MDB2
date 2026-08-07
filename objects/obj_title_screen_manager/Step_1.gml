// Read Controller Values from Player
with (obj_player) {
	update_controls();
	other.key_right = key_right;
	other.key_left = key_left;
	other.key_up = key_up;
	other.key_down = key_down;
}

// Set Jump and Restart Based on Release Only
key_jump =  (keyboard_check_released(ord("Z")) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_face1) || gamepad_button_check_released(global.gamepad, gp_face2) || gamepad_button_check_released(global.gamepad, gp_face3) || gamepad_button_check_released(global.gamepad, gp_face4))));
key_restart = (keyboard_check_released(ord("R")) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_start) || gamepad_button_check_released(global.gamepad, gp_select))));

event_inherited();
audio_stop_sound(bgm_transition);

// Make Player Ignore Controls
with (obj_player) {
	if (transition_timer == 0) { transition_timer = 4; }
	reset_controls();
	sprite_index = spr_player_walk;
	image_index = 1;
	if (cape_state != CAPE_STATES.FLUTTER) { start_cape_flutter(); }
}

// Update Timers
cursor_sway_timer++;
if (cursor_sway_timer > 32) { cursor_sway_timer = -(irandom(60) + 60); }
title_sway_timer = (title_sway_timer + 1) % 24;
if (text_shake_timer > 0) { text_shake_timer--; }

// Tackle Input
prev_state = state;
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
		if (text_shake_timer == 0) {
			var _prev_menu_pos = menu_pos;
			if (key_up && !key_down) { menu_pos--; }
			else if (key_down && ! key_up) { menu_pos++; }	
			menu_pos = clamp(menu_pos, 0, 4);
			// TODO: Clamp to 1 instead if classic mode not unlocked
			if (menu_pos != _prev_menu_pos) {
				audio_play_sound(snd_player_ladder_step, 2, false);
				text_shake_timer = 8;
			}
		}
		
		// Make Menu Selection
		if (key_jump || key_restart) {
			switch (menu_pos) {
				case 0: {
					// Go To Next Room
					with (obj_player) {
						global.controller.x = x;
						global.controller.y = y;
					}
					global.controller.target_room = rm_old_w1_1;
					global.controller.transition_timer = TRANSITION_DELAY;
					audio_stop_sound(bgm_title);
				}
				case 1: {
					// Go To Next Room
					with (obj_player) {
						global.controller.x = x;
						global.controller.y = y;
					}
					global.controller.target_room = rm_mdb_1_1;
					global.controller.transition_timer = TRANSITION_DELAY;
					audio_stop_sound(bgm_title);
				}
			}
		}
	}
}