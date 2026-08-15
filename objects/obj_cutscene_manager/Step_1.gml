cutscene_timer++;

with (obj_player) {
	// Replace Real With Scripted Input for Player
	reset_controls();
	if (other.cutscene_timer > 8) {
		key_right = true;
		key_up = (state != PLAYER_STATES.WIN || (other.cutscene_timer > other.cutscene_timer_max && transition_timer == 0));
	}
}

// Set Jump and Restart Based on Release Only
key_left = get_left_pressed();
key_right = get_right_pressed();
key_up = get_up_pressed();
key_down = get_down_pressed();
key_jump = get_jump_pressed();
key_restart = get_restart_pressed();
