event_inherited();

if (has_gravity) {
	if (transition_timer > 0) {
		transition_timer--;
		
		if (state == STATES.FALLING) {
			var _fall_speed = 2;
			if (is_fully_submerged()) {
				if (fall_timer == 0 || is_grounded()) { _fall_speed = 0; }
				else if (fall_timer < 8) { _fall_speed = 1; }
			}
			else { fall_timer++; }
			
			virtual_y += _fall_speed;
		}
		else if (state == STATES.SURFACE) {
			virtual_y -= (fall_timer <= 8) ? 1 : 2;
		}
		else if (state == STATES.PUSHED) {
			virtual_x += (is_left) ? -1 : 1;
		}
	}
	
	if (transition_timer == 0) {
		if (state != STATES.FALLING && state != STATES.SURFACE) { fall_timer = 0; }
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
				grid_move_up();
				
				if (is_fully_submerged()) {
					// Keep Surfacing
					fall_timer += 4;
					transition_timer = (fall_timer <= 8) ? 8 : 4;
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
				if (fall_timer > 0 && !is_grounded()) { grid_move_down(); }
				
				if (!is_fully_submerged()) {
					 if (is_grounded()) { state = STATES.STILL; }
					 else { transition_timer = 4; }
				}
				else {
					// Surface or Update Fall Timer
					if (fall_timer <= 0) {
						state = STATES.SURFACE;
						transition_timer = 8;
					}
					else if (fall_timer > 8) { fall_timer = fall_timer div 4; }
					else { fall_timer -= 4; }
					if (fall_timer < 0) { fall_timer = 0; }

					transition_timer = (fall_timer < 8 || is_grounded()) ? 8 : 4;
				}
				break;
			}
			case STATES.FLOAT: { swim_timer++; break; }
		}
	
		virtual_x = x;
		virtual_y = y;
	}
}