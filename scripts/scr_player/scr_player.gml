enum PLAYER_STATES
{
	// Grounded States
	STAND,
	WALK,
	TURN,
	PUSH,
	PUSH_WALK,
	CROUCH,
	POWERCROUCH,
	// Non-Grounded States
	HOP,
	HOP_UP,
	FLY, // Currently Unused
	POWERFLY,
	FALL,
	POWERFALL,
	LAND,
	CLIMB,
	LADDER,
	LADDER_UP,
	LADDER_DOWN
}

enum CAPE_STATES
{
	STAND,
	CROUCH,
	FLUTTER,
	STOP_FLUTTER,
	TURN,
	LADDER,
	FALL_TO_LADDER,
	FLY,
	FALL_START,
	FALL,
}

function player_state_to_string(state) {
	var _player_state_string = "UNKNOWN STATE"
	switch (state) {
		case PLAYER_STATES.STAND: { _player_state_string = "Stand"; break; }
		case PLAYER_STATES.WALK: { _player_state_string = "Walk"; break; }
		case PLAYER_STATES.TURN: { _player_state_string = "Turn"; break; }
		case PLAYER_STATES.PUSH: { _player_state_string = "Push Stand"; break; }
		case PLAYER_STATES.PUSH_WALK: { _player_state_string = "Push Walk"; break; }
		case PLAYER_STATES.CROUCH: { _player_state_string = "Crouch";break; }
		case PLAYER_STATES.POWERCROUCH: { _player_state_string = "Power Crouch";break; }
		case PLAYER_STATES.FLY: { _player_state_string = "Fly"; break; }
		case PLAYER_STATES.POWERFLY: { _player_state_string = "Power Fly"; break; }
		case PLAYER_STATES.FALL: { _player_state_string = "Fall"; break; }
		case PLAYER_STATES.POWERFALL: { _player_state_string = "Power Fall"; break; }
		case PLAYER_STATES.LAND: { _player_state_string = "Land"; break; }
		case PLAYER_STATES.CLIMB: { _player_state_string = "Climb"; break; }
		case PLAYER_STATES.LADDER: { _player_state_string = "Ladder"; break; }
		case PLAYER_STATES.LADDER_UP: { _player_state_string = "Ladder Up"; break; }
		case PLAYER_STATES.LADDER_DOWN: { _player_state_string = "Ladder Down"; break; }
		case PLAYER_STATES.HOP: { _player_state_string = "Hop"; break; }
		case PLAYER_STATES.HOP_UP: { _player_state_string = "Hop Up" break; }
	}
	return _player_state_string;
}

function player_init() {
	// Game Object Variables
	has_gravity = true;
	is_ground = true;
	is_ceiling = false;
	is_right_wall = false;
	is_left_wall = false;
	is_left = true;
	
	cape_state = CAPE_STATES.STAND;
	cape_sprite_index = spr_cape_stand;
	cape_image_index = 0;
	cape_timer = 0;
	step_index = 0;
	air_walk = false;
	dazed = true;
	holding_obj = false;
	prev_holding_obj = false;
	
	// Player Specific Variables
	prev_state = PLAYER_STATES.STAND;
	state = PLAYER_STATES.STAND;
	image_speed = 0;
	depth = -2;
	cape_x = x;
	cape_y = y;
	cape_depth = 1;
	virtual_x = x;
	virtual_y = y;
	transition_timer = 0;
	animation_timer = 0;
	ring_out_timer = 0;
	
	crouch_timer = 0;
	fly_timer = 0;
	idle_timer = 0;
	
	
	pushed_obj = noone;
	
	is_grounded_state = function() {
		return state < PLAYER_STATES.FLY;
	}
	
	is_ladder_state = function() {
		return (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN)
	}
	
	is_fly_state = function() {
		return (state == PLAYER_STATES.FLY || state == PLAYER_STATES.POWERFLY)
	}
	
	is_fall_state = function() {
		return (state == PLAYER_STATES.FALL || state == PLAYER_STATES.POWERFALL)
	}
	
	is_crouch_state = function() {
		return (state == PLAYER_STATES.CROUCH || state == PLAYER_STATES.POWERCROUCH)
	}
	
	is_crouch_state = function() {
		return (state == PLAYER_STATES.CROUCH || state == PLAYER_STATES.POWERCROUCH)
	}
	
	reset_controls = function() {
		key_left = false;
		key_right = false;
		key_up = false;
		key_down = false;
		key_jump = false;
	}
	
	update_controls = function() {
		key_left = key_left || keyboard_check(vk_left);
		key_right = key_right || keyboard_check(vk_right);
		key_up = key_up || keyboard_check(vk_up);
		key_down = key_down || keyboard_check(vk_down);
		key_jump = key_jump || keyboard_check(ord("Z"));
		
		// Cancel out opposite inputs
		if (key_left && key_right) {
			if (is_left) { key_right = false; }
			else { key_left = false; }
		}
		if (key_up && key_down) {
			if (is_up) { key_down = false; }
			else { key_up = false; }
		}
	}
	
	start_falling = function() {
		holding_obj = false;
		prev_holding_obj = false;
		state =  PLAYER_STATES.FALL;
		fall_timer = 0;
		transition_timer = 4;
		grid_step_down();
	}
	
	start_standing = function() {
		if (is_grounded()) {
			state = (key_down) ? PLAYER_STATES.CROUCH : PLAYER_STATES.STAND;
			transition_timer = 0;
			dazed = false;
			air_walk = false;
			if (key_left || key_right) { is_left = key_left; }
			else if (holding_obj) { sprite_index = spr_player_hold_idle; }
			else if (key_up) { idle_timer = 0; sprite_index = spr_player_look_up; }
			else { sprite_index = spr_player_idle; }
		}
		else { start_falling(); }
	}
	
	start_walking = function() {
		// First, walk on next object
		if (is_grounded() || air_walk) {
			// Attempt to Land on Ground
			var _left_ground_objects = get_solid_objects_at(x - 8, y + 16, 8, 8, function(inst) { return inst.is_solid_from_above(); });
			var _right_ground_objects = get_solid_objects_at(x + 16, y + 16, 8, 8, function(inst) { return inst.is_solid_from_above(); });
			var _ground_objects = (is_left) ? _left_ground_objects : _right_ground_objects;
			for (var _i = 0; _i < array_length(_ground_objects); _i++) {
				var _inst = _ground_objects[_i]
				 _inst.walk_on();
			}
		}
		
		// Continue with Walking or Fall
		if (is_grounded() || air_walk) {
			state = PLAYER_STATES.WALK;
			transition_timer = (holding_obj) ? 16 : 4;
			grid_step_horizontal();
		}
		else { start_falling(); }
	}
	
	start_hopping = function(_should_move_horizontally = false) {
		//virtual_y -= 4;
		state = PLAYER_STATES.HOP_UP;
		transition_timer = 8;
		if (_should_move_horizontally) { grid_step_horizontal(); }
		grid_step_up();
	}
	
	reset_controls()
}

function update_player_state() {
	prev_state = state;
	var _prev_virtual_x = virtual_x
	var _in_ground = at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_solid); // TODO This reacts to all solids regardless of one-way status
	var _prev_is_left = is_left;
	
	// Check Controls
	reset_controls();
	update_controls();

	// Reset various player state timers
	if (!is_ladder_state()) { is_up = false; }
	if (state != PLAYER_STATES.CROUCH && state != PLAYER_STATES.POWERCROUCH) { crouch_timer = 0; }
	if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.POWERFALL) { fall_timer = 0; }
	if (state != PLAYER_STATES.FLY && state != PLAYER_STATES.POWERFLY) { fly_timer = 0; }
	if (state != PLAYER_STATES.STAND && prev_state != PLAYER_STATES.STAND) { idle_timer = 0; }
	
	// While Transitioning
	if (transition_timer > 0) {
		transition_timer--;

		switch (state) {
			case PLAYER_STATES.HOP:
			case PLAYER_STATES.HOP_UP: {
				var _move_fast = (state == PLAYER_STATES.HOP_UP && transition_timer >= 6) || (state == PLAYER_STATES.HOP && transition_timer <= 2);
				var _move_slow = (state == PLAYER_STATES.HOP_UP && transition_timer >= 2) || (state == PLAYER_STATES.HOP && transition_timer <= 6);
				var _move_none = (state == PLAYER_STATES.HOP_UP && transition_timer >= 0) || (state == PLAYER_STATES.HOP && transition_timer <= 8);
				
				var _y_move = 0;
				if (_move_fast) { _y_move = 2; }
				else if (_move_slow) { _y_move = 1; }
				else if (_move_none) { _y_move = 0; }
				
				virtual_y += _y_move * ((state == PLAYER_STATES.HOP_UP) ? -1 : 1);
				if (virtual_x > x) { virtual_x -= 1; }
				else if (virtual_x < x) { virtual_x += 1; }
				
				break;
			}
			case PLAYER_STATES.WALK:  {
				virtual_x += ((is_left) ? -1 : 1) * ((holding_obj) ? 0.5 : 2);

				break;
			}
			case PLAYER_STATES.PUSH_WALK: {
				virtual_x += (is_left) ? -1 : 1;
				if (instance_exists(pushed_obj)) { pushed_obj.virtual_x += (is_left) ? -1 : 1; }
				
				break;
			}
			case PLAYER_STATES.FLY:
			case PLAYER_STATES.POWERFLY: { virtual_y -= 2; fly_timer++; break; }
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.POWERFALL: { virtual_y += 2; fall_timer++; break; }
			case PLAYER_STATES.LADDER_UP: { virtual_y -= 1; break; } 
			case PLAYER_STATES.LADDER_DOWN: { virtual_y += 1; break; }
			case PLAYER_STATES.TURN: { if (transition_timer == 0) { is_left = !is_left; }  break; }
			case PLAYER_STATES.LADDER: { break; }
			case PLAYER_STATES.LAND: { break; }
			case PLAYER_STATES.CLIMB: {
				if (transition_timer < 28 && transition_timer >= 24) {
					virtual_y -= 2; if (virtual_y == y) { grid_step_up(); }
				}
				else if (transition_timer < 24 && transition_timer >= 22) {
					virtual_y -= 1;
				}
				else if (transition_timer < 22 && transition_timer >= 20) {
					virtual_y -= 1;
					virtual_x += (is_left) ? -1 : 1;
				}
				else if (transition_timer < 20 && transition_timer >= 18) {

					if (transition_timer == 19) {
						grid_step_horizontal();
					}
					else {
						virtual_x += (is_left) ? -2 : 2;
					}
				}
				else if (transition_timer < 18 && transition_timer >= 16) {
					if (transition_timer == 16) {
						virtual_y -= 2;
					}
				}
				else if (transition_timer < 16 && transition_timer >= 14) {
					if (transition_timer == 14) {
						virtual_x += (is_left) ? -2 : 2;
						virtual_y -= 2;
					}
				}
				else if (transition_timer < 14 && transition_timer >= 12) {
					if (transition_timer == 12) {
						virtual_x += (is_left) ? -2 : 2;
					}
				}
				else if (transition_timer < 6) { transition_timer = 0; }
				
				break;
			}
			default: {
				show_debug_message("ERROR: Transition Timer Running for state: " + player_state_to_string(state));
				break;
			}
		}
	}
	
	// While Not Transitioning
	if (transition_timer == 0) {
		virtual_x = x;
		virtual_y = y;
		pushed_obj = noone;
		
		if (state == PLAYER_STATES.STAND && prev_state == PLAYER_STATES.STAND) { idle_timer++; }
		
		// Handle Ladder Mount/Dismount First
		if (state != PLAYER_STATES.LADDER &&
			state != PLAYER_STATES.LADDER_UP &&
			state != PLAYER_STATES.LADDER_DOWN &&
			can_start_laddering() &&
			((key_up && can_ladder_up()) || (key_down && can_ladder_down()))) { 
			   state = PLAYER_STATES.LADDER;
			   transition_timer = 4; 
		}
		if (transition_timer == 0 && (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN)) {
			if (!instance_exists(get_closest_ladder())) { 
				state = PLAYER_STATES.FALL; // Not using start_standing or start_falling so as to not move it twice in one frame when the below switch statement kicks in
			}
			else {
				// Determine Next State
				if (key_up) { is_up = true; state = PLAYER_STATES.LADDER_UP; }
				else if (key_down) { is_up = false; state = PLAYER_STATES.LADDER_DOWN; }
				else if ((key_left || key_right) && (is_grounded() && !_in_ground)) { start_standing(); }
				else { state = PLAYER_STATES.LADDER; }
			}
		}
	
		switch (state) {
			case PLAYER_STATES.LAND: {
				start_standing();
				break;
			}
			case PLAYER_STATES.HOP_UP: {
				var _can_walk = ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right());
				var _horizontal_input = ((is_left && key_left) || (!is_left && key_right));
				var _on_hop_height_ground = false, _prev_x = x, _prev_y = y;
				grid_step_horizontal();
				_on_hop_height_ground = is_grounded();
				grid_move_to(_prev_x, _prev_y);
				
				if (is_grounded()) { start_standing(); }
				if (_on_hop_height_ground && _can_walk && _horizontal_input) {
					air_walk = true;
					start_walking();
				}
				else {
					var _can_climb = (key_jump || key_up) && !is_under_ceiling();
					var _climbable_objects = (is_left) ? get_left_climbable_objects() : get_right_climbable_objects();
					var _climbed_obj = grid_array_first(_climbable_objects);
					_can_climb = _can_climb && instance_exists(_climbed_obj) && y < _climbed_obj.y;
					
					if (_can_climb && _horizontal_input) { 
						state = PLAYER_STATES.CLIMB;
						transition_timer = 24;
						grid_step_up();
					}
					else {
						state = PLAYER_STATES.HOP;
						transition_timer = 8;
						if (_can_walk && _prev_virtual_x != virtual_x) {
							grid_step_horizontal();
						}
						grid_step_down();
					}
				}
				break;
			}
			case PLAYER_STATES.HOP:
			case PLAYER_STATES.STAND:
			case PLAYER_STATES.WALK:
			case PLAYER_STATES.PUSH:
			case PLAYER_STATES.PUSH_WALK:
			case PLAYER_STATES.CROUCH:
			case PLAYER_STATES.TURN:
			case PLAYER_STATES.POWERCROUCH: {
				if (!is_grounded()) {
					start_falling();
				}
				else {
					// Update Whether Holding Up Objects
					prev_holding_obj = holding_obj;
					holding_obj = false;
					var _ceiling_objects = get_ceiling_objects();
					for (var _i = 0; _i < array_length(_ceiling_objects); _i++) {
						var _inst = _ceiling_objects[_i];
						if (instance_exists(_inst) && _inst.has_gravity && _inst.is_grounded()) {
							is_ground = false;
							if (!_inst.is_grounded() && _inst.state != STATES.FALLING) { holding_obj = true; }
							is_ground = true;
						}
					}
					
						
					if (state == PLAYER_STATES.HOP) {
						start_standing();
						transition_timer = 4;
						var _ground_objects = get_ground_objects();
						for (var _i = 0; _i < array_length(_ground_objects); _i++) {
							var _inst = _ground_objects[_i];
							if (instance_exists(_inst) && _inst.is_solid_from_above()) { _inst.fall_on(); }
						}
					}
					else if (state == PLAYER_STATES.WALK && air_walk) {
						start_standing();
						transition_timer = 4;
					}
					else if (holding_obj) {
						is_left = key_left;
						var _can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
						
						if (_can_walk && (key_left || key_right)) { start_walking(); }
						else { start_standing(); }
					}
					else if (key_left || key_right) {
						is_left = key_left;
						
						if ((prev_state == PLAYER_STATES.WALK || prev_state == PLAYER_STATES.PUSH_WALK || prev_state == PLAYER_STATES.PUSH) && is_left != _prev_is_left) {
							state = PLAYER_STATES.TURN;
							transition_timer = 4;
							is_left = _prev_is_left;
						}
						else {
							var _can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
							var _more_ceiling_objects = (key_left) ? get_left_ceiling_objects() : get_right_ceiling_objects(), _under_more_ceiling = array_length(_more_ceiling_objects) != 0;
							var _can_hop = (key_up || key_jump) && !is_under_ceiling();
							
							var _can_hop_up = _can_hop, _can_hop_forward = _can_walk && _can_hop && !_under_more_ceiling;
							
							if (_can_hop_forward) {
								start_hopping(_can_hop_forward);
							}
							else if (_can_walk) {
								start_walking();
							}
							else if (_can_hop_up) {
								start_hopping(_can_hop_forward);
							}
							else { 
								var _climbable_objects = (is_left) ? get_left_climbable_objects() : get_right_climbable_objects();
						
								if ((array_length(_climbable_objects) > 0) && (key_up || key_jump) && !is_under_ceiling()) {
									// Climb Wall
									/*
									transition_timer = 28;
									y -= 8;
									state = PLAYER_STATES.CLIMB;
									*/
								}
								else {
									// Push Wall
									var _pushable_objects = is_left ? get_left_pushable_objects() : get_right_pushable_objects();
									pushed_obj = grid_array_first(_pushable_objects);
									
									if (instance_exists(pushed_obj)) {
										pushed_obj.grid_remove();
										_can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
										pushed_obj.grid_add();
									}
									else { _can_walk = false; }

									if (_can_walk && y == pushed_obj.y) {
										// Push Box
										state = PLAYER_STATES.PUSH_WALK;
										grid_step_horizontal();
										transition_timer = 8;
										pushed_obj.is_left = is_left;
										with (pushed_obj) {
											state = STATES.PUSHED;
											transition_timer = 8;
											grid_step_horizontal();
										}
									}
									else {
										// Push Against Solid Wall
										pushed_obj = noone;
										state = PLAYER_STATES.PUSH;
									}
								}
							}
						}
					}
					else if (key_up || key_jump) {
						if (is_under_ceiling()) { start_standing(); }
						else {
							if (state == PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.POWERFLY; transition_timer = 4; grid_step_up(); }
							else { start_hopping(); }
						}
					}
					else if (key_down) {
						if (state == PLAYER_STATES.CROUCH) { crouch_timer++; }
						else if (state != PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.CROUCH; }

						if (crouch_timer == 32) { state = PLAYER_STATES.POWERCROUCH; }
					}
					else {
						if (state == PLAYER_STATES.CROUCH && !key_down) {
							// Hello
							var _isducking = true;
						}
						start_standing();
					}
				}
			
				break;
			}
			case PLAYER_STATES.FLY:
			case PLAYER_STATES.POWERFLY: {
				// First, fly into ceiilng objects
				if (is_under_ceiling()) {
					// Attempt to Bump Ceiling
					var _ceiling_objects = get_ceiling_objects();
					for (var _i = 0; _i < array_length(_ceiling_objects); _i++) {
						var _inst = _ceiling_objects[_i];
						_inst.fly_into();
					}
				}
				
				// If still under ceiling, collide with them
				if (is_under_ceiling()) {
					if (state == PLAYER_STATES.POWERFLY) {
						// Get Targets to Damage
						var _damaged_instances = []
						for (var _dir = 0; _dir < 2; _dir++) {
							var _x_offset = (_dir == 1) ? 8 : 0, _y_offset = -8;
							
							var _instances_to_check = instances_at_grid_position(x+_x_offset, y+_y_offset, 8, 8);
							for (var _i = 0; _i < array_length(_instances_to_check); _i++) {
								var _inst =  _instances_to_check[_i]
								if (_inst.is_ceiling && _inst.id != id && !array_contains(_damaged_instances, _inst.id)) {
									array_push(_damaged_instances, _inst.id);
								}
							}
						}
						
						// Damage Targets
						while (array_length(_damaged_instances) > 0) {
							var _inst = grid_array_first(_damaged_instances);
							array_delete(_damaged_instances, 0, 1);
							if (instance_exists(_inst)) {
								if (_inst.is_connected) {
									// Remove any connected instances from list of instances to damage
									var _connected_instances = _inst.get_connected_instances([_inst.id])
									for (var _i = 0; _i < array_length(_connected_instances); _i++) {
										var _connected_inst = _connected_instances[_i]
										var _index = array_get_index(_damaged_instances, _connected_inst.id);
										if (_index >= 0) { array_delete(_damaged_instances, _index, 1); }
									}
								}
								else if (object_is_ancestor(_inst.object_index, obj_solid_area) && abs(y - _inst.y) <= 8) {
									// Damage deeper for connected areas
									var _instances_to_check = instances_at_grid_position(_inst.x, _inst.y-8, 8, 8);
									for (var _i = 0; _i < array_length(_instances_to_check); _i++) {
										var _new_inst =  _instances_to_check[_i]
										if (_new_inst.object_index == _inst.object_index && _new_inst.is_ceiling && _new_inst.id != id && !array_contains(_damaged_instances, _new_inst.id)) {
											array_push(_damaged_instances, _new_inst.id);
										}
									}
								}
								_inst.powerfly_into(); 
							}
						}
						
						// Player reaction to Collision
						virtual_y = y;
						start_falling();
						dazed = true;
					}
					else { start_falling(); }
				}
				else {
					// Keep Flying
					grid_step_up();
					transition_timer = 4;
					fly_timer++;
					if (fly_timer >= 16) { state = PLAYER_STATES.POWERFLY; }
				}
				break;
			}
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.POWERFALL: {
				// First, land on ground objects
				if (is_grounded()) {
					// Attempt to Land on Ground
					var _ground_objects = get_ground_objects();
					for (var _i = 0; _i < array_length(_ground_objects); _i++) {
						var _inst = _ground_objects[_i];
						_inst.fall_on();
					}
				}
				
				if (is_grounded()) {
					// Bonk against floor
					if (state == PLAYER_STATES.POWERFALL) {
						// Get Targets to Damage
						var _damaged_instances = [], _check_deeper_right = false, _check_deeper_left = false;
						for (var _dir = 0; _dir < 2; _dir++) {
							var _x_offset = (_dir == 1) ? 8 : 0, _y_offset = 16;
							
							var _instances_to_check = instances_at_grid_position(x+_x_offset, y+_y_offset, 8, 8);
							for (var _i = 0; _i < array_length(_instances_to_check); _i++) {
								var _inst =  _instances_to_check[_i]
								if (_inst.is_ground && _inst.id != id && !array_contains(_damaged_instances, _inst.id)) {
									array_push(_damaged_instances, _inst.id);
								}
							}
						}
						
						// Damage Targets
						while (array_length(_damaged_instances) > 0) {
							var _inst = grid_array_first(_damaged_instances);
							array_delete(_damaged_instances, 0, 1);
							if (instance_exists(_inst)) {
								if (_inst.is_connected) {
									// Remove any connected instances from list of instances to damage
									var _connected_instances = _inst.get_connected_instances([_inst.id])
									for (var _i = 0; _i < array_length(_connected_instances); _i++) {
										var _connected_inst = _connected_instances[_i]
										var _index = array_get_index(_damaged_instances, _connected_inst.id);
										if (_index >= 0) { array_delete(_damaged_instances, _index, 1); }
									}
								}
								else if (object_is_ancestor(_inst.object_index, obj_solid_area) && abs(y - _inst.y) <= 16) {
									// Damage deeper for connected areas
									var _instances_to_check = instances_at_grid_position(_inst.x, _inst.y+8, 8, 8);
									for (var _i = 0; _i < array_length(_instances_to_check); _i++) {
										var _new_inst =  _instances_to_check[_i]
										if (_new_inst.object_index == _inst.object_index && _new_inst.is_ground && _new_inst.id != id && !array_contains(_damaged_instances, _new_inst.id)) {
											array_push(_damaged_instances, _new_inst.id);
										}
									}
								}
								_inst.powerfall_on(); 
							}
						}
						
						// Player reaction to landing
						if (!is_under_ceiling()) { grid_step_up(); }
						if (!is_under_ceiling()) { grid_step_up(); }
						virtual_y = y;
						start_falling();
					}
					else if (fall_timer < 10) { start_standing(); }
					else {
						// Landing Delay for Tumbling animation
						if (key_left || key_right) { is_left = key_left; }
						state = PLAYER_STATES.LAND;
						transition_timer = 8;
					}
				}
				else {
					// Keep Falling
					grid_step_down();
					transition_timer = 4;
					fall_timer++;
					if (fall_timer >= 16 && !dazed) { state = PLAYER_STATES.POWERFALL; }
				}
				break;
			}
			case PLAYER_STATES.LADDER:
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {	
				if (transition_timer == 0) { // This is because we add some timer lag when first grabbing the ladder
					if (key_up && can_ladder_up()) {
						grid_step_up();
						transition_timer = 8;	
						state = PLAYER_STATES.LADDER_UP;
					}
					else if (key_down && can_ladder_down()) {
						grid_step_down();
						transition_timer = 8;	
						state = PLAYER_STATES.LADDER_DOWN;
					}
				}
				break;
			}
			case PLAYER_STATES.CLIMB: {
				start_standing();
				break;
			}
			default: {
				show_debug_message("ERROR: Unknown State: " + player_state_to_string(state));
				break;
			}
		}
		
		reset_controls();
	}
	
	// Update player position for moving platforms
	// TODO
}

function update_cape_graphics() {
	// Update Cape State
	if (cape_timer > 0) {
		cape_timer--;
		if (cape_timer % 2 == 0) { cape_image_index++; }
		if (cape_image_index >= 4) { cape_image_index = 0; }
	}
	
	// Set New Cape State Only After Current Animation Finishes
	if (cape_timer == 0) {
		switch (cape_state) {
			case CAPE_STATES.FLUTTER:
			case CAPE_STATES.TURN: {
				if (state == PLAYER_STATES.WALK) {
					cape_state = CAPE_STATES.FLUTTER;
					cape_sprite_index = spr_cape_flutter;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.POWERFALL) {
					cape_state = CAPE_STATES.FALL_START;
					cape_sprite_index = spr_cape_fall_start;
					cape_image_index = 0;
					cape_timer = 4;
				}
				else if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN) {
					cape_state = CAPE_STATES.FALL_TO_LADDER;
					cape_sprite_index = spr_cape_fall_to_ladder;
					cape_image_index = 2;
					cape_timer = 4;
				}
				else { //if (state == PLAYER_STATES.STAND || state == PLAYER_STATES.CROUCH || state == PLAYER_STATES.POWERCROUCH) {
					cape_state = CAPE_STATES.STOP_FLUTTER;
					cape_sprite_index = spr_cape_stop_flutter;
					cape_image_index = 0;
					cape_timer = 4;
				}
				break;
			}
			case CAPE_STATES.STOP_FLUTTER:
			case CAPE_STATES.STAND:
			case CAPE_STATES.CROUCH: {
				if (state == PLAYER_STATES.WALK) {
					if (holding_obj) {
						cape_state = CAPE_STATES.STAND;
						cape_sprite_index = spr_cape_hold;
						cape_image_index = 0;
						cape_timer = 0;
					}
					else {
						cape_state = CAPE_STATES.FLUTTER;
						cape_sprite_index = spr_cape_flutter;
						cape_image_index = 0;
						cape_timer = 8;
					}
				}
				else if (state == PLAYER_STATES.STAND || state == PLAYER_STATES.PUSH || state == PLAYER_STATES.PUSH_WALK) {
					cape_state = CAPE_STATES.STAND;
					cape_sprite_index = (holding_obj) ? spr_cape_hold : spr_cape_stand;
					cape_image_index = 0;
					cape_timer = 0;
				}
				else if (state == PLAYER_STATES.CROUCH || state == PLAYER_STATES.POWERCROUCH) {
					cape_state = CAPE_STATES.CROUCH;
					cape_sprite_index = spr_cape_crouch;
					cape_image_index = 0;
					cape_timer = 0;
				}
				else if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN) {
					cape_state = CAPE_STATES.LADDER;
					cape_sprite_index = spr_cape_ladder;
					cape_image_index = 0;
					cape_timer = 0;
				}
				else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.POWERFALL) {
					cape_state = CAPE_STATES.FALL_START;
					cape_sprite_index = spr_cape_fall_start;
					cape_image_index = 0;
					cape_timer = 4;
				}
				break;
			}
			case CAPE_STATES.FLY: {
				if (cape_state == CAPE_STATES.FLY) {
					if (state == PLAYER_STATES.FLY || state == PLAYER_STATES.POWERFLY) {
						cape_state = CAPE_STATES.FLY;
						cape_sprite_index = spr_cape_fly;
						cape_image_index = 0;
						cape_timer = 8;
					}
					else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.POWERFALL) {
						cape_state = CAPE_STATES.FALL_START;
						cape_sprite_index = spr_cape_fall_start;
						cape_image_index = 0;
						cape_timer = 4;
					}
					else if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN) {
						cape_state = CAPE_STATES.LADDER;
						cape_sprite_index = spr_cape_ladder;
						cape_image_index = 0;
						cape_timer = 0;
					}
				}
				break;
			}
			case CAPE_STATES.FALL_START: {
				if (state == PLAYER_STATES.FALL) {
					cape_state = CAPE_STATES.FALL;
					cape_sprite_index = spr_cape_fall;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else if (state == PLAYER_STATES.LAND) {
					cape_state = CAPE_STATES.STOP_FLUTTER;
					cape_sprite_index = spr_cape_stop_flutter;
					cape_image_index = 0;
					cape_timer = 4;
				}
				else if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN) {
					cape_state = CAPE_STATES.FALL_TO_LADDER;
					cape_sprite_index = spr_cape_fall_to_ladder;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else {
					cape_state = CAPE_STATES.STOP_FLUTTER;
					cape_sprite_index = spr_cape_stop_flutter;
					cape_image_index = 0;
					cape_timer = 4;
				}
				break;
			}
			case CAPE_STATES.FALL_TO_LADDER: {
				if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN) {
					cape_state = CAPE_STATES.LADDER;
					cape_sprite_index = spr_cape_ladder;
					cape_image_index = 0;
					cape_timer = 0;
				}
				else {
					cape_state = CAPE_STATES.STOP_FLUTTER;
					cape_sprite_index = spr_cape_stop_flutter;
					cape_image_index = 0;
					cape_timer = 4;
				}
				break;
			}
			case CAPE_STATES.FALL: {
				if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.POWERFALL) {
					cape_state = CAPE_STATES.FALL;
					cape_sprite_index = spr_cape_fall;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else {
					cape_state = CAPE_STATES.STOP_FLUTTER;
					cape_sprite_index = spr_cape_stop_flutter;
					cape_image_index = 0;
					cape_timer = 4;
				}
				break;
			}
			default: {
				if (state != PLAYER_STATES.LADDER &&
					state != PLAYER_STATES.LADDER_UP &&
					state != PLAYER_STATES.LADDER_DOWN) {
					cape_state = CAPE_STATES.STAND;
					cape_sprite_index = spr_cape_stand;
					cape_image_index = 0;
					cape_timer = 0;
				}
				break;
			}
		}
	}
	
	// Interrupt Previous Cape State to Set New One
	if (state != prev_state) {
		if (state == PLAYER_STATES.HOP_UP) {
			cape_state = CAPE_STATES.STOP_FLUTTER;
			cape_sprite_index = spr_cape_stop_flutter;
			cape_image_index = 0;
			cape_timer = 4;
		}
		else if (state == PLAYER_STATES.HOP) {
			cape_state = CAPE_STATES.FLUTTER;
			cape_sprite_index = spr_cape_flutter;
			cape_image_index = 0;
			cape_timer = 8;
		}
		else if (state == PLAYER_STATES.TURN) {
			cape_state = CAPE_STATES.TURN;
			cape_sprite_index = spr_cape_turn;
			cape_image_index = 0;
			cape_timer = 4;
		}
		else if (state == PLAYER_STATES.FLY || state == PLAYER_STATES.POWERFLY) {
			if (cape_state != CAPE_STATES.FLY) {
				cape_state = CAPE_STATES.FLY;
				cape_sprite_index = spr_cape_fly;
				cape_image_index = 0;
				cape_timer = 8;
			}
		}
		else if (state == PLAYER_STATES.FALL) {
			cape_state = CAPE_STATES.FALL_START;
			cape_sprite_index = spr_cape_fall_start;
			cape_image_index = 0;
			cape_timer = 4;
		}
		else if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.POWERFALL && prev_state == PLAYER_STATES.FALL) {
			cape_state = CAPE_STATES.STOP_FLUTTER;
			cape_sprite_index = spr_cape_stop_flutter;
			cape_image_index = 0;
			cape_timer = 4;
		}
		else if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN) {
			if (cape_state == CAPE_STATES.FLUTTER || cape_state == CAPE_STATES.FALL) {
				cape_state = CAPE_STATES.FALL_TO_LADDER;
				cape_sprite_index = spr_cape_fall_to_ladder;
				cape_image_index = 2;
				cape_timer = 4;
			}
			else if (cape_state != CAPE_STATES.FALL_TO_LADDER) {
				cape_state = CAPE_STATES.LADDER;
				cape_sprite_index = spr_cape_ladder;
				cape_image_index = 0;
				cape_timer = 0;
			}
		}
	}

	// Update Cape Depth Relative to Player
	switch (state) {
		case PLAYER_STATES.FALL: {
			if (sprite_index == spr_player_tumble && image_index > 0) { cape_depth = depth - 1; }
			else { cape_depth = depth + 1; }
			break;
		}
		case PLAYER_STATES.LADDER:
		case PLAYER_STATES.LADDER_UP:
		case PLAYER_STATES.LADDER_DOWN:
		case PLAYER_STATES.POWERFALL: {
			cape_depth = depth - 1;
			break;
		}
		default: {
			cape_depth = depth + 1;
			break;
		}
	}
}

function update_player_graphics() {
	image_xscale = (is_left) ? -1 : 1;
	if (prev_state != state || prev_holding_obj != holding_obj) {
		image_index = 0;
		// Set New Sprites
		switch (state) {
			case PLAYER_STATES.CLIMB: {
				sprite_index = spr_player_climb //spr_player_hop_climb;
				image_index = 2 // 0;
				break;
			}
			case PLAYER_STATES.STAND: {
				sprite_index = (holding_obj) ? spr_player_hold_idle : spr_player_idle;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.WALK: {
				sprite_index = (holding_obj) ? spr_player_hold_walk : spr_player_walk;
				image_index = step_index;
				break;
			}
			case PLAYER_STATES.PUSH_WALK:
			case PLAYER_STATES.PUSH: {
				sprite_index = spr_player_push;
				image_index = step_index;
				break;
			}
			case PLAYER_STATES.CROUCH: {
				sprite_index = spr_player_crouch;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.POWERCROUCH: {
				sprite_index = spr_player_powercrouch;
				image_index = 1;
				break;
			}
			case PLAYER_STATES.FALL: {
				sprite_index = spr_player_fall;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.POWERFALL: {
				sprite_index = spr_player_powerfall;
				image_index = 1;
				break;
			}
			case PLAYER_STATES.HOP_UP: {
				sprite_index = spr_player_hop_up;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.HOP: {
				sprite_index = spr_player_hop_down;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.LADDER: {
				sprite_index = spr_player_ladder;
				 image_index = 0;
				break;
			}
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {
				sprite_index = spr_player_ladder;
				image_index = step_index;
				break;
			}
			case PLAYER_STATES.FLY: {
				sprite_index = sp_player_fly;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.POWERFLY: {
				sprite_index = spr_player_powerfly;
				image_index = 1;
				break;
			}
			case PLAYER_STATES.TURN: {
				sprite_index = spr_player_turn;
				image_index = 1;
				break;
			}
			case PLAYER_STATES.LAND: {
				sprite_index = spr_player_tumble_land;
				image_index = 1;
				break;
			}
		}
	}

	// Handle special cases
	if (state == PLAYER_STATES.FALL) {
		// Determine Fall Type
		var _new_sprite_index = spr_player_fall;
		if (dazed) { _new_sprite_index = spr_player_dazed_fall; }
		else if (fall_timer >= 10) { _new_sprite_index = spr_player_tumble; }
		
		// Reset Graphics If They've Changed
		if (sprite_index != _new_sprite_index) {
			sprite_index = _new_sprite_index;
			image_index = -1;
		}
	}
	
	// Update Animations
	image_speed = 0;
	if (state != prev_state) { animation_timer = 0; }
	else { animation_timer++; }
	if (animation_timer >= 64) { animation_timer = 0; }
	switch (state) {
		case PLAYER_STATES.STAND: {
			if (sprite_index == spr_player_idle && idle_timer % 32 == 0) { image_index++; }
			else if (sprite_index == spr_player_hold_walk && idle_timer % 8 == 0) { image_index++; if (image_index > 1) { image_index = 0; } }
			break; 
		}
		case PLAYER_STATES.PUSH:
		case PLAYER_STATES.PUSH_WALK: 
		case PLAYER_STATES.LADDER_UP:
		case PLAYER_STATES.LADDER_DOWN: { if (animation_timer % 8 == 0) { image_index++; } break; }
		case PLAYER_STATES.LAND:
		case PLAYER_STATES.WALK: { if (animation_timer % ((sprite_index == spr_player_hold_walk) ? 8 : 4) == 0) { image_index++; } break; }
		case PLAYER_STATES.TURN:
		case PLAYER_STATES.CLIMB:
		case PLAYER_STATES.FALL:
		case PLAYER_STATES.POWERFALL:
		case PLAYER_STATES.POWERFLY:
		case PLAYER_STATES.POWERCROUCH: { if (animation_timer % 2 == 0) { image_index++; } break; }
	}
	if (image_index >= image_number) { image_index = (image_index % image_number); }
	if (state == PLAYER_STATES.LADDER_DOWN || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.WALK || state == PLAYER_STATES.PUSH_WALK) {
		step_index = (image_index == 1) ? 2 : 0;
	}
}
