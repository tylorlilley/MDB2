#macro FLOAT_OFFSET_PERIOD_FRAMES 32

get_switch_offset = function(_ground_objects = undefined) {
	if (!is_grounded_state()) { return 0; }
	
	// Get Offset From Ground Objects
	var _y_offset = 999;
	_ground_objects ??= get_ground_objects();
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
		var _potential_objects = get_relative_overlapping_objects(function(_inst) { return (_inst.x == x && _inst.is_a(obj_switch)); });
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

get_float_offset = function(_ground_objects = undefined) {
	if (!is_grounded_state() && !is_floating_state()) { return 0; }
	
	// Get Offset From Ground Objects
	var _y_offset = 999;
	if (is_grounded_state()) {
		_ground_objects ??= get_ground_objects();
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

get_deformed_offset = function(_ground_objects = undefined) {
	if (!is_grounded_state() && state != PLAYER_STATES.CLIMB) { return 0; }

	var _should_deform = true, _deform_offset = 999;
	_ground_objects ??= (is_grounded_state()) ? get_ground_objects() : [climbed_inst]
	// Check if Player is Only Standing on Deformable Objects
	for (var _i = 0; _i < array_length(_ground_objects); _i++) { 
		var _inst = _ground_objects[_i];
		if (instance_exists(_inst)) {
			if (_inst.deform_level < 1) { return 0; }
			else { _deform_offset = min(_deform_offset, _inst.deform_level); }
		}
	}
	
	// Deform those objects and return offset
	for (var _i = 0; _i < array_length(_ground_objects); _i++) { 
		var _inst = _ground_objects[_i];
		if (instance_exists(_inst)) {
			// Deform Main Set of Blocks
			_inst.set_column_deformed(_deform_offset);
			if (instance_exists(_inst.connected_below)) { _inst.connected_below.set_column_deformed(_deform_offset); }

			// Deform Surrounding Blocks
			if (_deform_offset > 1) {
				// Deform Left
				if (instance_exists(_inst.connected_on_left) && !instance_exists(_inst.connected_on_left.connected_above)) {
					_inst.connected_on_left.set_column_deformed(_deform_offset-1);
					if (instance_exists(_inst.connected_on_left.connected_below)) { _inst.connected_on_left.connected_below.set_column_deformed(_deform_offset-1); }
					if (instance_exists(_inst.connected_on_left.connected_on_left) && !instance_exists(_inst.connected_on_left.connected_on_left.connected_above)) {
						_inst.connected_on_left.connected_on_left.set_column_deformed(_deform_offset-1);
						if (instance_exists(_inst.connected_on_left.connected_on_left.connected_below)) { _inst.connected_on_left.connected_on_left.connected_below.set_column_deformed(_deform_offset-1); }
					}
				}
				// Deform Right
				if (instance_exists(_inst.connected_on_right) && !instance_exists(_inst.connected_on_right.connected_above)) {
					_inst.connected_on_right.set_column_deformed(_deform_offset-1);
					if (instance_exists(_inst.connected_on_right.connected_below)) { _inst.connected_on_right.connected_below.set_column_deformed(_deform_offset-1); }
					if (instance_exists(_inst.connected_on_right.connected_on_right) && !instance_exists(_inst.connected_on_right.connected_on_right.connected_above)) {
						_inst.connected_on_right.connected_on_right.set_column_deformed(_deform_offset-1);
						if (instance_exists(_inst.connected_on_right.connected_on_right.connected_below)) { _inst.connected_on_right.connected_on_right.connected_below.set_column_deformed(_deform_offset-1); }
					}
				}
				// Deform Down
				if (instance_exists(_inst.connected_below)) {
					if (instance_exists(_inst.connected_below.connected_below)) {
						_inst.connected_below.connected_below.set_column_deformed(_deform_offset-1);
						if (instance_exists(_inst.connected_below.connected_below.connected_below)) { _inst.connected_below.connected_below.connected_below.set_column_deformed(_deform_offset-1); }
					}
				}
			}
		}
	}
	
	// Determine Final Offset
	_deform_offset = 999;
	for (var _i = 0; _i < array_length(_ground_objects); _i++) {
		var _inst = _ground_objects[_i];
		if (instance_exists(_inst)) { _deform_offset = min(_deform_offset, _inst.is_deformed_by); }
	}
	if (_deform_offset == 999) { _deform_offset = 0; }
	
	return _deform_offset;
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

create_afterimage = function(_is_dead = false) {
	if (!is_a(obj_player)) { return noone; }
	
	var _is_robot = is_a(obj_robot);
	if (!has_afterimage && (_is_robot || fall_timer <= 10)) { return noone; }
	
	var _img = instance_create(x, y, obj_afterimage);
	_img.sprite_index = sprite_index;
	_img.image_index = image_index;
	_img.main_palette = (_is_robot || _is_dead) ? main_palette : powered_palette;
	_img.is_left = is_left;
	_img.set_dim_timer((_is_dead) ? 64 : ((_is_robot) ? 128 : 32));
	_img.max_alpha = ((_is_robot && !_is_dead) ? 0.325 : 0.625);
		
	return _img;
}

grid_move_up_direct = function(_speed) {
	if (_speed == 0) { return false; }
	
	create_afterimage();
	
	grid_move_to(x, y - GRID_SIZE);
	add_y_transition_timer(abs(GRID_SIZE / _speed));
	return true;
}

grid_move_down_direct = function(_speed) {
	if (_speed == 0) { return false; }
	
	create_afterimage();
	
	grid_move_to(x, y + GRID_SIZE);
	add_y_transition_timer(abs(GRID_SIZE / _speed));
	return true;
}

grid_move_horizontal = function(_speed) {
	if (_speed == 0) { return false; }	

	create_afterimage();
	
	if (_speed < 0) { return grid_move_left(_speed); } 
	else if (_speed > 0) { return grid_move_right(_speed); }
	
	return false;
}

// Get List of Specified Objects
get_carried_objects = function(_sort_x_by_negative = true) {
	// Get All Dynamic Objects Above Current Position
	var _actual_carried_objects = []
	var _possible_carried_objects = get_relative_vertical_objects(true, false, function(_inst) {
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

// Boolean Checks
would_be_damaged_by = function(_inst) { return ((object_index == obj_player && (_inst.is_powered_player_lethal || (!is_powered_state() && _inst.is_player_lethal))) || (is_a(obj_robot) && _inst.is_robot_lethal)); }
is_on_ground = function() { return has_relative_vertical_object(false, is_solid_ground); }
is_under_ceiling = function() { return has_relative_vertical_object(true, is_solid_ceiling); }
is_blocked_on_left = function() { return (x <= GRID_SIZE || has_relative_horizontal_object(true, is_solid_left_wall)); }
is_blocked_on_right = function() { return (x >= (room_width - GRID_SIZE - sprite_get_width(sprite_index)) || has_relative_horizontal_object(false, is_solid_right_wall)); }

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
									set_transition_timer(8);
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
		do_switch_collisions();
		
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