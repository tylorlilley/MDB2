
get_float_offset = function() {
	var _ampliutude = 2, _period = 30, _swim_bob = round(_ampliutude * sin(swim_timer*(pi / _period)));
	swim_timer = swim_timer % _period;
	
	var _y_offset = (is_floating_state()) ? _swim_bob : 0;
	if (is_grounded_state()) {
		_y_offset = 999;
		var _ground_objects = get_ground_objects();
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i];
			if (instance_exists(_inst) && is_a(_inst, obj_dynamic_object) && (_inst.is_floating_state() || _inst.is_grounded_state())) {
				with (_inst) {
					_y_offset = min(_y_offset, get_float_offset());
				}
			}
		}
		if (_y_offset == 999) { _y_offset = 0; }
	}
	
	return _y_offset;
}

update_transition_speed = function() {
	transition_speed = (transition_timer > 0) ? (2 * (4 / transition_timer)) : 0;
}

// State References
is_grounded_state = function() {
	return (state == STATES.PUSHED || state == STATES.STILL);
}

is_floating_state = function() {
	return state == STATES.FLOAT;
}

// Movement Functions
grid_move_to = function(_new_x, _new_y) {
	grid_remove();
	x = _new_x;
	y = _new_y;
	grid_add();
}

virtual_move_horizontal = function(_x_offset) {
	virtual_x += _x_offset
	for (var _i = 0; _i < array_length(carried_objects); _i++) {
		var _inst = carried_objects[_i];
		_inst.virtual_move_horizontal(_x_offset);
	}
}

virtual_move_vertical = function(_y_offset) {
	virtual_y += _y_offset
	for (var _i = 0; _i < array_length(carried_objects); _i++) {
		var _inst = carried_objects[_i];
		_inst.virtual_move_vertical(_y_offset);
	}
}

grid_move_up = function() {
	grid_move_to(x, y - 8);
	for (var _i = 0; _i < array_length(carried_objects); _i++) {
		var _inst = carried_objects[_i];
		_inst.grid_move_up();
	}
}

grid_move_down = function() {
	grid_move_to(x, y + 8);
	for (var _i = 0; _i < array_length(carried_objects); _i++) {
		var _inst = carried_objects[_i];
		_inst.grid_move_down();
	}
}

grid_move_left = function() {
	grid_move_to(x - 8, y);
	for (var _i = 0; _i < array_length(carried_objects); _i++) {
		var _inst = carried_objects[_i];
		_inst.grid_move_left();
	}
}

grid_move_right = function() {
	grid_move_to(x + 8, y);
	for (var _i = 0; _i < array_length(carried_objects); _i++) {
		var _inst = carried_objects[_i];
		_inst.grid_move_right();
	}
}


// Collision Detection

// Get List of Specified Objects
get_carried_objects = function() {
	return get_relative_solid_objects(0, -8, function(inst) {
        return is_a(inst, obj_dynamic_object) && inst.has_gravity;
    });
}

get_ground_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(0, 8, function(inst, ofs) {
        return inst.is_solid_from_above(ofs);
    }, _only_full_solids);
}

get_left_wall_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(-8, 0, function(inst, ofs) {
        return inst.is_solid_from_right(ofs);
    }, _only_full_solids);
}

get_right_wall_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(8, 0, function(inst, ofs) {
        return inst.is_solid_from_left(ofs);
    }, _only_full_solids);
}

get_ceiling_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(0, -8, function(inst, ofs) {
        return inst.is_solid_from_below(ofs);
    }, _only_full_solids);
}

get_left_ground_objects = function() {
	return get_relative_solid_objects(-8, 8, function(inst) {
        return inst.is_solid_from_above();
    });
}

get_right_ground_objects = function() {
	return get_relative_solid_objects(8, 8, function(inst) {
        return inst.is_solid_from_above();
    });
}

get_left_pushable_objects = function() {
	return get_relative_solid_objects(-8, 0, function(inst) {
        return inst.can_be_pushed_left();
    });
}

get_right_pushable_objects = function() {
	return get_relative_solid_objects(8, 0, function(inst) {
        return inst.can_be_pushed_right();
    });
}

get_left_climbable_objects = function() {
	return get_relative_solid_objects(-8, 0, function(inst) {
        return inst.can_be_climbed_from_right();
    });
}

get_right_climbable_objects = function() {
	return get_relative_solid_objects(8, 0, function(inst) {
        return inst.can_be_climbed_from_left();
    });
}

// Boolean Checks
is_grounded = function(_only_full_solids = false) {
	return array_length(get_ground_objects(_only_full_solids)) > 0;
}

is_under_ceiling = function(_only_full_solids = false) {
	return array_length(get_ceiling_objects(_only_full_solids)) > 0;
}

is_blocked_on_left = function(_only_full_solids = false) {
	return array_length(get_left_wall_objects(_only_full_solids)) > 0;
}

is_blocked_on_right = function(_only_full_solids = false) {
	return array_length(get_right_wall_objects(_only_full_solids)) > 0;
}

is_fully_submerged = function() {
	return at_each_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_water);
}

is_partially_submerged = function() {
	return (at_grid_position(x, y+sprite_get_height(sprite_index)/2, sprite_get_width(sprite_index), sprite_get_height(sprite_index)/2, obj_water) &&
								!at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index)/2, obj_water));
}

start_being_pushed = function(_pushed_left) {
	// Start Being Pushed
	if (_pushed_left) { grid_move_left(); }
	else { grid_move_right(); }
	state = STATES.PUSHED;
	transition_timer = 8;
	update_transition_speed();
}

game_object_move = function() {
}

// Step Function
game_object_step = function() {
	if (has_gravity) {
		if (transition_timer > 0) {
			transition_timer--;
		
			if (state == STATES.FALLING) {
				if (!is_fully_submerged()) { fall_timer++; }
				if (y != virtual_y) { virtual_move_vertical(transition_speed); }
				else { transition_timer = 0; }
			}
			else if (state == STATES.SURFACE) {
				if (y != virtual_y) { virtual_move_vertical(transition_speed * -1); }
				else { transition_timer = 0; }
			}
			else if (state == STATES.PUSHED) {
				var _x_offset = (x < virtual_x) ? -1 : 1, _blocked = (_x_offset < 0) ? is_blocked_on_left() : is_blocked_on_right();
				if (x != virtual_x) { virtual_move_horizontal(transition_speed * _x_offset); }
				else { transition_timer = 0; }
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
					if (is_fully_submerged()) {
						// Start Surfacing
						if (!is_under_ceiling) { grid_move_up(); transition_timer = 8; }
						state = STATES.SURFACE;
						fall_timer = 0;
					}
					else if (!is_grounded()) {
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
					if (is_grounded()) { state = STATES.STILL; }
					else {
						if (is_fully_submerged()) {
							if (array_length(carried_objects) == 0) {
								// Falling Underwater With Nothing Pushing Down
								
								// Reduce Fall Timer
								if (fall_timer > 8) { fall_timer = fall_timer div 2; }
								else { fall_timer -= 4; }
								if (fall_timer < 0) { fall_timer = 0; }
								
								if (fall_timer == 0) {
									// Start Surfacing
									transition_timer = 8;
									state = STATES.SURFACE;
									fall_timer = 0;
								}
								else {
									// Keep Falling
									grid_move_down();
									transition_timer = (fall_timer < 8) ? 8 : 4;
								}
								
							}
							else {
								// Falling Underwater While Being Pushed Down
								
								 // Keep Falling
								 grid_move_down();
								 transition_timer = 4;
							}
						}
						else {
							// Falling While Not Underwater
							
							// Keep Falling
							 grid_move_down();
							 transition_timer = 4;
						}
					}
					
					break;
				}
				case STATES.FLOAT: { swim_timer++; break; }
			}
		
			update_transition_speed();
		}
	}
	else {
		// TODO: don't base this on lack of gravity
		if (transition_timer > 0) {
			transition_timer--;
			if (x != virtual_x) { virtual_move_horizontal(transition_speed * ((x < virtual_x) ? -1 : 1)); }
			else { transition_timer = 0; }
		}
		
		if (transition_timer == 0) {	
			virtual_x = x;
			virtual_y = y;
			
			var _can_move = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
			if (_can_move) {
				if (is_left) { grid_move_left(); }
				else { grid_move_right(); }
				transition_timer = 4;
			}
			else {
				is_left = !is_left;
			}
			
			update_transition_speed();
		}
	}
}
