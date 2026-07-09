event_inherited();

if (has_gravity) {
	if (transition_timer > 0) {
		transition_timer--;
		
		if (state == STATES.FALLING) {
			if (!is_grounded()) { virtual_y += (is_fully_submerged() && fall_timer <= 8) ? 1 : 2; }
			
			if (is_fully_submerged()) { fall_timer -= 2; }
			else { fall_timer++; }
		}
		else if (state == STATES.SURFACE) {
			if (!is_under_ceiling()) { virtual_y -= 1; }
		}
		else if (state == STATES.PUSHED) {
			virtual_x += (is_left) ? -1 : 1;
		}
	}
	
	if (transition_timer == 0) {
		if (state != STATES.FALLING) { fall_timer = 0; }
		if ( state != STATES.FLOAT) { swim_timer = 0; }
		
		switch (state) {
			case STATES.STILL:
			case STATES.PUSHED: {
				// Move Based on Previous State
				if (state == STATES.PUSHED) { grid_move_horizontal(); }
	
				if (!is_grounded()) {
					// Start Falling
					transition_timer = 4;
					state = STATES.FALLING;
				}
				else { state = STATES.STILL; }
				
				break;
			}
			case STATES.SURFACE: {
				// Move Based on Previous State
				if (!is_under_ceiling()) { grid_move_up(); }
				
				if (is_fully_submerged()) {
					// Keep Surfacing
					transition_timer = 8;
				}
				else {
					// Start Floating
					state = STATES.FLOAT;
					swim_timer++;
				}
				break;
			}
			case STATES.FALLING: {
				// Move Based on Previous State
				if (!is_grounded()) { grid_move_down(); }
				
				if (fall_timer <= 0) {
					// Start Surfacing
					transition_timer = 8;
					state = STATES.SURFACE;
				}
				else if (!is_fully_submerged() && is_grounded()) {
					// Become Still
					state = STATES.STILL;
				}
				else {
					// Keep Falling
					transition_timer = (is_fully_submerged() && fall_timer <= 8) ? 8 : 4;
				}
				break;
			}
			case STATES.FLOAT: { swim_timer++; break; }
		}
	
		virtual_x = x;
		virtual_y = y;
	}
}