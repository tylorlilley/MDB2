event_inherited();

if (!global.controller.is_logic_frame()) { exit; }

if (room != rm_how_to_play) { instance_destroy(); exit; }

if (key_left || key_right || key_up || key_down || key_jump || key_restart) {
	return_to_title = true;
	global.controller.return_to_title();
	play_global_sound(snd_explosion);
}

if (cutscene_timer >= next_text_trigger && text_pos < array_length(text_box_strings) - 1) {
	text_pos_timer = 0;
	next_text_trigger += DISPLAY_TIME + TEXT_WAIT;
	text_pos += 1;
	with (obj_player) { has_completed_move = 0; }
}
else { text_pos_timer++; }

with (obj_player) {
	reset_controls();
	
	// Beats that continue a movement from the previous message must not stall on the input delay
	var _continues_previous_move = (other.text_pos == 12);
	
	if (other.text_pos_timer > PLAYER_WAIT || _continues_previous_move) {
		switch(other.text_pos) {
			case 0: {
				// Welcome: Stand Still so the Player Reads the Message
				break;
			}
			case 1: {
				// Pace Between the Ladder and the Steps, Finishing Back Beside the Steps
				var _right_x = 176, _left_x = 144; // 8px onto the ladder, 8px short of the step face
				var _returning = (other.text_pos_timer > DISPLAY_TIME - FIRST_WAIT);
				
				if (x >= _right_x) { has_completed_move = 1; }
				else if (x <= _left_x) { has_completed_move = 0; }
				
				// Always finish the leg he is on, so every turn happens at one of the two marks
				key_right = (has_completed_move == 0) && !(_returning && x <= _left_x);
				key_left = (has_completed_move == 1);
			
				break;
			}
			case 2: {
				// Walk into the Two Tile Wall and Keep Pushing Until the Message Changes
				key_right = true;
			
				break;
			}
			case 3: {
				// Walk Back to the Steps, Climb Both, then Step Fully onto the Upper Ledge
				var _ledge_x = 104; // Leftmost tile with ground under both halves of the player
				key_left = (x > _ledge_x);
			
				break;
			}
			case 4: {
				// Pause on the Ledge Edge, Drop Down Both Steps, Pause, then Climb and Drop the Bottom Step on Repeat
				var _edge_x = 112, _wall_x = 136; // 112 is half-supported, 136 is the foot of the bottom step
				var _edge_hold = FIRST_WAIT, _bottom_pause_end = (FIRST_WAIT * 2) + PLAYER_WAIT;
				
				// Counts frames spent standing on the first edge
				if (x >= _edge_x) { has_completed_move++; }
				
				key_left = (x >= _wall_x && other.text_pos_timer > _bottom_pause_end);
				key_right = (x < _edge_x) || (has_completed_move > _edge_hold && x < _wall_x);
			
				break;
			}
			case 5: {
				// Climb Back up the Steps, Step onto the Ledge Edge, Teeter, then Step off into a Two Tile Dive
				var _edge_x = 80, _edge_hold = FIRST_WAIT;
				
				// Counts frames spent standing on the edge, however long the walk out took
				if (x <= _edge_x) { has_completed_move++; }
				
				key_left = (x > _edge_x) || (has_completed_move > _edge_hold && x >= _edge_x);
			
				break;
			}
			case 6: {
				// Look Up at the Ladder, Hold Still, then Walk into it and Grab It
				var _look_time = FIRST_WAIT;
				var _look_end = PLAYER_WAIT + _look_time, _gap_end = _look_end + _look_time;
				
				if (is_ladder_state()) { has_completed_move = 1; }
				
				if (has_completed_move == 0) {
					// UP must stay held while walking, or he walks straight past the ladder
					key_left = (other.text_pos_timer > _gap_end);
					key_up = key_left || (other.text_pos_timer <= _look_end);
				}
				
				break;
			}
			case 7: {
				// Climb to the Top of the Ladder, Back to the Bottom, then Stop Below the Bridge
				var _top_y = 72, _bottom_y = 152, _stop_y = 128; // The bridge surface sits at y = 104
				
				if (y <= _top_y) { has_completed_move = max(has_completed_move, 1); }
				if (has_completed_move == 1 && y >= _bottom_y) { has_completed_move = 2; }
				
				key_down = (has_completed_move == 1);
				key_up = (has_completed_move == 0) || (has_completed_move == 2 && y > _stop_y);
				
				break;
			}
			case 8: {
				// Look, Hold Still, Climb Above the Bridge, Look, Hold Still, then Step Off onto It
				var _look_time = FIRST_WAIT div 2, _climb_time = FIRST_WAIT div 2;
				var _step_off_y = 88, _step_off_x = 88;
				var _look_end = PLAYER_WAIT + _look_time, _gap_end = _look_end + _look_time;
				var _climb_end = _gap_end + _climb_time;
				var _look_2_end = _climb_end + _look_time, _gap_2_end = _look_2_end + _look_time;
				
				if (other.text_pos_timer <= _look_end) { key_right = true; }
				else if (other.text_pos_timer <= _gap_end) { /* Hold still after looking */ }
				else if (other.text_pos_timer <= _climb_end) { key_up = (y > _step_off_y - GRID_SIZE); }
				else if (other.text_pos_timer <= _look_2_end) { key_right = true; }
				else if (other.text_pos_timer <= _gap_2_end) { /* Hold still after looking */ }
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
				// Climb off the Bottom of the Ladder, Dive, then Loop Back Around to It
				var _air_ladder_x = 24, _step_off_y = 88;
				
				if (has_completed_move == 0 && !is_ladder_state()) { has_completed_move = 1; }
				if (has_completed_move == 1 && is_grounded_state()) { has_completed_move = 2; }
				if (has_completed_move == 2 && y <= _step_off_y) { has_completed_move = 3; }
				if (has_completed_move == 3 && is_ladder_state() && x <= _air_ladder_x) { has_completed_move = 4; }
				
				key_down = (has_completed_move == 0);
				key_right = (has_completed_move == 2);
				key_up = (has_completed_move == 2 && y > _step_off_y);
				key_left = (has_completed_move == 3);
				
				break;
			}
			case 11: {
				// Dive onto the Same Rock a Second Time, then Head Back Out along the Bridge
				var _step_off_y = 88, _bridge_edge_x = 160; // Rightmost bridge tile before the gap
				
				if (has_completed_move == 0 && !is_ladder_state()) { has_completed_move = 1; }
				if (has_completed_move == 1 && is_grounded_state()) { has_completed_move = 2; }
				if (has_completed_move == 2 && y <= _step_off_y) { has_completed_move = 3; }
				
				key_down = (has_completed_move == 0);
				key_right = (has_completed_move == 2) || (has_completed_move == 3 && x < _bridge_edge_x);
				key_up = (has_completed_move == 2 && y > _step_off_y);
				
				break;
			}
			case 12: {
				// Wait on the Bridge Edge, then Step off onto the Indestructible Metal
				var _step_off_y = 88, _edge_x = 160, _gap_x = 168, _edge_hold = PLAYER_WAIT * 4;
				
				// Counts frames spent standing on the edge, however long the walk out took
				if (x >= _edge_x) { has_completed_move++; }
				
				key_up = (y > _step_off_y && x < _edge_x);
				key_right = (x < _edge_x) || (has_completed_move > _edge_hold && x < _gap_x);
				
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
				depth = global.controller.depth - 1;
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
					if (other.text_pos_timer <= (FIRST_WAIT * 2)) {
						var _left_dir = ((other.cutscene_timer div 32) % 2 == 0);
						key_left = _left_dir;
						key_right = !_left_dir;
					}
					if (other.text_pos_timer >= (FIRST_WAIT * 3)) {
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
				
				if (other.text_pos_timer > FIRST_WAIT + PLAYER_WAIT) {
					key_right = (global.keys_collected < 2);
					key_up = (global.keys_collected == 0);
					key_down = !key_up && !is_on_ground();
				}
				
				break;
			}
			case 18:  {
				// Go to Open Door
				global.controller.target_room = rm_title;
				
				if (other.text_pos_timer > FIRST_WAIT + PLAYER_WAIT) {
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
	
	// Latch the demo's inputs for the control display. The state machine clears key_* on any
	// frame where it makes a decision, so reading them at draw time flickers once per move.
	other.shown_key_left = key_left;
	other.shown_key_right = key_right;
	other.shown_key_up = key_up;
	other.shown_key_down = key_down;
}
