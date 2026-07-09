enum PLAYER_STATES
{
	// Grounded States
	STAND,
	LOOK_UP,
	WALK_FORWARD,
	TURN,
	PUSH_STAND,
	PUSH_FORWARD,
	CRUSHED_STAND,
	CRUSHED_FORWARD,
	CROUCH,
	POWERCROUCH,
	WIN,
	SWIM,
	SWIM_FORWARD,
	LAND,
	// Non-Grounded States
	HOP_UP,
	HOP_DOWN,
	HOP_UP_FORWARD,
	HOP_DOWN_FORWARD,
	FLY, // Currently Unused
	POWERFLY,
	FALL,
	DAZED_FALL,
	TUMBLE,
	POWERFALL,
	RECOIL,
	LADDER,
	LADDER_UP,
	LADDER_DOWN,
	CLIMB
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
	RECOIL,
	WIN
}

function player_state_to_string(state) {
	var _player_state_string = "UNKNOWN STATE"
	switch (state) {
		case PLAYER_STATES.STAND: { _player_state_string = "Stand"; break; }
		case PLAYER_STATES.LOOK_UP: { _player_state_string = "Looking Up"; break; }
		case PLAYER_STATES.WALK_FORWARD: { _player_state_string = "Walk"; break; }
		case PLAYER_STATES.TURN: { _player_state_string = "Turn"; break; }
		case PLAYER_STATES.PUSH_STAND: { _player_state_string = "Push Stand"; break; }
		case PLAYER_STATES.PUSH_FORWARD: { _player_state_string = "Push Walk"; break; }
		case PLAYER_STATES.CRUSHED_STAND: { _player_state_string = "Crushed Stand"; break; }
		case PLAYER_STATES.CRUSHED_FORWARD: { _player_state_string = "Crushed Walk"; break; }
		case PLAYER_STATES.CROUCH: { _player_state_string = "Crouch";break; }
		case PLAYER_STATES.POWERCROUCH: { _player_state_string = "Power Crouch";break; }
		case PLAYER_STATES.FLY: { _player_state_string = "Fly"; break; }
		case PLAYER_STATES.POWERFLY: { _player_state_string = "Power Fly"; break; }
		case PLAYER_STATES.FALL: { _player_state_string = "Fall"; break; }
		case PLAYER_STATES.DAZED_FALL: { _player_state_string = "Dazed"; break; }
		case PLAYER_STATES.RECOIL: { _player_state_string = "Recoil"; break; }
		case PLAYER_STATES.TUMBLE: { _player_state_string = "Tumble"; break; }
		case PLAYER_STATES.POWERFALL: { _player_state_string = "Power Fall"; break; }
		case PLAYER_STATES.LAND: { _player_state_string = "Land"; break; }
		case PLAYER_STATES.CLIMB: { _player_state_string = "Climb"; break; }
		case PLAYER_STATES.LADDER: { _player_state_string = "Ladder"; break; }
		case PLAYER_STATES.LADDER_UP: { _player_state_string = "Ladder Up"; break; }
		case PLAYER_STATES.LADDER_DOWN: { _player_state_string = "Ladder Down"; break; }
		case PLAYER_STATES.HOP_DOWN: { _player_state_string = "Hop Straight Down"; break; }
		case PLAYER_STATES.HOP_UP: { _player_state_string = "Hop Straight Up" break; }
		case PLAYER_STATES.HOP_DOWN_FORWARD: { _player_state_string = "Hop Forward Down"; break; }
		case PLAYER_STATES.HOP_UP_FORWARD: { _player_state_string = "Hop Forward Up" break; }
		case PLAYER_STATES.WIN: { _player_state_string = "Win" break; }
		case PLAYER_STATES.SWIM: { _player_state_string = "Float" break; }
		case PLAYER_STATES.SWIM_FORWARD: { _player_state_string = "Swim" break; }
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
	step_index = 1;
	air_walk = false;
	climbed_inst = noone;
	
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
	swim_timer = 0;
	
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
	
	is_floating_state = function() {
		return state == PLAYER_STATES.SWIM;
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
	
	start_falling = function(_is_dazed = false) {
		state =  (_is_dazed) ? PLAYER_STATES.DAZED_FALL : PLAYER_STATES.FALL;
		fall_timer = 0;
		recoil_timer = 0;
		transition_timer = 4;
	}
	
	start_winning = function() {
		state = PLAYER_STATES.WIN;
		transition_timer = 52;
		cape_timer = 52;
		image_index = 0;
	}
	
	start_climbing = function(_climbed_obj) {
		state = PLAYER_STATES.CLIMB;
		transition_timer = 24;
		climbed_inst = _climbed_obj;
	}
	
	start_standing = function(_is_crushed = false) {
		if (is_grounded()) {
			state = PLAYER_STATES.STAND;
			if (_is_crushed) { state = PLAYER_STATES.CRUSHED_STAND; }
			else if (key_down && !global.controller.original_controls) { state = PLAYER_STATES.CROUCH; }
			else if (key_up && !global.controller.original_controls) { state = PLAYER_STATES.LOOK_UP; }
			transition_timer = (_is_crushed) ? 4 : 0;
			air_walk = false;
			if (key_left || key_right) { is_left = key_left; }
		}
		else { start_falling(); }
	}
	
	walk_on_ground_objects = function() {
		if (is_grounded() || air_walk) {
			var _ground_objects = get_ground_objects();
			
			for (var _i = 0; _i < array_length(_ground_objects); _i++) {
				var _inst = _ground_objects[_i]
					_inst.walk_on();
			}
		}
	}
	
	start_walking = function(_is_crushed = false) {
		// First, walk on next object
		var _prev_x = x, _prev_y = y;
		grid_move_horizontal();
		walk_on_ground_objects();
		grid_move_to(_prev_x, _prev_y);
		
		// Continue with Walking or Fall
		if (is_grounded() || air_walk) {
			state = (_is_crushed) ? PLAYER_STATES.CRUSHED_FORWARD : PLAYER_STATES.WALK_FORWARD;
			transition_timer = (_is_crushed) ? 16 : 4;
		}
		else { start_falling(); }
	}
	
	start_hopping = function(_should_move_horizontally = false) {
		//virtual_y -= 4;
		play_sound(snd_player_jump);
		state = (_should_move_horizontally) ? PLAYER_STATES.HOP_UP_FORWARD: PLAYER_STATES.HOP_UP
		transition_timer = 8;
	}
	
	start_laddering = function() {
		var _should_ladder = ((key_up && can_start_laddering()) || (key_down && can_start_laddering()));
		if (_should_ladder) {
			state = PLAYER_STATES.LADDER;
			transition_timer = 4;
			play_sound(snd_player_ladder_step);
		}
		return _should_ladder;
	}
	
	reset_controls()
}

function update_player_state() {
	prev_state = state;

	// Check Controls
	if (state != PLAYER_STATES.WIN) { reset_controls(); }
	update_controls();

	// Reset various player state timers
	if (!is_ladder_state()) { is_up = false; }
	if (state != PLAYER_STATES.CROUCH && state != PLAYER_STATES.POWERCROUCH) { crouch_timer = 0; }
	if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.TUMBLE && state != PLAYER_STATES.POWERFALL) { fall_timer = 0; }
	if (state != PLAYER_STATES.RECOIL) { recoil_timer = 0; }
	if (state != PLAYER_STATES.FLY && state != PLAYER_STATES.POWERFLY) { fly_timer = 0; }
	if (state != PLAYER_STATES.SWIM && state != PLAYER_STATES.SWIM_FORWARD) { swim_timer = 0; }
	
	// While Transitioning
	if (transition_timer > 0) {
		transition_timer--;

		switch (state) {
			case PLAYER_STATES.HOP_DOWN:
			case PLAYER_STATES.HOP_DOWN_FORWARD:
			case PLAYER_STATES.HOP_UP:
			case PLAYER_STATES.HOP_UP_FORWARD: {
				var _is_hopping_up = (state == PLAYER_STATES.HOP_UP || state == PLAYER_STATES.HOP_UP_FORWARD);
				var _is_hopping_down = (state == PLAYER_STATES.HOP_DOWN || state == PLAYER_STATES.HOP_DOWN_FORWARD);
				var _is_hopping_forward = (state == PLAYER_STATES.HOP_DOWN_FORWARD || state == PLAYER_STATES.HOP_UP_FORWARD);
				
				var _move_fast = (_is_hopping_up && transition_timer >= 6) || (_is_hopping_down && transition_timer <= 2);
				var _move_slow = (_is_hopping_up && transition_timer >= 2) || (_is_hopping_down && transition_timer <= 6);
				var _move_none = (_is_hopping_up && transition_timer >= 0) || (_is_hopping_down && transition_timer <= 8);
				
				var _y_move = 0, _x_move = (is_left) ? -1 : 1;
				if (_move_fast) { _y_move = 2; }
				else if (_move_slow) { _y_move = 1; }
				else if (_move_none) { _y_move = 0; }
				
				virtual_y += _y_move * ((_is_hopping_up) ? -1 : 1);
				if (_is_hopping_forward) { virtual_x += _x_move; }
				
				break;
			}
			case PLAYER_STATES.CRUSHED_FORWARD: { virtual_x += (is_left) ? -0.5 : 0.5; break; }
			case PLAYER_STATES.WALK_FORWARD: { virtual_x += (is_left) ? -2 : 2; break; }
			case PLAYER_STATES.SWIM_FORWARD: 
			case PLAYER_STATES.PUSH_FORWARD: { virtual_x += (is_left) ? -1 : 1; swim_timer++; break; }
			case PLAYER_STATES.FLY:
			case PLAYER_STATES.POWERFLY: { virtual_y -= 2; fly_timer++; break; }
			case PLAYER_STATES.RECOIL: { virtual_y -= 4; recoil_timer++; break; }
			case PLAYER_STATES.TUMBLE:
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.DAZED_FALL:
			case PLAYER_STATES.POWERFALL: { virtual_y += 2; fall_timer++; break; }
			case PLAYER_STATES.LADDER_UP: { virtual_y -= 1; break; } 
			case PLAYER_STATES.LADDER_DOWN: { virtual_y += 1; break; }
			case PLAYER_STATES.TURN: { if (transition_timer == 0) { is_left = !is_left; }  break; }
			case PLAYER_STATES.LADDER: { break; }
			case PLAYER_STATES.LAND: { break; }
			case PLAYER_STATES.CLIMB: {
				if (transition_timer < 24 && transition_timer >= 22) {
					virtual_y -= 1;
				}
				else if (transition_timer < 22 && transition_timer >= 20) {
					virtual_y -= 1;
					if (transition_timer == 20) {
						grid_move_up();
					}
				}
				else if (transition_timer < 20 && transition_timer >= 18) {
					if (transition_timer == 18) {
						virtual_x += (is_left) ? -2 : 2;
						walk_on_ground_objects(); // TODO: Should we not do this here?
					}
				}
				else if (transition_timer < 18 && transition_timer >= 16) {
					if (transition_timer == 16) {
						virtual_x += (is_left) ? -2 : 2;
					}
				}
				else if (transition_timer < 16 && transition_timer >= 14) {
					if (transition_timer == 14) {
						virtual_y -= 2;
					}
				}
				else if (transition_timer < 14 && transition_timer >= 12) {
					if (transition_timer == 12) {
						virtual_x += (is_left) ? -2 : 2;
						grid_move_horizontal();
						virtual_y -= 2;
					}
				}
				else if (transition_timer < 6) { transition_timer = 0; }
				
				break;
			}
			case PLAYER_STATES.WIN: {
				if (visible) {
					if (transition_timer == 52) { image_index = 0; cape_image_index = 0; }
					if (transition_timer == 36) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); }
					if (transition_timer == 28) { image_index = 0; cape_image_index = 0; }
					if (transition_timer == 24) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); }
					if (transition_timer == 20) { image_index = 0; cape_image_index = 0; }
					if (transition_timer == 14) { image_index = 2; cape_image_index = 0; play_sound(snd_key); particle_color = c_white; create_particles(4 + irandom(6), false, spr_sparkle); }
				}
				if (transition_timer == 0) { image_index = 0; cape_image_index = 0; cape_timer = 52; }
			}
			case PLAYER_STATES.LOOK_UP:
			case PLAYER_STATES.STAND:
			case PLAYER_STATES.PUSH_STAND:
			case PLAYER_STATES.CROUCH: {
				// Do Nothing
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
		switch (state) {
			case PLAYER_STATES.SWIM:
			case PLAYER_STATES.SWIM_FORWARD: {
				if (state == PLAYER_STATES.SWIM_FORWARD) { grid_move_horizontal(); }
				swim_timer++;

				if (start_laddering()) { }
				else {
					if (key_left || key_right) { is_left = key_left; }
					
					
					var _horizontal_input = ((is_left && key_left) || (!is_left && key_right));
					var _can_climb = (key_jump || key_up) && !is_under_ceiling();
					var _can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
					var _climbable_objects = (is_left) ? get_left_climbable_objects() : get_right_climbable_objects();
					var _climbed_obj = grid_array_first(_climbable_objects);
					_can_climb = _can_climb && instance_exists(_climbed_obj) && y < _climbed_obj.y;
					
					if (_can_climb && _horizontal_input) { start_climbing(_climbed_obj); }
					else if (_can_walk && _horizontal_input) {
						transition_timer = 8;
						state = PLAYER_STATES.SWIM_FORWARD;
					}
					else { state = PLAYER_STATES.SWIM; }
				}
				break;
			}
			case PLAYER_STATES.WIN: {
				if (visible && (key_up || key_jump)) {
					visible = false;
					play_sound(snd_explosion);
					with (obj_door) { image_index = 3; create_particles(8 + irandom(8)); }
					// TODO: Do this in controller instead of player?
					global.controller.transition_timer = 1;
					global.controller.target_room = room_next(room);
					global.controller.last_player_x = x;
					global.controller.last_player_y = y;
				}
				else { start_winning(); }
				break;
			}
			case PLAYER_STATES.LAND: {
				if (!start_laddering()) { start_standing(); }
				break;
			}
			case PLAYER_STATES.HOP_UP:
			case PLAYER_STATES.HOP_UP_FORWARD: {
				// Move Position Based on Previous State
				grid_move_up();
				if (state == PLAYER_STATES.HOP_UP_FORWARD) { grid_move_horizontal(); }
					
				// Check Current Position
				var _can_walk = ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right());
				var _horizontal_input = ((is_left && key_left) || (!is_left && key_right));
				var _on_hop_height_ground = false, _prev_x = x, _prev_y = y;
				grid_move_horizontal();
				_on_hop_height_ground = is_grounded();
				grid_move_to(_prev_x, _prev_y);

				// Determine New State
				if (start_laddering()) { } // Just do the Ladder Stuff
				else if (is_grounded()) { start_standing(); }
				else if (_on_hop_height_ground && _can_walk && _horizontal_input) {
					air_walk = true;
					start_walking();
				}
				else {
					var _can_climb = (key_jump || key_up || global.controller.original_controls) && !is_under_ceiling();
					var _climbable_objects = (is_left) ? get_left_climbable_objects() : get_right_climbable_objects();
					var _climbed_obj = grid_array_first(_climbable_objects);
					_can_climb = _can_climb && instance_exists(_climbed_obj) && y < _climbed_obj.y;
					
					if (_can_climb && (_horizontal_input || global.controller.original_controls)) { start_climbing(_climbed_obj); }
					else {
						state = (_can_walk && state == PLAYER_STATES.HOP_UP_FORWARD) ? PLAYER_STATES.HOP_DOWN_FORWARD : PLAYER_STATES.HOP_DOWN;
						transition_timer = 8;
					}
				}
				break;
			}
			case PLAYER_STATES.HOP_DOWN:
			case PLAYER_STATES.HOP_DOWN_FORWARD:
			case PLAYER_STATES.STAND:
			case PLAYER_STATES.LOOK_UP:
			case PLAYER_STATES.WALK_FORWARD:
			case PLAYER_STATES.PUSH_STAND:
			case PLAYER_STATES.PUSH_FORWARD:
			case PLAYER_STATES.CRUSHED_STAND:
			case PLAYER_STATES.CRUSHED_FORWARD:
			case PLAYER_STATES.CROUCH:
			case PLAYER_STATES.TURN:
			case PLAYER_STATES.POWERCROUCH: {
				// Move Position Based on Previous State
				if (state == PLAYER_STATES.WALK_FORWARD || state == PLAYER_STATES.PUSH_FORWARD || state == PLAYER_STATES.CRUSHED_FORWARD || state == PLAYER_STATES.HOP_DOWN_FORWARD) {
					grid_move_horizontal();
				}
				if (state == PLAYER_STATES.HOP_DOWN || state == PLAYER_STATES.HOP_DOWN_FORWARD) { grid_move_down(); }

				// Update New State
				if (start_laddering()) { }
				else if (!is_grounded()) {
					start_falling();
				}
				else {
					// Update Whether Crushed By Objects
					var _ceiling_objects = get_ceiling_objects(), _crushed_by_object = false;
					for (var _i = 0; _i < array_length(_ceiling_objects); _i++) {
						var _inst = _ceiling_objects[_i];
						if (instance_exists(_inst) && _inst.has_gravity && _inst.is_grounded()) {
							is_ground = false;
							if (!_inst.is_grounded() && _inst.state != STATES.FALLING) { _crushed_by_object = true; }
							is_ground = true;
						}
					}
						
					// Update Facing Direction and Add Turn Delay
					var _prev_is_left = is_left;
					if (key_left || key_right) { is_left = key_left; }
					
					// Force Crushed or Turn States
					if (_crushed_by_object) {
						var _can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
						
						if (_can_walk && (key_left || key_right)) { start_walking(true); }
						else { start_standing(true); }
					}
					else if (is_left != _prev_is_left &&
						(prev_state == PLAYER_STATES.HOP_UP_FORWARD ||
							prev_state == PLAYER_STATES.HOP_DOWN_FORWARD ||
							prev_state == PLAYER_STATES.WALK_FORWARD ||
							prev_state == PLAYER_STATES.PUSH_FORWARD ||
							prev_state == PLAYER_STATES.PUSH_STAND ||
							prev_state == PLAYER_STATES.TURN)) {
						state = PLAYER_STATES.TURN;
						transition_timer = 4;
						is_left = _prev_is_left;
						walk_on_ground_objects();
					}
						
					// Update Landing on Objects from Hop/Airwalk
					if (state == PLAYER_STATES.HOP_DOWN || state == PLAYER_STATES.HOP_DOWN_FORWARD) {
						if (transition_timer == 0) { start_standing(); }
						transition_timer = 4;
						var _ground_objects = get_ground_objects();
						for (var _i = 0; _i < array_length(_ground_objects); _i++) {
							var _inst = _ground_objects[_i];
							if (instance_exists(_inst) && _inst.is_solid_from_above()) { _inst.fall_on(); }
						}
					}
					else if (state == PLAYER_STATES.WALK_FORWARD && air_walk) {
						start_standing();
						transition_timer = 4;
					}
						
					// Switch to New State Based on Player Input
					if (transition_timer == 0) {
						if (key_left || key_right) {
							var _can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
							var _more_ceiling_objects = (key_left) ? get_left_ceiling_objects() : get_right_ceiling_objects(), _under_more_ceiling = array_length(_more_ceiling_objects) != 0;
							var _climbable_objects = (is_left) ? get_left_climbable_objects() : get_right_climbable_objects();
							var _climbed_obj = grid_array_first(_climbable_objects);
							var _can_climb =  instance_exists(_climbed_obj) && y <= _climbed_obj.y;
								
							var _can_hop = (key_up || key_jump || (_can_climb && global.controller.original_controls)) && !is_under_ceiling();
							
							var _can_hop_up = _can_hop, _can_hop_forward = _can_walk && _can_hop && !_under_more_ceiling && !global.controller.original_controls;
							
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
								// Push Wall
								var _pushable_objects = is_left ? get_left_pushable_objects() : get_right_pushable_objects();
								var _pushed_obj = grid_array_first(_pushable_objects);
									
								if (instance_exists(_pushed_obj)) {
									_pushed_obj.grid_remove();
									_can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
									_pushed_obj.grid_add();
								}
								else { _can_walk = false; }

								if (_can_walk && y == _pushed_obj.y) {
									// Push Box
									state = PLAYER_STATES.PUSH_FORWARD;
									transition_timer = 8;
									with (_pushed_obj) {
										is_left = other.is_left;
										state = STATES.PUSHED;
										transition_timer = 8;
									}
								}
								else if (!global.controller.original_controls) {
									// Push Against Solid Wall
									state = PLAYER_STATES.PUSH_STAND;
									transition_timer = 4;
								}
								else {
									// TODO: Walk Against Solid Wall
									state = PLAYER_STATES.STAND;
									transition_timer = 4;
								}

							}
						}
						else if (key_up || key_jump) {
							if (is_under_ceiling()) { start_standing(); }
							else {
								if (state == PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.POWERFLY; transition_timer = 4; play_sound(snd_player_takeoff); }
								else if (!global.controller.original_controls) { start_hopping(); }
							}
						}
						else if (key_down && !global.controller.original_controls) {
							if (state == PLAYER_STATES.CROUCH) { crouch_timer++; }
							else if (state != PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.CROUCH; transition_timer = 4; }

							if (crouch_timer == 32 && state != PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.POWERCROUCH; play_sound(snd_player_powerup); }
						}
						else { start_standing(); }
					
						// Add Input Delay for Changing Between States and Standing
						if (state == PLAYER_STATES.STAND && 
							(prev_state == PLAYER_STATES.PUSH_STAND ||
							prev_state == PLAYER_STATES.PUSH_FORWARD ||
							prev_state == PLAYER_STATES.CROUCH ||
							prev_state == PLAYER_STATES.LOOK_UP)) { transition_timer = 4; }
					}
				}
				break;
			}
			case PLAYER_STATES.FLY:
			case PLAYER_STATES.POWERFLY: {
				// Move Position Based on Previous State
				grid_move_up();
					
				if (start_laddering()) { }
				else {
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
							var _play_sound = false;
							while (array_length(_damaged_instances) > 0) {
								var _inst = grid_array_first(_damaged_instances);
								array_delete(_damaged_instances, 0, 1);
								if (instance_exists(_inst)) {
									_play_sound = true;
									if (_inst.is_connected) {
										// Remove any connected instances from list of instances to damage
										var _connected_instances = _inst.get_connected_instances([_inst.id])
										for (var _i = 0; _i < array_length(_connected_instances); _i++) {
											var _connected_inst = _connected_instances[_i]
											var _index = array_get_index(_damaged_instances, _connected_inst.id);
											if (_index >= 0) { array_delete(_damaged_instances, _index, 1); }
										}
									}
									else if (object_is_ancestor(_inst.object_index, obj_static_area) && abs(y - _inst.y) <= 8) {
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
							if (_play_sound) { play_sound(snd_impact); }
						
							// Player reaction to Collision
							virtual_y = y;
							start_falling(true);
						}
						else { start_falling(); }
					}
					else {
						// Keep Flying
						transition_timer = 4;
						if (fly_timer >= 16 && state != PLAYER_STATES.POWERFLY) { state = PLAYER_STATES.POWERFLY; play_sound(snd_player_powerup); }
					}
				}
				break;
			}
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.DAZED_FALL:
			case PLAYER_STATES.TUMBLE:
			case PLAYER_STATES.POWERFALL: {
				// Move Position Based on Previous State
				grid_move_down();
					
				if (start_laddering()) { }
				else {
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
							var _play_sound = false;
							while (array_length(_damaged_instances) > 0) {
								var _inst = grid_array_first(_damaged_instances);
								array_delete(_damaged_instances, 0, 1);
								if (instance_exists(_inst)) {
									_play_sound = true;
									if (_inst.is_connected) {
										// Remove any connected instances from list of instances to damage
										var _connected_instances = _inst.get_connected_instances([_inst.id])
										for (var _i = 0; _i < array_length(_connected_instances); _i++) {
											var _connected_inst = _connected_instances[_i]
											var _index = array_get_index(_damaged_instances, _connected_inst.id);
											if (_index >= 0) { array_delete(_damaged_instances, _index, 1); }
										}
									}
									else if (object_is_ancestor(_inst.object_index, obj_static_area) && abs(y - _inst.y) <= 16) {
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
							if (_play_sound) { play_sound(snd_impact); }
						
							// Player reaction to landing
							state = PLAYER_STATES.RECOIL;
							transition_timer = 2;
						}
						else if (fall_timer < 10) {
							start_standing();
							transition_timer = 4;
						}
						else {
							// Landing Delay for Tumbling animation
							if (key_left || key_right) { is_left = key_left; }
							state = PLAYER_STATES.LAND;
							transition_timer = 8;
							audio_stop_sound(snd_player_tumble);
						}
					}
					else {
						// Keep Falling
						if (fall_timer >= 8 && state == PLAYER_STATES.FALL) { state = PLAYER_STATES.TUMBLE; }
						if (fall_timer >= 12 && state == PLAYER_STATES.TUMBLE) { state = PLAYER_STATES.POWERFALL; play_sound(snd_player_takeoff); }
						transition_timer = 4;
					}
				}
				break;
			}
			case PLAYER_STATES.RECOIL: {
				// Move Position Based on Previous State
				grid_move_up();
				
				// Decide New State
				if (start_laddering()) { }
				else if (is_grounded()) { start_standing(); }
				else if (is_under_ceiling() || recoil_timer >= 4) { start_falling(); }
				else {
					// Keep Recoiling
					transition_timer = 2;
				}
				break;
			}
			case PLAYER_STATES.LADDER:
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {
				// Move Position Based on Previous State
				if (state == PLAYER_STATES.LADDER_UP) { grid_move_up(); }
				else if (state == PLAYER_STATES.LADDER_DOWN) { grid_move_down(); }
						
				// Decide New State Based on Player Input
				if (instance_exists(get_closest_ladder())) {
					if (key_up && can_ladder_up()) {
						transition_timer = 8;	
						state = PLAYER_STATES.LADDER_UP;
						play_sound(snd_player_ladder_step);
					}
					else if (key_down && can_ladder_down()) {
						transition_timer = 8;	
						state = PLAYER_STATES.LADDER_DOWN;
						play_sound(snd_player_ladder_step);
					}
					else if (!instance_exists(get_closest_ladder())) { 
						start_falling();
					}
					else if ((key_left || key_right) && (is_grounded() && !is_inside_solid())) { is_left = key_left; start_walking(); }
					else { state = PLAYER_STATES.LADDER; }
				}
				else { start_falling(); }
						

				break;
			}
			case PLAYER_STATES.CLIMB: {
				if (is_grounded()) {
					transition_timer = 4;
					state = PLAYER_STATES.CROUCH;
				}
				else { start_standing(); }
				break;
			}
			default: {
				show_debug_message("ERROR: Unknown State: " + player_state_to_string(state));
				break;
			}
		}
		
		virtual_x = x;
		virtual_y = y;
	}
	
	// Update player position for moving platforms
	// TODO
}

function update_cape_graphics() {
	// Update Cape State
	if (cape_timer > 0) {
		cape_timer--;
		if (cape_state != CAPE_STATES.WIN) {
			if (cape_timer % 2 == 0) { cape_image_index++; }
			if (cape_image_index >= 4) { cape_image_index = 0; }
		}
	}
	
	// Set New Cape State Only After Current Animation Finishes
	if (cape_timer == 0) {
		switch (cape_state) {
			case CAPE_STATES.WIN: {
				cape_state = CAPE_STATES.WIN;
				cape_sprite_index = spr_cape_crushed;
				cape_image_index = 0;
				cape_timer = 52;
				break;
			}
			case CAPE_STATES.RECOIL: {
				if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.TUMBLE || state == PLAYER_STATES.DAZED_FALL) {
					cape_state = CAPE_STATES.FALL_START;
					cape_sprite_index = spr_cape_fall_start;
					cape_image_index = 0;
					cape_timer = 4;
				}
				else if (state == PLAYER_STATES.RECOIL) {
					cape_state = CAPE_STATES.FLY;
					cape_sprite_index = spr_cape_fly;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else {
					cape_state = CAPE_STATES.FLUTTER;
					cape_sprite_index = spr_cape_flutter;
					cape_image_index = 0;
					cape_timer = 8;
				}
			}
			case CAPE_STATES.FLUTTER:
			case CAPE_STATES.TURN: {
				if (state == PLAYER_STATES.WALK_FORWARD) {
					cape_state = CAPE_STATES.FLUTTER;
					cape_sprite_index = spr_cape_flutter;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.TUMBLE || state == PLAYER_STATES.DAZED_FALL || state == PLAYER_STATES.POWERFALL) {
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
				if (state == PLAYER_STATES.WALK_FORWARD) {
					cape_state = CAPE_STATES.FLUTTER;
					cape_sprite_index = spr_cape_flutter;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else if (state == PLAYER_STATES.CRUSHED_STAND || state == PLAYER_STATES.CRUSHED_FORWARD) {
					cape_state = CAPE_STATES.STAND;
					cape_sprite_index = spr_cape_crushed;
					cape_image_index = 0;
					cape_timer = 0;
				}
				else if (state == PLAYER_STATES.STAND || state == PLAYER_STATES.LOOK_UP || state == PLAYER_STATES.PUSH_STAND || state == PLAYER_STATES.PUSH_FORWARD) {
					cape_state = CAPE_STATES.STAND;
					cape_sprite_index = spr_cape_stand;
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
				else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.TUMBLE || state == PLAYER_STATES.DAZED_FALL || state == PLAYER_STATES.POWERFALL) {
					cape_state = CAPE_STATES.FALL_START;
					cape_sprite_index = spr_cape_fall_start;
					cape_image_index = 0;
					cape_timer = 4;
				}
				else if (state == PLAYER_STATES.WIN) {
					cape_state = CAPE_STATES.STAND;
					cape_sprite_index = spr_cape_crushed;
					cape_image_index = 0;
					cape_timer = 0;
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
					else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.TUMBLE || state == PLAYER_STATES.DAZED_FALL || state == PLAYER_STATES.POWERFALL) {
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
				if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.TUMBLE || state == PLAYER_STATES.DAZED_FALL || state == PLAYER_STATES.POWERFALL) {
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
				if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.TUMBLE || state == PLAYER_STATES.DAZED_FALL || state == PLAYER_STATES.POWERFALL) {
					cape_state = CAPE_STATES.FALL;
					cape_sprite_index = spr_cape_fall;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else if (state == PLAYER_STATES.RECOIL) {
					cape_state = CAPE_STATES.RECOIL;
					cape_sprite_index = spr_cape_recoil;
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
		if (state == PLAYER_STATES.HOP_UP || state == PLAYER_STATES.HOP_UP_FORWARD) {
			cape_state = CAPE_STATES.STOP_FLUTTER;
			cape_sprite_index = spr_cape_stop_flutter;
			cape_image_index = 0;
			cape_timer = 4;
		}
		else if (state == PLAYER_STATES.HOP_DOWN || state == PLAYER_STATES.HOP_DOWN_FORWARD) {
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
		else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.DAZED_FALL) {
			cape_state = CAPE_STATES.FALL_START;
			cape_sprite_index = spr_cape_fall_start;
			cape_image_index = 0;
			cape_timer = 4;
		}
		else if (state == PLAYER_STATES.WIN) {
			cape_state = CAPE_STATES.WIN;
			cape_sprite_index = spr_cape_crushed;
			cape_image_index = 0;
			cape_timer = 52;
		}
		/*
		else if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.POWERFALL && (prev_state != PLAYER_STATES.DAZED_FALL || prev_state != PLAYER_STATES.TUMBLE)) {
			cape_state = CAPE_STATES.STOP_FLUTTER;
			cape_sprite_index = spr_cape_stop_flutter;
			cape_image_index = 0;
			cape_timer = 4;
		}
		*/
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
		case PLAYER_STATES.TUMBLE: {
			if (image_index > 1) { cape_depth = depth - 1; }
			else { cape_depth = depth + 1; }
			break;
		}
		case PLAYER_STATES.RECOIL: {
			if (image_index < 2) { cape_depth = depth - 1; }
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
	if (prev_state != state) {
		animation_timer = 0;
		image_index = 0;
		
		// Set New Sprites
		switch (state) {
			case PLAYER_STATES.CLIMB: {
				sprite_index = spr_player_climb //spr_player_hop_climb;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.CRUSHED_STAND: {
				sprite_index = spr_player_crushed_idle;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.CRUSHED_FORWARD: {
				sprite_index = spr_player_crushed_walk;
				image_index = step_index;
				break;
			}
			case PLAYER_STATES.STAND: {
				sprite_index = spr_player_idle;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.LOOK_UP: {
				sprite_index = spr_player_look_up;
				// image_index = 0;
				break;
			}
			case PLAYER_STATES.WALK_FORWARD: {
				sprite_index = spr_player_walk;
				image_index = step_index;
				break;
			}
			case PLAYER_STATES.PUSH_FORWARD:
			case PLAYER_STATES.PUSH_STAND: {
				sprite_index = spr_player_push;
				image_index = step_index;
				break;
			}
			case PLAYER_STATES.CROUCH: {
				sprite_index = spr_player_crouch;
				// image_index = 0;
				break;
			}
			case PLAYER_STATES.POWERCROUCH: {
				sprite_index = spr_player_powercrouch;
				image_index = 1;
				break;
			}
			case PLAYER_STATES.FALL: {
				sprite_index = spr_player_fall;
				// image_index = 0;
				break;
			}
			case PLAYER_STATES.DAZED_FALL: {
				sprite_index = spr_player_dazed_fall;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.TUMBLE: {
				sprite_index = spr_player_tumble;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.RECOIL: {
				sprite_index = spr_player_recoil;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.POWERFALL: {
				sprite_index = spr_player_powerfall;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.HOP_UP:
			case PLAYER_STATES.HOP_UP_FORWARD: {
				sprite_index = spr_player_hop_up;
				// image_index = 0;
				break;
			}
			case PLAYER_STATES.HOP_DOWN:
			case PLAYER_STATES.HOP_DOWN_FORWARD: {
				sprite_index = spr_player_hop_down;
				// image_index = 0;
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
				//image_index = 0;
				break;
			}
			case PLAYER_STATES.POWERFLY: {
				sprite_index = spr_player_powerfly;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.TURN: {
				sprite_index = spr_player_turn;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.LAND: {
				sprite_index = spr_player_tumble_land;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.SWIM: {
				sprite_index = spr_player_float;
				image_index = step_index;
				break;
			}
			case PLAYER_STATES.SWIM_FORWARD: {
				sprite_index = spr_player_swim;
				image_index = 1;
				break;
			}
			case PLAYER_STATES.WIN: {
				sprite_index = spr_player_win;
				image_index = 0;
				break;
			}
		}
	}
	else {
		// Update Current Animations
		animation_timer++;
		animation_timer = animation_timer % 64;
		animation_speed = 1;
		
		// Set Speed for Different Animations
		switch (state) {
			case PLAYER_STATES.STAND:
			case PLAYER_STATES.CRUSHED_STAND: { animation_speed = 32; break; }
			case PLAYER_STATES.PUSH_STAND:
			case PLAYER_STATES.PUSH_FORWARD: 
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.SWIM:
			case PLAYER_STATES.SWIM_FORWARD:
			case PLAYER_STATES.LADDER_DOWN: { animation_speed = 8; break; }
			case PLAYER_STATES.LAND:
			case PLAYER_STATES.CRUSHED_FORWARD:
			case PLAYER_STATES.WALK_FORWARD: { animation_speed = 4; break; }
			case PLAYER_STATES.TURN:
			case PLAYER_STATES.CLIMB:
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.DAZED_FALL:
			case PLAYER_STATES.POWERFALL:
			case PLAYER_STATES.POWERFLY:
			case PLAYER_STATES.POWERCROUCH: { animation_speed = 2; break; }
			case PLAYER_STATES.RECOIL:
			case PLAYER_STATES.TUMBLE: { animation_speed = 1; break; }
			default: { animation_speed = 0; }
		}
		
		// Update Images in Animations
		if (animation_speed > 0) {
			// Update Animation Based on Selected Speed
			if (animation_timer % animation_speed == 0) { image_index++; }
			image_index = image_index % image_number;
			// Update Step Index
			if (state == PLAYER_STATES.LADDER_DOWN || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.WALK_FORWARD || state == PLAYER_STATES.PUSH_FORWARD) {
				if (image_index % 2 == 1) { step_index = image_index + 2; }
			}
		}
	}
}

function update_player_collisions_at_position() {
	// Get Destroyed From Solids
	if (is_inside_solid() && !is_ladder_state()) { instance_destroy(); }
								
	if (is_fully_submerged()) {
		switch (state) {
			case PLAYER_STATES.LADDER:
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {
				// No effect on ladders
				break;
			}
			case PLAYER_STATES.RECOIL: {
				// No Special Recoil?
				break;
			}
			default: {
				fall_timer -= 2;
				if (fall_timer <= 0) {
					state = PLAYER_STATES.RECOIL;
				}
				break;
			}
		}
	}
	else if (is_partially_submerged()) {
		if (state == PLAYER_STATES.RECOIL) { state = PLAYER_STATES.SWIM; transition_timer = 4; }
	}
						
	// Win Game From Door
	else if (at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_door) && state != PLAYER_STATES.WIN && instance_number(obj_key) == 0) {
		start_winning();
		stop_music();
		play_sound(snd_level_clear);
	}
}
