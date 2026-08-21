#macro FLOAT_OFFSET_PERIOD_FRAMES 32

get_switch_offset = function() {
	if (!is_grounded_state()) { return 0; }
	
	// Get Offset From Ground Objects
	var _ground_objects = get_ground_objects(), _y_offset = 999;
	for (var _i = 0; _i < array_length(_ground_objects); _i++) {
		var _inst = _ground_objects[_i];
		if (instance_exists(_inst) && _inst.is_a(obj_dynamic_object)) {
			with (_inst) {
				_y_offset = min(_y_offset, get_switch_offset());
			}
		}
	}
		
	// Calculate Base Offset Yourself
	if (_y_offset == 999) {
		_y_offset = 0;
		var _potential_objects = get_relative_objects(0, 0,  function(_inst) { return (_inst.x == x && _inst.is_a(obj_switch)); });
		for (var _i = 0; _i < array_length(_potential_objects); _i++) {
			var _inst = _potential_objects[_i], _image_index_offset;
			switch (_inst.image_index) {
				case 0: { _image_index_offset = -2; break; } // -4
				case 1: { _image_index_offset = -3; break; }
				case 2: { _image_index_offset = -2; break; }
			}
			_y_offset = min(_y_offset, _image_index_offset);
		}
	}
	
	return _y_offset;
}

get_float_offset = function() {
	if (!is_grounded_state() && !is_floating_state()) { return 0; }
	
	// Get Offset From Ground Objects
	var _y_offset = 999;
	if (is_grounded_state()) {
		var _ground_objects = get_ground_objects();
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i];
			if (instance_exists(_inst) && _inst.is_a(obj_dynamic_object)) {
				with (_inst) {
					_y_offset = min(_y_offset, get_float_offset());
				}
			}
		}
	}
	// Calculate Base Offset Yourself
	else if (is_floating_state()) { _y_offset = round(get_float_value(swim_timer, 2));
	}
	
	if (_y_offset == 999) { _y_offset = 0; }
	
	return _y_offset;
}


/*
get_float_offset = function() {
	var _amplitude = 2, _period = FLOAT_OFFSET_PERIOD_FRAMES, _swim_bob = round(_amplitude * sin(swim_timer*(2 * pi / _period)));
	var _y_offset = (is_floating_state()) ? _swim_bob : 0;
	if (is_grounded_state()) {
		_y_offset = 999;
		var _ground_objects = get_ground_objects();
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i];
			if (instance_exists(_inst) && is_a(_inst.obj_dynamic_object) && (_inst.is_floating_state() || _inst.is_grounded_state())) {
				with (_inst) {
					_y_offset = min(_y_offset, get_float_offset());
				}
			}
		}
		if (_y_offset == 999) { _y_offset = 0; }
	}
	
	return _y_offset;
}
*/

update_virtual_y_offset = function() {
	if (!is_grounded_state()) { return virtual_y_offset; }
	
	virtual_y_offset = get_switch_offset() + get_float_offset();
}

spawn_contents = function() {
	if (contents != noone) {
		instance_activate_object(contents);
		contents.grid_move_to(x, y);
	}
}

update_last_grid_position = function() {
	if (x_transition_timer == 0 && y_transition_timer == 0) {
		last_grid_x = x;
		last_grid_y = y;
	}
}

// State References
is_grounded_state = function() {
	return (state == PLAYER_STATES.STAND);
}

is_floating_state = function() {
	return state == PLAYER_STATES.SWIM;
}

// Movement Functions
grid_move_up = function(_speed) {
	if (is_under_ceiling() || _speed == 0) { return false; }
	
	if (can_carry_objects) {
		var _carried_objects = get_carried_objects();
		for (var _i = 0; _i < array_length(_carried_objects); _i++) {
			var _inst = _carried_objects[_i];
			_inst.grid_move_up(_speed);
		}
	}

	return grid_move_up_direct(_speed);
}

grid_move_down = function(_speed) {
	if (is_on_ground() || _speed == 0) { return false; }
	
	if (can_carry_objects) {
		var _carried_objects = get_carried_objects();
		for (var _i = 0; _i < array_length(_carried_objects); _i++) {
			var _inst = _carried_objects[_i];
			_inst.grid_move_down(_speed);
		}
	}
	
	return grid_move_down_direct(_speed);
}

grid_move_left = function(_speed) {
	if (is_blocked_on_left() || _speed == 0) { return false; }
	
	if (can_carry_objects) {
		var _carried_objects = get_carried_objects(false);
		for (var _i = 0; _i < array_length(_carried_objects); _i++) {
			var _inst = _carried_objects[_i];
			_inst.grid_move_left(_speed);
		}
	}
	grid_move_to(x - GRID_SIZE, y);
	add_x_transition_timer(abs(GRID_SIZE / _speed));
	
	return true;
}

grid_move_right = function(_speed) {
	if (is_blocked_on_right() || _speed == 0) { return false; }
	
	if (can_carry_objects) {
		var _carried_objects = get_carried_objects(true);
		for (var _i = 0; _i < array_length(_carried_objects); _i++) {
			var _inst = _carried_objects[_i];
			_inst.grid_move_right(_speed);
		}
	}
	
	grid_move_to(x + GRID_SIZE, y);
	add_x_transition_timer(abs(GRID_SIZE / _speed));
	
	return true;
}

grid_move_up_direct = function(_speed) {
	if (_speed == 0) { return false; }
	
	grid_move_to(x, y - GRID_SIZE);
	add_y_transition_timer(abs(GRID_SIZE / _speed));
	return true;
}

grid_move_down_direct = function(_speed) {
	if (_speed == 0) { return false; }
	
	grid_move_to(x, y + GRID_SIZE);
	add_y_transition_timer(abs(GRID_SIZE / _speed));
	return true;
}

grid_move_horizontal = function(_speed) {
	if (_speed < 0) { return grid_move_left(_speed); } 
	else if (_speed > 0) { return grid_move_right(_speed); }
	
	return false;
}

// Get List of Specified Objects
get_carried_objects = function(_sort_x_by_negative = true) {
	// Get All Dynamic Objects Above Current Position
	var _actual_carried_objects = []
	var _possible_carried_objects = get_relative_objects(0, -GRID_SIZE, function(_inst) {
        return _inst.is_a(obj_dynamic_object) && _inst.has_gravity && _inst.is_grounded_state() && _inst.is_on_ground();
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

get_ground_objects = function(_ignored_objects = []) {
	return get_relative_objects(0, GRID_SIZE, function(_inst) {
        return _inst.is_solid_from_above && treat_object_as_solid(_inst);
    }, _ignored_objects);
}

get_left_wall_objects = function(_ignored_objects = []) {
	return get_relative_objects(-GRID_SIZE, 0, function(_inst) {
        return _inst.is_solid_from_right && treat_object_as_solid(_inst);
    }, _ignored_objects);
}

get_right_wall_objects = function(_ignored_objects = []) {
	return get_relative_objects(GRID_SIZE, 0, function(_inst) {
        return _inst.is_solid_from_left && treat_object_as_solid(_inst);
    }, _ignored_objects);
}

get_ceiling_objects = function(_ignored_objects = []) {
	return get_relative_objects(0, -GRID_SIZE, function(_inst) {
        return _inst.is_solid_from_below && treat_object_as_solid(_inst);
    }, _ignored_objects);
}

get_left_ground_objects = function() {
	return get_relative_objects(-GRID_SIZE, GRID_SIZE, function(_inst) {
        return _inst.is_solid_from_above && treat_object_as_solid(_inst);
    });
}

get_right_ground_objects = function() {
	return get_relative_objects(GRID_SIZE, GRID_SIZE, function(_inst) {
        return _inst.is_solid_from_above && treat_object_as_solid(_inst);
    });
}

get_left_pushable_objects = function() {
	return get_relative_objects(-GRID_SIZE, 0, function(_inst) {
        return _inst.can_be_pushed_left();
    });
}

get_right_pushable_objects = function() {
	return get_relative_objects(GRID_SIZE, 0, function(_inst) {
        return _inst.can_be_pushed_right();
    });
}

get_left_climbable_objects = function(_ignored_objects = []) {
	return get_relative_objects(-GRID_SIZE, 0, function(_inst, _ignored) {
        return _inst.can_be_climbed_from_right(_ignored);
    }, _ignored_objects);
}

get_right_climbable_objects = function(_ignored_objects = []) {
	return get_relative_objects(GRID_SIZE, 0, function(_inst, _ignored) {
        return _inst.can_be_climbed_from_left(_ignored);
    }, _ignored_objects);
}

// Boolean Checks
is_on_ground = function(_ignored_objects = []) {
	return (array_length(get_ground_objects(_ignored_objects)) > 0);
}

is_under_ceiling = function(_ignored_objects = []) {
	// TODO: Remove all carried objects resting on self from the is_under_ceiling check
	return (array_length(get_ceiling_objects(_ignored_objects)) > 0);
}

would_be_damaged_by = function(_inst) {
	return ((object_index == obj_player && (_inst.is_powered_player_lethal || (!is_powered_state() && _inst.is_player_lethal))) || (is_a(obj_robot) && _inst.is_robot_lethal));
}

is_blocked_on_left = function(_ignored_objects = []) {
	var _wall_objects = get_left_wall_objects(_ignored_objects);
	return (x <= GRID_SIZE || array_length(_wall_objects) > 0); //((global.original_controls) ? (GRID_SIZE * 2) : GRID_SIZE));
}

is_blocked_on_right = function(_ignored_objects = []) {
	var _wall_objects = get_right_wall_objects(_ignored_objects);
	var _max_x = (room_width - GRID_SIZE - sprite_get_width(sprite_index));
	//if (global.original_controls) { _max_x -= GRID_SIZE; }
	return (x >= _max_x || array_length(_wall_objects) > 0);
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
	if (_pushed_left) { return grid_move_left(1); }
	else { return grid_move_right(1); }
}

is_carrying_key = function() {
	return (contents != noone && contents.object_index == obj_key);
}

get_left_value = function() {
	return ((is_left) ? -1 : 1);
}

get_x_draw_offset = function() {
	return ((is_left) ? sprite_get_width(sprite_index) : 0);
}

// Draw Function
draw_dynamic_object = function(_x_offset = 0, _y_offset = 0, _image_alpha = undefined) {
	_image_alpha ??= image_alpha;
	set_shader_palette((shine_timer == 1) ? PALETTES.ALL_WHITE : main_palette);
	draw_sprite_with_center_rotation(sprite_index, image_index, virtual_x + get_x_draw_offset() + _x_offset, virtual_y + virtual_y_offset + _y_offset, get_left_value(), 1, image_angle, image_blend, _image_alpha);
}

// Step Function
game_object_step = function() {
	if (has_gravity) {
		do_switch_collisions();
			
		if (transition_timer == 0) {
			if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.SURFACE) { fall_timer = 0; }
			if ( state != PLAYER_STATES.SWIM) { swim_timer = 0; }
			
			switch (state) {
				case PLAYER_STATES.STAND: {
					if (is_fully_submerged()) {
						// Start Surfacing
						if (!is_under_ceiling()) { grid_move_up(1); }
						state = PLAYER_STATES.SURFACE;
						fall_timer = 0;
					}
					else if (!is_on_ground()) {
						// Start Falling
						grid_move_down(2);
						state = PLAYER_STATES.FALL;
					}
					else { state = PLAYER_STATES.STAND; }
				
					break;
				}
				case PLAYER_STATES.SURFACE: {
					if (is_fully_submerged()) {
						// Keep Surfacing
						if (!is_under_ceiling()) { grid_move_up((fall_timer < 8) ? 1 : 2); fall_timer += 4; }
					}
					else {
						// Start Floating
						state = PLAYER_STATES.SWIM;
						swim_timer++;
					}
					break;
				}
				case PLAYER_STATES.FALL: {
					if (is_on_ground()) { state = PLAYER_STATES.STAND; }
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
									add_transition_timer(8);
									state = PLAYER_STATES.SURFACE;
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
				case PLAYER_STATES.SWIM: { swim_timer++; break; }
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
	
	if (instance_exists(id)) { update_last_grid_position(); }
}

// Collision Functions
do_switch_collisions = function() {
	if (transition_timer > 0 && !is_grounded_state()) { return; }
	
	var _fully_overlapping_switches = instances_at_grid_position_exact(x, y + GRID_SIZE, sprite_get_width(sprite_index), GRID_SIZE, obj_switch);
	for (var _i = 0; _i < array_length(_fully_overlapping_switches); _i++) {
		var _inst = _fully_overlapping_switches[_i];
		_inst.press_switch();
	}
}


// Transition Timer Functions
reset_transition_timer = function() {
	transition_timer = 0;
	x_transition_timer = 0;
	y_transition_timer = 0;
}

set_transition_timer = function(_amount) {
	transition_timer = _amount;
	sync_transition_timer();
}

add_x_transition_timer = function(_amount) {
	x_transition_timer += _amount;
	sync_transition_timer();
}

add_y_transition_timer = function(_amount) {
	y_transition_timer += _amount;
	sync_transition_timer();
}

sync_transition_timer = function() {
	transition_timer = max(transition_timer, x_transition_timer, y_transition_timer);
}