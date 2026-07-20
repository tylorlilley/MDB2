#macro FLOAT_OFFSET_PERIOD_FRAMES 32

get_switch_offset = function() {
	if (!is_grounded_state()) { return 0; }
	
	var _y_offset = 0, _potential_objects = get_relative_objects(0, 0,  function(_inst) { return (_inst.x == x && is_a(_inst, obj_switch)); });
	for (var _i = 0; _i < array_length(_potential_objects); _i++) {
		var _inst = _potential_objects[_i], _image_index_offset;
		switch (_inst.image_index) {
			case 0: { _image_index_offset = -4; break; }
			case 1: { _image_index_offset = -3; break; }
			case 2: { _image_index_offset = -2; break; }
		}
		_y_offset = min(_y_offset, _image_index_offset);
	}
	return _y_offset;
}

get_float_offset = function() {
	var _amplitude = 2, _period = FLOAT_OFFSET_PERIOD_FRAMES, _swim_bob = round(_amplitude * sin(swim_timer*(2 * pi / _period)));
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

spawn_contents = function() {
	if (contents != noone) {
		instance_activate_object(contents);
		contents.grid_move_to(x, y);
	}
}

// State References
is_grounded_state = function() {
	return (state == STATES.PUSHED || state == STATES.STILL);
}

is_floating_state = function() {
	return state == STATES.FLOAT;
}

// Movement Functions
grid_move_up = function(_speed) {
	if (is_under_ceiling() || _speed == 0) { return false; }
	
	var _carried_objects = get_carried_objects();
	for (var _i = 0; _i < array_length(_carried_objects); _i++) {
		var _inst = _carried_objects[_i];
		_inst.grid_move_up(_speed);
	}
	grid_move_to(x, y - 8);
	y_transition_timer += abs(8 / _speed);
	
	return true;
}

grid_move_down = function(_speed) {
	if (is_on_ground() || _speed == 0) { return false; }
	
	var _carried_objects = get_carried_objects();
	for (var _i = 0; _i < array_length(_carried_objects); _i++) {
		var _inst = _carried_objects[_i];
		_inst.grid_move_down(_speed);
	}
	grid_move_to(x, y + 8);
	y_transition_timer += abs(8 / _speed);
	
	return true;
}

grid_move_left = function(_speed) {
	if (is_blocked_on_left() || _speed == 0) { return false; }
	
	var _carried_objects = get_carried_objects(false);
	for (var _i = 0; _i < array_length(_carried_objects); _i++) {
		var _inst = _carried_objects[_i];
		_inst.grid_move_left(_speed);
	}
	grid_move_to(x - 8, y);
	x_transition_timer += abs(8 / _speed);
	
	return true;
}

grid_move_right = function(_speed) {
	if (is_blocked_on_right() || _speed == 0) { return false; }
	
	var _carried_objects = get_carried_objects(true);
	for (var _i = 0; _i < array_length(_carried_objects); _i++) {
		var _inst = _carried_objects[_i];
		_inst.grid_move_right(_speed);
	}
	grid_move_to(x + 8, y);
	x_transition_timer += abs(8 / _speed);
	
	return true;
}

grid_move_up_direct = function(_speed) {
	grid_move_to(x, y - 8);
	y_transition_timer += abs(8 / _speed);
}

grid_move_down_direct = function(_speed) {
	grid_move_to(x, y + 8);
	y_transition_timer += abs(8 / _speed);
}

grid_move_horizontal = function(_speed) {
	if (_speed < 0 && !grid_move_left(_speed)) { return false; }
	else if (_speed > 0 && !grid_move_right(_speed)) { return false; }
	
	return true;
}

// Get List of Specified Objects
get_carried_objects = function(_sort_x_by_negative = true) {
	// Get All Dynamic Objects Above Current Position
	var _actual_carried_objects = []
	var _possible_carried_objects = get_relative_objects(0, -8, function(_inst) {
        return is_a(_inst, obj_dynamic_object) && _inst.has_gravity;
    });
	
	// Weed Out Any Objects Also Resting on Something Else
	for (var _i = 0; _i < array_length(_possible_carried_objects); _i++) {
		var _inst = _possible_carried_objects[_i];
		if (_inst.is_on_ground()) {
			grid_remove();
			if (!_inst.is_on_ground()) { array_push(_actual_carried_objects, _inst); }
			grid_add();
		}
	}
	
	// Sort and Return
	if (_sort_x_by_negative) { array_sort(_actual_carried_objects, function(_a, _b) { return sign(_b.x - _a.x); }); }
	else { array_sort(_actual_carried_objects, function(_a, _b) { return sign(_a.x - _b.x); }); }
	return _actual_carried_objects;
}

get_ground_objects = function() {
	return get_relative_objects(0, 8, function(_inst) {
        return _inst.is_solid_from_above;
    });
}

get_left_wall_objects = function(_ignored_objects = []) {
	return get_relative_objects(-8, 0, function(_inst) {
        return _inst.is_solid_from_right;
    }, _ignored_objects);
}

get_right_wall_objects = function(_ignored_objects = []) {
	return get_relative_objects(8, 0, function(_inst) {
        return _inst.is_solid_from_left;
    }, _ignored_objects);
}

get_ceiling_objects = function() {
	return get_relative_objects(0, -8, function(_inst) {
        return _inst.is_solid_from_below;
    });
}

get_left_ground_objects = function() {
	return get_relative_objects(-8, 8, function(_inst) {
        return _inst.is_solid_from_above;
    });
}

get_right_ground_objects = function() {
	return get_relative_objects(8, 8, function(_inst) {
        return _inst.is_solid_from_above;
    });
}

get_left_pushable_objects = function() {
	return get_relative_objects(-8, 0, function(_inst) {
        return _inst.can_be_pushed_left();
    });
}

get_right_pushable_objects = function() {
	return get_relative_objects(8, 0, function(_inst) {
        return _inst.can_be_pushed_right();
    });
}

get_left_climbable_objects = function(_ignored_objects = []) {
	return get_relative_objects(-8, 0, function(_inst, _ignored) {
        return _inst.can_be_climbed_from_right(_ignored);
    }, _ignored_objects);
}

get_right_climbable_objects = function(_ignored_objects = []) {
	return get_relative_objects(8, 0, function(_inst, _ignored) {
        return _inst.can_be_climbed_from_left(_ignored);
    }, _ignored_objects);
}

// Boolean Checks
is_on_ground = function() {
	return (array_length(get_ground_objects()) > 0);
}

is_under_ceiling = function() {
	return (array_length(get_ceiling_objects()) > 0);
}

is_blocked_on_left = function(_ignored_objects = []) {
	return (array_length(get_left_wall_objects(_ignored_objects)) > 0 || x <= ((global.controller.original_controls) ? 8 : 0));
}

is_blocked_on_right = function(_ignored_objects = []) {
	var _max_x = (room_width - sprite_get_width(sprite_index));
	if (global.controller.original_controls) { _max_x -= 8; }
	return (array_length(get_right_wall_objects(_ignored_objects)) > 0 || x >= _max_x);
}

fully_covered_by = function(_object_index) {
	return at_each_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), _object_index);
}

is_fully_submerged = function() {
	return fully_covered_by(obj_water);
}

is_partially_submerged = function() {
	return (at_grid_position(x, y+sprite_get_height(sprite_index)/2, sprite_get_width(sprite_index), sprite_get_height(sprite_index)/2, obj_water) &&
								!at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index)/2, obj_water));
}

start_being_pushed = function(_pushed_left) {
	// Start Being Pushed
	if (_pushed_left) { grid_move_left(1); }
	else { grid_move_right(1); }
	state = STATES.PUSHED;
}

is_carrying_key = function() {
	return (contents != noone && contents.object_index == obj_key);
}

// Step Function
game_object_step = function() {
	if (has_gravity) {
		if (transition_timer == 0) {
			if (state != STATES.FALLING && state != STATES.SURFACE) { fall_timer = 0; }
			if ( state != STATES.FLOAT) { swim_timer = 0; }
		
			switch (state) {
				case STATES.STILL:
				case STATES.PUSHED: {
					if (is_fully_submerged()) {
						// Start Surfacing
						if (!is_under_ceiling()) { grid_move_up(1); }
						state = STATES.SURFACE;
						fall_timer = 0;
					}
					else if (!is_on_ground()) {
						// Start Falling
						grid_move_down(2);
						state = STATES.FALLING;
					}
					else { state = STATES.STILL; }
				
					break;
				}
				case STATES.SURFACE: {
					if (is_fully_submerged()) {
						// Keep Surfacing
						if (!is_under_ceiling()) { grid_move_up((fall_timer < 8) ? 1 : 2); fall_timer += 4; }
					}
					else {
						// Start Floating
						state = STATES.FLOAT;
						swim_timer++;
					}
					break;
				}
				case STATES.FALLING: {
					if (is_on_ground()) { state = STATES.STILL; }
					else {
						if (is_fully_submerged()) {
							if (array_length(get_carried_objects(is_left)) == 0) {
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
									grid_move_down((fall_timer < 8) ? 1 : 2);
								}
								
							}
							else {
								// Falling Underwater While Being Pushed Down
								
								 // Keep Falling
								 grid_move_down(2);
							}
						}
						else {
							// Falling While Not Underwater
							
							// Keep Falling
							 grid_move_down(2);
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
		if (transition_timer == 0) {	
			var _can_move = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
			if (_can_move) {
				if (is_left) { grid_move_left(2); }
				else { grid_move_right(2); }
			}
			else {
				is_left = !is_left;
			}
		}
	}
}
