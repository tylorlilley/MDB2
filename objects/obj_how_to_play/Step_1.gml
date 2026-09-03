event_inherited();

if (!global.controller.is_logic_frame()) { exit; }

if (room != rm_how_to_play) { instance_destroy(); exit; }

// Exit to Title on Button Press
if (key_left || key_right || key_up || key_down || key_jump || key_restart) {
	instance_destroy();
	global.controller.return_to_title();
	play_global_sound(snd_explosion);
	exit;
}

// Update Cutscene Timers
if (cutscene_timer >= next_text_trigger && text_pos < array_length(text_box_strings) - 1) {
	text_pos_timer = 0;
	next_text_trigger += DISPLAY_TIME + TEXT_WAIT;
	text_pos += 1;
	with (obj_player) { has_completed_move = 0; demo_phase = 0; }
}
else { text_pos_timer++; }

// Manage Textbox
if (cutscene_timer > INTRO_WAIT && cutscene_timer < next_text_trigger - TEXT_WAIT) {
	if (!instance_exists(textbox)) {
		textbox = instance_create(0, 0, obj_textbox);
		textbox.persistent = true;
		textbox.max_width = SCREEN_WIDTH - GRID_SIZE * 2;
		textbox.max_height = GRID_SIZE * 6;
		textbox.origin_y = GRID_SIZE + (textbox.max_height/2);
		textbox.text_string = text_box_strings[text_pos];
	}
}
else if (cutscene_timer > next_text_trigger - TEXT_WAIT && instance_exists(textbox)) { textbox.is_opening = false; }

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
				var _ledge_x = 88; // Far enough left that the next message's walk out is three steps
				key_left = (x > _ledge_x);
			
				break;
			}
			case 4: {
				// Pause on the Ledge Edge, Drop Down Both Steps, Pause, then Climb and Drop the Bottom Step on Repeat
				var _edge_x = 112, _turn_x = 120, _wall_x = 136; // 112 is half-supported, 136 is the foot of the bottom step
				var _bottom_pause_end = (FIRST_WAIT * 2) + PLAYER_WAIT;
				
				// Falling states hold the key that started the drop, so it is never a one frame tap
				var _message_frames_left = other.next_text_trigger - other.cutscene_timer;

				if (x >= _wall_x && !is_fall_state() && other.text_pos_timer > _bottom_pause_end) { demo_phase = 1; }

				// Don't start a rightward leg the message has no time to finish; message 5 walks left from here
				if (demo_phase == 1 && x <= _turn_x && _message_frames_left > FIRST_WAIT) { demo_phase = 2; }
				
				key_left = (demo_phase == 1);
				key_right = (demo_phase != 1);
			
				break;
			}
			case 5: {
				// Climb Back up the Steps, Step onto the Ledge Edge, Teeter, then Step off into a Two Tile Dive
				var _edge_x = 80, _edge_hold = FIRST_WAIT, _step_off_hold = MIN_KEY_HOLD;
				
				// Counts frames spent standing on the edge, however long the walk out took
				if (x <= _edge_x) { has_completed_move++; }
				
				// The last stretch of the hold lands in midair, where LEFT no longer moves him
				key_left = (x > _edge_x) || (has_completed_move > _edge_hold && has_completed_move <= _edge_hold + _step_off_hold);
			
				break;
			}
			case 6: {
				// Look Up at the Ladder, Hold Still, Walk to It, then Grab It
				var _ladder_x = 56, _look_time = FIRST_WAIT;
				var _look_end = PLAYER_WAIT + _look_time, _gap_end = _look_end + _look_time;
				
				if (is_ladder_state()) { has_completed_move = 1; }
				
				if (has_completed_move == 0) {
					if (other.text_pos_timer <= _look_end) { key_up = true; }
					else if (other.text_pos_timer <= _gap_end) { /* Hold still after looking */ }
					else if (x > _ladder_x) { key_left = true; }
					else { key_up = true; }
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
				// Look, Hold Still, Climb to the Top, Look, Hold Still, Drop, then Step Off onto the Bridge
				var _look_time = FIRST_WAIT div 2, _climb_time = PLAYER_WAIT * 2;
				var _top_y = 72, _step_off_y = 88, _step_off_x = 88;
				var _look_end = PLAYER_WAIT + _look_time, _gap_end = _look_end + _look_time;
				var _climb_end = _gap_end + _climb_time;
				var _look_2_end = _climb_end + _look_time, _gap_2_end = _look_2_end + _look_time;
				
				if (other.text_pos_timer <= _look_end) { key_right = true; }
				else if (other.text_pos_timer <= _gap_end) { /* Hold still after looking */ }
				else if (other.text_pos_timer <= _climb_end) { key_up = (y > _top_y); }
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
				var _air_ladder_x = 24, _tall_ladder_x = 56, _step_off_y = 88;
				
				if (has_completed_move == 0 && !is_ladder_state()) { has_completed_move = 1; }
				if (has_completed_move == 1 && is_grounded_state()) { has_completed_move = 2; }
				if (has_completed_move == 2 && x >= _tall_ladder_x) { has_completed_move = 3; }
				if (has_completed_move == 3 && y <= _step_off_y) { has_completed_move = 4; }
				if (has_completed_move == 4 && is_ladder_state() && x <= _air_ladder_x) { has_completed_move = 5; }
				
				key_down = (has_completed_move == 0);
				key_right = (has_completed_move == 2);
				key_up = (has_completed_move == 3);
				key_left = (has_completed_move == 4);
				
				break;
			}
			case 11: {
				// Dive onto the Same Rock a Second Time, then Head Back Out along the Bridge
				var _tall_ladder_x = 56, _step_off_y = 88, _bridge_edge_x = 160; // Rightmost bridge tile before the gap
				
				if (has_completed_move == 0 && !is_ladder_state()) { has_completed_move = 1; }
				if (has_completed_move == 1 && is_grounded_state()) { has_completed_move = 2; }
				if (has_completed_move == 2 && x >= _tall_ladder_x) { has_completed_move = 3; }
				if (has_completed_move == 3 && y <= _step_off_y) { has_completed_move = 4; }
				
				key_down = (has_completed_move == 0);
				key_right = (has_completed_move == 2) || (has_completed_move == 4 && x < _bridge_edge_x);
				key_up = (has_completed_move == 3);
				
				break;
			}
			case 12: {
				// Wait on the Bridge Edge, then Step off onto the Indestructible Metal
				var _step_off_y = 88, _edge_x = 160;
				var _edge_hold = PLAYER_WAIT * 4, _step_off_hold = MIN_KEY_HOLD;
				
				// Catches up if the previous message ran out of room before the climb finished
				if (is_ladder_state() && y > _step_off_y) { key_up = true; }
				else {
					// Counts frames spent standing on the edge, however long the walk out took
					if (x >= _edge_x) { has_completed_move++; }
					
					// The last stretch of the hold lands in midair, where RIGHT no longer moves him
					key_right = (x < _edge_x) || (has_completed_move > _edge_hold && has_completed_move <= _edge_hold + _step_off_hold);
				}
				
				break;
			}
			case 13: {
				// Run Right to the Ladder, Pause, then Climb It and Collect the Key
				var _ladder_x = 184, _step_off_y = 88, _grab_pause = PLAYER_WAIT;
				
				// Counts frames spent waiting at the foot of the ladder
				if (x >= _ladder_x) { has_completed_move++; }

				if (other.text_pos_timer > FIRST_WAIT && global.keys_collected == 0) {
					if (x < _ladder_x) { key_right = true; }
					else if (has_completed_move <= _grab_pause) { /* Hold still before grabbing */ }
					else if (y <= _step_off_y) { key_right = true; }
					else { key_up = true; }
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
					// Struggle beats: alternate LEFT/RIGHT, pause, hold UP, pause, then give up
					var _beat = PLAYER_WAIT, _press_count = 4;
					var _elapsed = other.text_pos_timer - PLAYER_WAIT - 1;
					var _presses_end = _beat * _press_count;
					var _up_start = _presses_end + _beat, _up_end = _up_start + (_beat * 2);
					var _restart_at = _up_end + _beat;

					if (_elapsed < _presses_end) {
						var _left_dir = (((_elapsed div _beat) % 2) == 0);
						key_left = _left_dir;
						key_right = !_left_dir;
					}
					else if (_elapsed >= _up_start && _elapsed < _up_end) { key_up = true; }
					else if (_elapsed >= _restart_at) {
						key_restart = true;
						other.restarted = true;
						global.controller.room_transition_timer = 1;
					}
				}
				
				break;
			}
			case 17: {
				// Climb for the First Key, Climb Back Down, Pause, then Step Across for the Second
				global.controller.target_room = rm_title;
				
				var _ladder_x = 184, _step_off_pause = PLAYER_WAIT;
				
				// Counts frames spent back on the bridge holding the first key
				if (global.keys_collected == 1 && is_on_ground()) { has_completed_move++; }
				
				if (other.text_pos_timer > FIRST_WAIT + PLAYER_WAIT && global.keys_collected < 2) {
					if (x < _ladder_x) { key_right = true; }
					else if (global.keys_collected == 0) { key_up = true; }
					else if (!is_on_ground()) { key_down = true; }
					else if (has_completed_move > _step_off_pause) { key_right = true; }
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
	
	// Mirror the demo's inputs for the control display. The state machine clears key_* on the frame
	// it consumes them, so the display has to read this copy rather than the live variables.
	other.shown_key_left = key_left;
	other.shown_key_right = key_right;
	other.shown_key_up = key_up;
	other.shown_key_down = key_down;
}
