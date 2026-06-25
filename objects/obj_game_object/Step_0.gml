if (!is_fixed && object_index != obj_player) {
	var _on_ground = is_grounded();
	
	if (transition_timer > 0) {
		transition_timer--;
		
		if (state == STATES.FALLING) { virtual_y += 2; }
	}
	
	if (transition_timer == 0) {
		state = STATES.STILL;
		
		// Start Falling
		if (!_on_ground) {
			y += 8;
			transition_timer = 4;
			state = STATES.FALLING;
		}
	}
}