event_inherited();

if (!global.controller.is_logic_frame()) { exit; }

if (room != rm_how_to_play) { instance_destroy(); exit; }

if (key_left || key_right || key_up || key_down || key_jump || key_restart) {
	return_to_title = true;
	global.controller.return_to_title();
	play_global_sound(snd_explosion);
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
	
	if (other.text_pos_timer > PLAYER_WAIT) {
		switch(other.text_pos) {
			case 0: {
				// Welcome: Stand Still so the Player Reads the Message
				break;
			}
			case 1: {
				// Walk Back and Forth
				if (other.text_pos_timer > FIRST_WAIT) {
					var _left_dir = ((other.cutscene_timer div 16) % 2 == 0);
					key_left = _left_dir;
					key_right = !_left_dir;
				}
			
				break;
			}
			case 2: {
				// Push Against a Two Tile Wall, then Return to the One Tile Steps
				var _wall_return_x = 136; // Right face of the lower step
				if (is_push_state()) { has_completed_move = 1; }
				
				var _returning = (has_completed_move == 1 && other.text_pos_timer > FIRST_WAIT * 2);
				key_right = !_returning;
				key_left = _returning && (x > _wall_return_x);
			
				break;
			}
			case 3: {
				// Climb Both One Tile Steps, then Step Fully onto the Upper Ledge
				var _ledge_x = 104; // Leftmost tile with ground under both halves of the player
				key_left = (x > _ledge_x);
			
				break;
			}
			case 4: {
				// Fall Down Both Steps, Pause, then Climb Back Up
				var _wall_x = 136, _ledge_x = 104;
				var _ascending = (x >= _wall_x && other.text_pos_timer > FIRST_WAIT * 2);
				
				key_right = !_ascending && (x < _wall_x);
				key_left = _ascending && (x > _ledge_x);
			
				break;
			}
			case 5: {
				// Fall Two Tile Height
				if (state != prev_state && state == PLAYER_STATES.FALL) { has_completed_move++; }

				if (other.text_pos_timer > FIRST_WAIT && has_completed_move == 0) { key_left = true; }
			
				break;
			}
			case 6: {
				// Look Up at the Ladder, then Walk into it and Grab It
				if (is_ladder_state()) { has_completed_move = 1; }
				
				if (has_completed_move == 0) {
					key_up = true;
					key_left = (other.text_pos_timer > FIRST_WAIT * 2);
				}
				
				break;
			}
			case 7: {
				// Climb Up and Back Down, Stopping 24 Pixels Below the Bridge
				var _stop_y = 128; // The bridge surface sits at y = 104
				
				if (y <= _stop_y) { has_completed_move = max(has_completed_move, 1); }
				if (has_completed_move == 1 && is_on_ground()) { has_completed_move = 2; }
				
				key_down = (has_completed_move == 1);
				key_up = (has_completed_move != 1 && y > _stop_y);
				
				break;
			}
			case 8: {
				// Look Around, Climb Above the Bridge, then Step Off onto It
				var _step_off_y = 88, _step_off_x = 88;
				
				if (other.text_pos_timer <= PLAYER_WAIT * 3) { key_right = true; }
				else if (has_completed_move == 0) {
					if (y > _step_off_y - GRID_SIZE) { key_up = true; }
					else { has_completed_move = 1; }
				}
				else if (other.text_pos_timer <= (PLAYER_WAIT * 3) + FIRST_WAIT) { key_right = true; }
				else if (y < _step_off_y) { key_down = true; }
				else { key_right = (x < _step_off_x); }
				
				break;
			}
			case 9: {
				// Walk off the Bridge and Auto-Grab the Midair Ladder
				if (is_ladder_state()) { has_completed_move = 1; }
				
				key_left = (has_completed_move == 0);
				
				break;
			}
			case 10: {
				// Climb off the Bottom of the Ladder and Dive onto the Rock Below
				if (!is_ladder_state()) { has_completed_move = 1; }
				
				key_down = (has_completed_move == 0);
				
				break;
			}
			case 11: {
				// Climb Back Around and Dive onto the Same Rock a Second Time
				var _air_ladder_x = 24, _step_off_y = 88;
				
				if (is_ladder_state()) { has_completed_move = max(has_completed_move, 1); }
				if (has_completed_move == 1 && y <= _step_off_y) { has_completed_move = 2; }
				if (has_completed_move == 2 && is_ladder_state() && x <= _air_ladder_x) { has_completed_move = 3; }
				if (has_completed_move == 3 && !is_ladder_state()) { has_completed_move = 4; }
				
				key_right = (has_completed_move == 0);
				key_up = (has_completed_move <= 1);
				key_left = (has_completed_move == 2);
				key_down = (has_completed_move == 3);
				
				break;
			}
			case 12: {
				// Explain Safely Falling on Metal
				if (state != prev_state && state == PLAYER_STATES.FALL) { has_completed_move++; }
				
				if (other.text_pos_timer > FIRST_WAIT) {
					if (has_completed_move == 0) { key_right = true; }
				}
				
				break;
			}
			case 13: {
				// Run Right and Climb Up Ladder and Collect Key
				if (state != prev_state && state == PLAYER_STATES.LADDER_UP) { has_completed_move++; }

				if (other.text_pos_timer > FIRST_WAIT && global.keys_collected == 0) {
					key_right = true;
					key_up = (!is_on_ground() || has_completed_move == 0);
				}
				
				break;
			}
			case 14: {
				// Run Right and Fall and Break Door
				if (global.keys_collected > 1) { has_completed_move++; }

				if (other.text_pos_timer > FIRST_WAIT && has_completed_move == 0) {
					key_right = true;
				}
				
				break;
			}
			case 15: {
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
						global.controller.room_transition_timer = 1;
					}
				}
				
				break;
			}
			case 17:{
				// Collect all Keys
				global.controller.target_room = rm_title;
				
				if (other.text_pos_timer > FIRST_WAIT * 2) {
					key_right = (global.keys_collected < 2);
					key_up = (global.keys_collected == 0);
					key_down = !key_up && !is_on_ground();
				}
				
				break;
			}
			case 18:  {
				// Go to Open Door
				global.controller.target_room = rm_title;
				
				if (other.text_pos_timer > FIRST_WAIT * 2) {
					key_right = true;
				}
				
				break;
			}
			case 19: {
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
