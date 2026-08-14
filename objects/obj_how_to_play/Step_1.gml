event_inherited();

if (key_left || key_right || key_up || key_down || key_jump || key_restart) {
	global.controller.return_to_title();
}

if (cutscene_timer >= next_text_trigger) {
	text_pos_timer = 0;
	next_text_trigger += DISPLAY_TIME + TEXT_WAIT;
	text_pos += 1;
}
else { text_pos_timer++; }

with (obj_player) {
	reset_controls();
	if (other.text_pos_timer > PLAYER_WAIT && other.text_pos_timer < other.next_text_trigger - PLAYER_WAIT) {
		switch(other.text_pos) {
			case 0: {
				if (other.text_pos_timer > FIRST_WAIT) {
					var _left_dir = ((other.cutscene_timer div 16) % 2 == 0);
					key_left = _left_dir;
					key_right = !_left_dir;
				}
			
				break;
			}
			case 1: {
				if (prev_state != PLAYER_STATES.CROUCH) {
					var _left_dir = (other.text_pos_timer > FIRST_WAIT);
					key_left = _left_dir;
					key_right = !_left_dir;
				}
			
				break;
			}
		}
	}
}