// Inherit the parent event
event_inherited();

is_ground = true;
is_ceiling = true;
is_right_wall = true;
is_left_wall = true;

is_climbable = true;
has_gravity = true;

walk_particles = 0;
step_sound = noone;

depth = 9;

carried_objects = [];

get_float_offset = function() {
	var _ampliutude = 2, _period = 30, _swim_bob = round(_ampliutude * sin(swim_timer*(pi / _period)));
	swim_timer = swim_timer % _period;
	
	var _y_offset = (is_floating_state()) ? _swim_bob : 0;
	if (is_grounded_state()) {
		_y_offset = 999;
		var _ground_objects = get_ground_objects();
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i];
			if (instance_exists(_inst) && object_is_ancestor(_inst.object_index, obj_dynamic_game_object) && (_inst.is_floating_state() || _inst.is_grounded_state())) {
				with (_inst) {
					_y_offset = min(_y_offset, get_float_offset());
				}
			}
		}
		if (_y_offset == 999) { _y_offset = 0; }
	}
	
	return _y_offset;
}

update_carried_object_offsets = function() {
	var _total_x_offset = (virtual_x - x) + carrier_x_offset;
	for (var _i = 0; _i < array_length(carried_objects); _i++) {
		var _inst = carried_objects[_i];
		with (_inst) {
			carrier_x_offset += _total_x_offset;
			carrier_count++;
		}
	}
}

is_grounded_state = function() {
	return (state == STATES.PUSHED || state == STATES.STILL);
}

is_floating_state = function() {
	return state == STATES.FLOAT;
}

game_object_step = function() {
	if (has_gravity) {
		if (transition_timer > 0) {
			transition_timer--;
		
			if (state == STATES.FALLING) {
				var _fall_speed = 2;
				if (is_fully_submerged()) {
					if (array_length(carried_objects) > 0) { _fall_speed = 2; }
					else if (fall_timer == 0 || is_grounded()) { _fall_speed = 0; }
					else if (fall_timer < 8) { _fall_speed = 1; }
				}
				else { fall_timer++; }
			
				if (virtual_y != y) { virtual_y += _fall_speed; }
			}
			else if (state == STATES.SURFACE) {
				if (virtual_y != y) { virtual_y -= (fall_timer <= 8) ? 1 : 2; }
			}
			else if (state == STATES.PUSHED) {
				if (virtual_x != x) { virtual_x += (is_left) ? -1 : 1; }
			}
		}
	
		if (transition_timer == 0) {
			virtual_x = x;
			virtual_y = y;
			
			if (state != STATES.FALLING && state != STATES.SURFACE) { fall_timer = 0; }
			if ( state != STATES.FLOAT) { swim_timer = 0; }
		
			switch (state) {
				case STATES.STILL:
				case STATES.PUSHED: {
					if (!is_grounded()) {
						// Start Falling
						grid_move_down();
						transition_timer = 4;
						state = STATES.FALLING;
					}
					else { state = STATES.STILL; }
				
					break;
				}
				case STATES.SURFACE: {
					if (is_fully_submerged()) {
						// Keep Surfacing
						if (!is_under_ceiling()) { grid_move_up(); fall_timer += 4; }
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
					if (is_fully_submerged()) {
						if (fall_timer <= 0 && array_length(carried_objects) == 0) {
							// Start Surfacing
							if (!is_under_ceiling) { grid_move_up(); transition_timer = 8; }
							state = STATES.SURFACE;
						}
						else {
							// Keep Falling
							if (fall_timer > 8) { fall_timer = fall_timer div 4; }
							else { fall_timer -= 4; }
							
							if (fall_timer > 0 || array_length(carried_objects) != 0) {
								if (!is_grounded()) { grid_move_down(); fall_timer = 8; }
								else { 
									// Start Surfacing
									if (!is_under_ceiling) { grid_move_up(); transition_timer = 8; }
									state = STATES.SURFACE;
									fall_timer = 8;
								}
							}
							if (fall_timer < 0) { fall_timer = 0; }

							transition_timer = (fall_timer < 8) ? 8 : 4;
						}
					}
					else {
						 if (is_grounded()) { state = STATES.STILL; }
						 else {
							 // Keep Falling
							 grid_move_down();
							 transition_timer = 4;
						}
					}
					
					break;
				}
				case STATES.FLOAT: { swim_timer++; break; }
			}
		}
	}
	else {
		// TODO: don't base this on lack of gravity
		if (transition_timer > 0) {
			transition_timer--;
			virtual_x += (is_left) ? -2 : 2;
		}
		
		if (transition_timer == 0) {
			virtual_x = x;
			virtual_y = y;
			
			var _can_move = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
			if (_can_move) { grid_move_horizontal(is_left); transition_timer = 4; }
			else { is_left = !is_left; }
		}
	}
	
	update_carried_object_offsets();
}
