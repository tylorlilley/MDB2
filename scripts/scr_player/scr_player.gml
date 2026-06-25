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
	FLY,
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
	is_fixed = false;
	is_ground = true;
	is_ceiling = false;
	is_right_wall = false;
	is_left_wall = false;
	
	cape_state = CAPE_STATES.STAND;
	cape_sprite_index = spr_cape_stand;
	cape_image_index = 0;
	cape_timer = 0;
	step_index = 0;
	
	// Player Specific Variables
	prev_state = PLAYER_STATES.STAND;
	state = PLAYER_STATES.STAND;
	image_speed = 0;
	cape_x = x;
	cape_y = y;
	cape_depth = 1;
	virtual_x = x;
	virtual_y = y;
	transition_timer = 0;
	animation_timer = 0;
	
	crouch_timer = 0;
	fall_timer = 0;
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
		state =  PLAYER_STATES.FALL;
		fall_timer = 0;
		transition_timer = 4;
		y += 8;
	}
	
	start_standing = function() {
		if (is_grounded()) {
			state = (key_down) ? PLAYER_STATES.CROUCH : PLAYER_STATES.STAND;
			transition_timer = 0;
			if (key_left || key_right) { is_left = key_left; }
			if (key_up) { idle_timer = 0; sprite_index = spr_player_look_up; }
			else { sprite_index = spr_player_idle; }
		}
		else { start_falling(); }
	}
	
	reset_controls()
}

function update_player_state() {
	prev_state = state;
	var _in_ground = place_meeting(x, y, obj_solid);
	var _ground_objects = get_ground_objects(), _on_ground = is_grounded();
	var _ceiling_objects = get_ceiling_objects(), _under_ceiling = is_under_ceiling();
	var _wall_objects = noone, _against_wall = false;
	var _player_can_input = true; //(transition_timer == 0);
	var _prev_is_left = is_left;
	
	// Check for ladders
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
			case PLAYER_STATES.HOP_UP: { virtual_y += (state == PLAYER_STATES.HOP_UP) ? -1 : 1; }
			case PLAYER_STATES.WALK:  { virtual_x += (is_left) ? -2 : 2; break; }
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
					virtual_y -= 2; if (virtual_y == y) { y -= 8; }
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
						x += (is_left) ? -8 : 8;
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
				else if ((key_left || key_right) && (_on_ground && !_in_ground)) { start_standing(); }
				else { state = PLAYER_STATES.LADDER; }
			}
		}
	
		switch (state) {
			case PLAYER_STATES.LAND: {
				start_standing();
				break;
			}
			case PLAYER_STATES.HOP_UP: {
				_wall_objects = ((is_left) ? get_left_wall_objects() : get_right_wall_objects());
				var _can_walk = (ds_list_empty(_wall_objects));
				
				virtual_y += 4;
				if (_on_ground) { start_standing(); }
				else {
					if (_can_walk) {
						state = PLAYER_STATES.HOP;
						transition_timer = 4;
						x += (is_left) ? -8 : 8;
						y += 8;
					}
					else {
						start_falling();
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
				if (!_on_ground) {
					start_falling();
				}
				else {
					// Change State due to Player Input
					/*
					if (key_jump && !_under_ceiling) {
						state = PLAYER_STATES.HOP_UP;
						is_left = key_left;
						if (key_left || key_right) { state = PLAYER_STATES.HOP; x += (is_left) ? -8 : 8; }
						transition_timer = 8;
						y -= 8;
					}
					*/
					
					if (key_left || key_right) {
						is_left = key_left;
						
						if ((prev_state == PLAYER_STATES.WALK || prev_state == PLAYER_STATES.PUSH_WALK || prev_state == PLAYER_STATES.PUSH) && is_left != _prev_is_left) {
							state = PLAYER_STATES.TURN;
							transition_timer = 4;
							is_left = _prev_is_left;
						}
						else {
							state = PLAYER_STATES.WALK;
					
							// Determine if can move in that direction
							_wall_objects = ((is_left) ? get_left_wall_objects() : get_right_wall_objects());
							var _can_walk = (ds_list_empty(_wall_objects));
					
							if (_can_walk) {
								var _can_hop = false;
						
								// Check for Small Hole
								if ((key_up || key_jump) && !_under_ceiling) {
									x += (is_left) ? -8 : 8;
									var _about_to_fall = !is_grounded() && !is_under_ceiling();
									x += (is_left) ? -8 : 8;
									_can_hop = (_about_to_fall && is_grounded() && !is_under_ceiling());
									x = virtual_x;
								}
						
								state = (_can_hop) ? PLAYER_STATES.HOP_UP : PLAYER_STATES.WALK;
								transition_timer = 4;
								x += (is_left) ? -8 : 8;
								if (_can_hop) { y -= 8; }
							}
							else {
								_wall_objects = is_left ? get_left_climbable_objects() : get_right_climbable_objects();
								_against_wall = ((ds_list_size(_wall_objects) > 0) && (key_up || key_jump) && !_under_ceiling);
						
								if (_against_wall) {
									// Climb Wall
									
									transition_timer = 28;
									y -= 8;
									state = PLAYER_STATES.CLIMB;
								}
								else {
									// Push Wall
									_wall_objects = is_left ? get_left_pushable_objects() : get_right_pushable_objects();
									_against_wall = (ds_list_size(_wall_objects) > 0);

									if (_against_wall) {
										// Push Box
										state = PLAYER_STATES.PUSH_WALK;
										x += (is_left) ? -8 : 8;
										transition_timer = 8;
										pushed_obj = _wall_objects[| 0];
										pushed_obj.state = STATES.PUSHED;
										pushed_obj.x += (is_left) ? -8 : 8
										pushed_obj.transition_timer = 8;
									}
									else {
										// Push Against Solid Wall
										state = PLAYER_STATES.PUSH;
									}
								}
							}
						}
					}
					else if (key_up || key_jump) {
						if (state == PLAYER_STATES.POWERCROUCH && !_under_ceiling) { state = PLAYER_STATES.FLY; y -= 8; transition_timer = 4; }
						else { start_standing(); } // TODO: Look Up?
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
				if (_under_ceiling) {
					// Bonk against ceiling
					if (state == PLAYER_STATES.POWERFLY) {
						// y += 8;
						// TODO: Damage ceiling
					}
					start_falling();
				}
				else {
					// Keep Flying
					y -= 8;
					transition_timer = 4;
					fly_timer++;
					if (fly_timer > 12) { state = PLAYER_STATES.POWERFLY; }
				}
				break;
			}
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.POWERFALL: {
				if (_on_ground) {
					// Bonk against floor
					if (state == PLAYER_STATES.POWERFALL) {
						y += (_under_ceiling) ? 0 : -16;
						virtual_y = y;
						start_falling();
						// TODO: Damage floor
					}
					else { 
						if (fall_timer < 10) { start_standing(); }
						else {
							if (key_left || key_right) { is_left = key_left; }
							state = PLAYER_STATES.LAND;
							transition_timer = 8;
						}
					}
				}
				else {
					// Keep Falling
					y += 8;
					transition_timer = 4;
					fall_timer++;
					if (fall_timer >= 16) { state = PLAYER_STATES.POWERFALL; }
				}
				break;
			}
			case PLAYER_STATES.LADDER:
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {	
				if (transition_timer == 0) { // This is because we add some timer lag when first grabbing the ladder
					if (key_up && can_ladder_up()) {
						y -= 8;
						transition_timer = 8;	
						state = PLAYER_STATES.LADDER_UP;
					}
					else if (key_down && can_ladder_down()) {
						y += 8;
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
					cape_state = CAPE_STATES.FLUTTER;
					cape_sprite_index = spr_cape_flutter;
					cape_image_index = 0;
					cape_timer = 8;
				}
				else if (state == PLAYER_STATES.STAND || state == PLAYER_STATES.PUSH || state == PLAYER_STATES.PUSH_WALK) {
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
	
	// Update Cape Depth Relative to Player
	switch (state) {
		case PLAYER_STATES.FALL: {
			if (sprite_index == spr_player_tumble && image_index > 0) { cape_depth = depth - 1; }
			else { cape_depth = depth + 1; }
			break;
		}
		case PLAYER_STATES.LADDER:
		case PLAYER_STATES.LADDER_UP:
		case  PLAYER_STATES.LADDER_DOWN:
		case  PLAYER_STATES.POWERFALL: {
			cape_depth = depth - 1;
			break;
		}
		default: {
			cape_depth = depth + 1;
			break;
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

	// Clean up ds lists
	if (_ground_objects != undefined && ds_exists(_ground_objects, ds_type_list)) { ds_list_destroy(_ground_objects); }
	if (_ceiling_objects != undefined && ds_exists(_ceiling_objects, ds_type_list)) { ds_list_destroy(_ceiling_objects); }
	if (_wall_objects != undefined && ds_exists(_wall_objects, ds_type_list)) { ds_list_destroy(_wall_objects); }
}

function update_player_graphics() {
	image_xscale = (is_left) ? -1 : 1;
	if (prev_state != state) {
		image_index = 0;
		// Set New Sprites
		switch (state) {
			case PLAYER_STATES.CLIMB: {
				sprite_index = spr_player_climb;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.STAND: {
				sprite_index = spr_player_idle;
				image_index = 0;
				break;
			}
			case PLAYER_STATES.WALK: {
				sprite_index = spr_player_walk;
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
	if (state == PLAYER_STATES.FALL && fall_timer == 10) {
		sprite_index = spr_player_tumble;
		image_index = -1;
	}
	
	// Update Animations
	image_speed = 0;
	if (state != prev_state) { animation_timer = 0; }
	else { animation_timer++; }
	if (animation_timer >= 64) { animation_timer = 0; }
	switch (state) {
		case PLAYER_STATES.STAND: { if (sprite_index == spr_player_idle && idle_timer % 32 == 0) { image_index++; } break; }
		case PLAYER_STATES.PUSH:
		case PLAYER_STATES.PUSH_WALK: 
		case PLAYER_STATES.LADDER_UP:
		case PLAYER_STATES.LADDER_DOWN: { if (animation_timer % 8 == 0) { image_index++; } break; }
		case PLAYER_STATES.LAND:
		case PLAYER_STATES.WALK: { if (animation_timer % 4 == 0) { image_index++; } break; }
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