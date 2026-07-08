if (has_gravity && object_index != obj_player) {
	if (transition_timer > 0) {
		transition_timer--;
		
		if (state == STATES.FALLING) { virtual_y += 2; fall_timer++; }
	}
	
	if (transition_timer == 0) {
		// Move Based on Previous State
		if (state == STATES.FALLING) { grid_move_down(); }
		
		// Reset State
		state = STATES.STILL;
		
		// Start Falling
		if (!is_grounded()) {
			transition_timer = 4;
			state = STATES.FALLING;
		}
	}
}