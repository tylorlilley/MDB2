if (has_gravity && object_index != obj_player) {
	var _on_ground = is_grounded();
	
	if (transition_timer > 0) {
		transition_timer--;
		
		if (state == STATES.FALLING) { virtual_y += 2; fall_timer++; }
	}
	
	if (transition_timer == 0) {
		state = STATES.STILL;
		
		// Start Falling
		if (!_on_ground) {
			grid_move_down();
			transition_timer = 4;
			state = STATES.FALLING;
		}
	}
}