event_inherited();

if (!global.controller.is_logic_frame()) { exit; }

if (room != rm_how_to_play) { instance_destroy(); exit; }

if (key_left || key_right || key_up || key_down || key_jump || key_restart) {
	return_to_title = true;
	global.controller.return_to_title(true);
	play_global_sound(snd_explosion);
	/*
	global.controller.target_room = rm_intro;
	global.controller.transition_timer = TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD;
	audio_stop_sound(bgm_old_how_to_play);
	play_global_sound(bgm_mdb_title);
	*/
}

if (cutscene_timer >= next_text_trigger && text_pos < array_length(text_box_strings)) {
	text_pos_timer = 0;
	next_text_trigger += DISPLAY_TIME + TEXT_WAIT;
	text_pos += 1;
	with (obj_player) { has_completed_move = 0; }
}
else { text_pos_timer++; }

with (obj_player) {
	reset_controls();
	
	if (other.text_pos_timer > PLAYER_WAIT && other.text_pos_timer < other.next_text_trigger) {
		switch(other.text_pos) {
			case 0: {
				// Walk Back and Forth
				if (other.text_pos_timer > FIRST_WAIT) {
					var _left_dir = ((other.cutscene_timer div 16) % 2 == 0);
					key_left = _left_dir;
					key_right = !_left_dir;
				}
			
				break;
			}
			case 1: {
				// Walk into Wall, and Climb up Ledge
				if (state != prev_state && state == PLAYER_STATES.CLIMB) { has_completed_move++; }
				
				if (has_completed_move < 2) {
					var _left_dir = (other.text_pos_timer > FIRST_WAIT);
					key_left = _left_dir;
					key_right = !_left_dir && has_completed_move < 2;
				}
			
				break;
			}
			case 2: {
				// Fall 1 tile height
				if (other.text_pos_timer > FIRST_WAIT && other.text_pos_timer < (FIRST_WAIT * 4)) {
					var _left_dir = (other.text_pos_timer > FIRST_WAIT * 3);
					key_left = _left_dir;
					key_right = !_left_dir;
				}
			
				break;
			}
			case 3: {
				// Fall 2 tile height
				if (state != prev_state && state == PLAYER_STATES.FALL) { has_completed_move++; }

				if (other.text_pos_timer > FIRST_WAIT && has_completed_move == 0) { key_left = true; }
			
				break;
			}
			case 4: {
				// Walk to ladder and Grab it.
				if (state != prev_state && state == PLAYER_STATES.LADDER) { has_completed_move = true; }
				
				if (other.text_pos_timer > FIRST_WAIT + FIRST_WAIT && has_completed_move == 0) {
					key_left = true;
					key_up = true;
				}
				
				break;
			}
			case 5: {
				// Climb Up and Down Ladder
				if (state != prev_state && state == PLAYER_STATES.LADDER) { has_completed_move = (has_completed_move + 1) % 2; }
				
				if (!is_on_ground() || other.text_pos_timer < FIRST_WAIT + (PLAYER_WAIT * 4)) {
					key_up = (has_completed_move == 0);
					key_down = (has_completed_move == 1);
				}
				
				break;
			}
			case 6: {
				// Step Off Ladder
				if (other.text_pos_timer > FIRST_WAIT * 2 && other.text_pos_timer <= (FIRST_WAIT * 2) + PLAYER_WAIT) {
					key_right = true;
				}
				
				break;
			}
			case 7: {
				// Auto-grab Air Ladder
				if (other.text_pos_timer > FIRST_WAIT) { key_left = true; }
				
				break;
			}
			case 8: {
				// Fall off Ladder From Bottom
				if (other.text_pos_timer > FIRST_WAIT) {
					key_down = true;
					
					break;
				}
			}
			case 9: {
				if (state != prev_state && state == PLAYER_STATES.LADDER_UP) { has_completed_move++; }

				// Run Right and Climb Ladder
				if (other.text_pos_timer > FIRST_WAIT * 2 && other.text_pos_timer < FIRST_WAIT * 4) {
					key_right = true;
					key_up = (!is_on_ground() || has_completed_move == 0);
				}
				
				break;
			}
			case 10: {
				// Explain Safely Falling on Metal
				if (state != prev_state && state == PLAYER_STATES.FALL) { has_completed_move++; }
				
				if (other.text_pos_timer > FIRST_WAIT) {
					if (has_completed_move == 0) { key_right = true; }
				}
				
				break;
			}
			case 11: {
				// Run Right and Climb Up Ladder and Collect Key
				if (state != prev_state && state == PLAYER_STATES.LADDER_UP) { has_completed_move++; }

				if (other.text_pos_timer > FIRST_WAIT && global.keys_collected == 0) {
					key_right = true;
					key_up = (!is_on_ground() || has_completed_move == 0);
				}
				
				break;
			}
			case 12: {
				// Run Right and Fall and Break Door
				if (global.keys_collected > 1) { has_completed_move++; }

				if (other.text_pos_timer > FIRST_WAIT && has_completed_move == 0) {
					key_right = true;
				}
				
				break;
			}
			case 13: {
				// Restart
				global.controller.target_room = rm_how_to_play;

				if (!other.restarted) {
					if (other.text_pos_timer <= (FIRST_WAIT * 3)) {
						var _left_dir = ((other.cutscene_timer div 32) % 2 == 0);
						key_left = _left_dir;
						key_right = !_left_dir;
					}
					if (other.text_pos_timer >= (FIRST_WAIT * 4)) {
						key_restart = true;
						other.restarted = true;
						global.controller.transition_timer = 1;
					}
				}
				
				break;
			}
			case 15:{
				// Collect all Keys
				global.controller.target_room = rm_title;
				
				if (other.text_pos_timer > FIRST_WAIT * 2) {
					key_right = (global.keys_collected < 2);
					key_up = (global.keys_collected == 0);
					key_down = !key_up && !is_on_ground();
				}
				
				break;
			}
			case 16:  {
				// Go to Open Door
				global.controller.target_room = rm_title;
				
				if (other.text_pos_timer > FIRST_WAIT * 2) {
					key_right = true;
				}
				
				break;
			}
			case 17: {
				// Enter Door and End Tutorial
				global.controller.target_room = rm_title;

				if (other.text_pos_timer > FIRST_WAIT) {
					key_up = true;
				}
				if (!visible) { play_title_music(); other.depth = global.controller.depth + 1; }
				
				break;
			}
		}
	}
}