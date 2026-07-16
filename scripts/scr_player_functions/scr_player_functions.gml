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

player_state_to_string = function(state) {
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

cape_state_to_string = function() {
	var _cape_state_string = "UNKNOWN STATE"
	switch (cape_state) {
		case CAPE_STATES.STAND: { _cape_state_string = "Stand"; break; }
		case CAPE_STATES.CROUCH: { _cape_state_string = "Crouch"; break; }
		case CAPE_STATES.FLUTTER: { _cape_state_string = "Fluttering"; break; }
		case CAPE_STATES.STOP_FLUTTER: { _cape_state_string = "Stop Fluttering"; break; }
		case CAPE_STATES.TURN: { _cape_state_string = "Turn"; break; }
		case CAPE_STATES.LADDER: { _cape_state_string = "Ladder"; break; }
		case CAPE_STATES.FALL_TO_LADDER: { _cape_state_string = "Fall to Ladder"; break; }
		case CAPE_STATES.FLY: { _cape_state_string = "Fly"; break; }
		case CAPE_STATES.FALL_START: { _cape_state_string = "Start to Fall"; break; }
		case CAPE_STATES.FALL: { _cape_state_string = "Fall";break; }
		case CAPE_STATES.RECOIL: { _cape_state_string = "Recoil";break; }
		case CAPE_STATES.WIN: { _cape_state_string = "Win";break; }
	}
	return _cape_state_string;
}

is_push_state = function() {
	return (state == PLAYER_STATES.PUSH_STAND || state == PLAYER_STATES.PUSH_FORWARD)
}

is_crushed_state = function() {
	return (state == PLAYER_STATES.CRUSHED_STAND || state == PLAYER_STATES.CRUSHED_FORWARD);
}

is_stand_state = function() {
	return (state == PLAYER_STATES.STAND || state == PLAYER_STATES.LOOK_UP || state == PLAYER_STATES.PUSH_STAND || state == PLAYER_STATES.CRUSHED_STAND);
}

is_hop_down_state = function() {
	return (state == PLAYER_STATES.HOP_DOWN || state == PLAYER_STATES.HOP_DOWN_FORWARD);
}

is_hop_up_state = function() {
	return (state == PLAYER_STATES.HOP_UP || state == PLAYER_STATES.HOP_UP_FORWARD);
}

is_hop_forward_state = function() {
	return (state == PLAYER_STATES.HOP_DOWN_FORWARD || state == PLAYER_STATES.HOP_UP_FORWARD);
}

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
	return (state == PLAYER_STATES.FALL || state == PLAYER_STATES.DAZED_FALL || state == PLAYER_STATES.TUMBLE || state == PLAYER_STATES.POWERFALL)
}
	
is_crouch_state = function() {
	return (state == PLAYER_STATES.CROUCH || state == PLAYER_STATES.POWERCROUCH)
}
	
is_floating_state = function() {
	return state == PLAYER_STATES.SWIM;
}
	
// Control Functions
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
	
// State Updating Functions
start_falling = function(_is_dazed = false) {
	state =  (_is_dazed) ? PLAYER_STATES.DAZED_FALL : PLAYER_STATES.FALL;
	fall_timer = 0;
	recoil_timer = 0;
	grid_move_down(2);
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
	if (is_on_ground()) {
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

start_turning = function(_prev_is_left) {
	state = PLAYER_STATES.TURN;
	transition_timer = 4;
	is_left = _prev_is_left;
	walk_on_ground_objects();
}
	
walk_on_ground_objects = function() {
	if (is_on_ground() || air_walk) {
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
	grid_move_to((is_left) ? x-8 : x+8, y);
	walk_on_ground_objects();
	grid_move_to(_prev_x, _prev_y);
		
	// Continue with Walking or Fall
	if (is_on_ground() || air_walk) {
		state = (_is_crushed) ? PLAYER_STATES.CRUSHED_FORWARD : PLAYER_STATES.WALK_FORWARD;
		var _speed = (_is_crushed) ? 0.5 : 2;
		grid_move_horizontal(_speed * left_value())
		transition_timer = (_is_crushed) ? 4 : 0;
	}
	else { start_falling(); }
}
	
start_hopping = function(_should_move_horizontally = false) {
	play_sound(snd_player_jump);
	state = (_should_move_horizontally) ? PLAYER_STATES.HOP_UP_FORWARD: PLAYER_STATES.HOP_UP
	if (_should_move_horizontally) { grid_move_horizontal(left_value()); }
	grid_move_up(1);
}
	
start_laddering = function() {
	var _can_ladder = can_start_laddering(), _should_ladder = (_can_ladder && (key_up || key_down));
	if (_should_ladder) {
		state = PLAYER_STATES.LADDER;
		transition_timer = 4;
		play_sound(snd_player_ladder_step);
	}
	return _should_ladder;
}
	
// Positional Functions
get_closest_ladder = function() {
var _closest_ladder = noone, _ladder_objects = instances_at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder);
	
for (var _i = 0; _i < array_length(_ladder_objects); _i++) {
	var _ladder = _ladder_objects[_i];
	if (x == _ladder.x) { _closest_ladder = _ladder; }
}
	
return _closest_ladder;
}

can_ladder_up = function(_closest_ladder) {
	return (
		instance_exists(_closest_ladder) &&
		x == _closest_ladder.x &&
		(y > _closest_ladder.y || at_grid_position(x, _closest_ladder.y-sprite_get_height(sprite_index), sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder))
	);
}

can_ladder_down = function(_closest_ladder) {
	return (
		instance_exists(_closest_ladder) &&
		x == _closest_ladder.x &&
		(!is_on_ground() || at_grid_position(x, y + sprite_get_height(sprite_index), sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder))
	);
}

can_start_laddering = function() {
	return at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder);
}

left_value = function() {
	return ((is_left) ? -1 : 1);
}

// Main Functions
update_player_state = function() {
	prev_state = state;

	// Check Controls
	if (state != PLAYER_STATES.WIN) { reset_controls(); }
	update_controls();

	// Reset various player state timers
	if (!is_ladder_state()) { is_up = false; }
	if (state != PLAYER_STATES.STAND) { idle_timer = 0; }
	if (state != PLAYER_STATES.CROUCH && state != PLAYER_STATES.POWERCROUCH) { crouch_timer = 0; }
	if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.TUMBLE && state != PLAYER_STATES.POWERFALL) { fall_timer = 0; }
	if (state != PLAYER_STATES.RECOIL) { recoil_timer = 0; }
	if (state != PLAYER_STATES.FLY && state != PLAYER_STATES.POWERFLY) { fly_timer = 0; }
	if (state != PLAYER_STATES.SWIM && state != PLAYER_STATES.SWIM_FORWARD) { swim_timer = 0; }
	
	// While Transitioning
	if (transition_timer > 0) {
		switch (state) {
			case PLAYER_STATES.SWIM_FORWARD: { swim_timer ++; break; }
			case PLAYER_STATES.POWERFLY: { fly_timer++; break; }
			case PLAYER_STATES.RECOIL: { recoil_timer++; break; }
			case PLAYER_STATES.TUMBLE:
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.DAZED_FALL:
			case PLAYER_STATES.POWERFALL: { fall_timer++; break; }
			case PLAYER_STATES.CLIMB: {
				if (transition_timer == 20) {
					grid_move_up(1);
				}
				else if (transition_timer == 18) {
					grid_move_horizontal(left_value())
					walk_on_ground_objects();
				}
				else if (transition_timer < 6) { transition_timer = 0; }
				
				break;
			}
			case PLAYER_STATES.WIN: {
				if (visible) {
					if (transition_timer == 51) { image_index = 0; cape_image_index = 0; }
					if (transition_timer == 36) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); }
					if (transition_timer == 28) { image_index = 0; cape_image_index = 0; }
					if (transition_timer == 24) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); }
					if (transition_timer == 20) { image_index = 0; cape_image_index = 0; }
					if (transition_timer == 14) { image_index = 2; cape_image_index = 0; play_sound(snd_key); create_sparkles(4 + irandom(6)); }
				}
				if (transition_timer == 1) { image_index = 0; cape_image_index = 0; cape_timer = 52; }
				break;
			}
		}
	}
	
	// While Not Transitioning
	if (transition_timer == 0) {
		update_player_collisions_at_position();
		
		switch (state) {
			case PLAYER_STATES.SWIM:
			case PLAYER_STATES.SWIM_FORWARD: {
				swim_timer++;

				if (start_laddering()) { }
				else if (is_on_ground()) { start_standing(); }
				// else if (fully_submerged()) { start_surfacing(); }
				else if (!is_partially_submerged()) { start_falling(); }
				else {
					if (key_left || key_right) { is_left = key_left; }
					
					var _horizontal_input = ((is_left && key_left) || (!is_left && key_right));
					var _can_climb = (key_jump || key_up) && !is_under_ceiling();
					var _can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
					var _climbable_objects = (is_left) ? get_left_climbable_objects([id]) : get_right_climbable_objects([id]);
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
					with (obj_door) { image_index = 2; create_particles(8 + irandom(8), global.PALETTE_YELLOW); }
					// TODO: Do this in controller instead of player?
					global.controller.transition_timer = 1;
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
				// Check Current Position
				var _can_walk = ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right());
				var _horizontal_input = ((is_left && key_left) || (!is_left && key_right));
				var _on_hop_height_ground = false, _prev_x = x, _prev_y = y;
				grid_move_to((is_left) ? x-8 : x+8, y);
				_on_hop_height_ground = is_on_ground();
				grid_move_to(_prev_x, _prev_y);

				// Determine New State
				if (start_laddering()) { } // Just do the Ladder Stuff
				else if (is_on_ground()) { start_standing(); }
				else if (_on_hop_height_ground && _can_walk && _horizontal_input) {
					air_walk = true;
					start_walking();
				}
				else {
					var _can_climb = (state == PLAYER_STATES.HOP_UP && (key_jump || key_up || global.controller.original_controls)) && !is_under_ceiling();
					var _climbable_objects = (is_left) ? get_left_climbable_objects([id]) : get_right_climbable_objects([id]);
					var _climbed_obj = grid_array_first(_climbable_objects);
					_can_climb = _can_climb && instance_exists(_climbed_obj) && y < _climbed_obj.y;
					
					if (_can_climb && (_horizontal_input || global.controller.original_controls)) { start_climbing(_climbed_obj); }
					else {
						if (_can_walk && state == PLAYER_STATES.HOP_UP_FORWARD) {
							state = PLAYER_STATES.HOP_DOWN_FORWARD
							grid_move_horizontal(left_value());
						}
						else { state = PLAYER_STATES.HOP_DOWN; }
						grid_move_down(1);
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
				// Update New State
				if (state == PLAYER_STATES.TURN) { is_left = !is_left; }
				if (state != PLAYER_STATES.CRUSHED_STAND && state != PLAYER_STATES.CRUSHED_FORWARD && start_laddering()) { }
				else if (!is_on_ground()) {
					start_falling();
				}
				else {
					// Update Whether Crushed By Objects
					var _ceiling_objects = get_ceiling_objects(), _crushed_by_object = false;
					if (can_be_crushed) {
						for (var _i = 0; _i < array_length(_ceiling_objects); _i++) {
							var _inst = _ceiling_objects[_i];
							if (instance_exists(_inst) && _inst.has_gravity && _inst.is_on_ground()) {
								is_solid_from_above = false;
								if (!_inst.is_on_ground() && _inst.state != STATES.FALLING) { _crushed_by_object = true; }
								is_solid_from_above = true;
							}
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
						(prev_state == PLAYER_STATES.STAND ||
							prev_state == PLAYER_STATES.HOP_UP_FORWARD ||
							prev_state == PLAYER_STATES.HOP_DOWN_FORWARD ||
							prev_state == PLAYER_STATES.WALK_FORWARD ||
							prev_state == PLAYER_STATES.PUSH_FORWARD ||
							prev_state == PLAYER_STATES.PUSH_STAND ||
							prev_state == PLAYER_STATES.TURN)) {
						start_turning(_prev_is_left);
					}
						
					// Update Landing on Objects from Hop/Airwalk
					if (is_hop_down_state()) {
						if (transition_timer == 0) { start_standing(); }
						transition_timer = 4;
						var _ground_objects = get_ground_objects();
						for (var _i = 0; _i < array_length(_ground_objects); _i++) {
							var _inst = _ground_objects[_i];
							if (instance_exists(_inst) && _inst.is_solid_from_above) { _inst.fall_on(fall_timer); }
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
							var _climbable_objects = (is_left) ? get_left_climbable_objects([id]) : get_right_climbable_objects([id]);
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

								if (can_push_objects && _can_walk && y == _pushed_obj.y) {
									// Push Box
									_pushed_obj.start_being_pushed(is_left);
									// Push Self
									state = PLAYER_STATES.PUSH_FORWARD;
									grid_move_horizontal(left_value())
								}
								else if (can_push_objects) {
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
								if (state == PLAYER_STATES.POWERCROUCH && can_power_up) {
									state = PLAYER_STATES.POWERFLY;
									play_sound(snd_player_takeoff);
									grid_move_up(2);
								}
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
									if (_inst.is_solid_from_below && _inst.id != id && !array_contains(_damaged_instances, _inst.id)) {
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
											if (_new_inst.object_index == _inst.object_index && _new_inst.is_solid_from_below && _new_inst.id != id && !array_contains(_damaged_instances, _new_inst.id)) {
												array_push(_damaged_instances, _new_inst.id);
											}
										}
									}
									_inst.powerfly_into(); 
								}
							}
							if (_play_sound) { play_sound(snd_impact); }
						
							// Player reaction to Collision
							start_falling(true);
						}
						else { start_falling(); }
					}
					else {
						// Keep Flying
						grid_move_up(2);
						if (fly_timer >= 16 && state != PLAYER_STATES.POWERFLY) { state = PLAYER_STATES.POWERFLY; play_sound(snd_player_powerup); }
					}
				}
				break;
			}
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.DAZED_FALL:
			case PLAYER_STATES.TUMBLE:
			case PLAYER_STATES.POWERFALL: {
				if (start_laddering()) { }
				else {
					// First, land on ground objects
					if (is_on_ground()) {
						// Attempt to Land on Ground
						var _ground_objects = get_ground_objects();
						for (var _i = 0; _i < array_length(_ground_objects); _i++) {
							var _inst = _ground_objects[_i];
							_inst.fall_on(fall_timer);
						}
					}
				
					if (is_on_ground()) {
						// Bonk against floor
						if (state == PLAYER_STATES.POWERFALL && !is_fully_submerged() && !is_partially_submerged()) {
							// Get Targets to Damage
							var _damaged_instances = [];
							for (var _dir = 0; _dir < 2; _dir++) {
								var _x_offset = (_dir == 1) ? 8 : 0, _y_offset = 16;
							
								var _instances_to_check = instances_at_grid_position(x+_x_offset, y+_y_offset, 8, 8);
								for (var _i = 0; _i < array_length(_instances_to_check); _i++) {
									var _inst =  _instances_to_check[_i]
									if (_inst.is_solid_from_above && _inst.id != id && !array_contains(_damaged_instances, _inst.id)) {
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
											if (_new_inst.object_index == _inst.object_index && _new_inst.is_solid_from_above && _new_inst.id != id && !array_contains(_damaged_instances, _new_inst.id)) {
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
							if (!grid_move_up(4)) { play_sound(snd_soft_thud); }
						}
						else if (state != PLAYER_STATES.TUMBLE) {
							// Land without extra Delay
							start_standing();
							//transition_timer = 4;
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
						if (can_power_up) {
							if (fall_timer >= 8 && state == PLAYER_STATES.FALL) { state = PLAYER_STATES.TUMBLE; }
							if (fall_timer >= 12 && state == PLAYER_STATES.TUMBLE) { state = PLAYER_STATES.POWERFALL; play_sound(snd_player_takeoff); }
						}
						grid_move_down(2);
					}
				}
				break;
			}
			case PLAYER_STATES.RECOIL: {
				// Decide New State
				if (start_laddering()) { }
				else if (is_on_ground()) { start_standing(); }
				else if (is_under_ceiling() || recoil_timer >= 4) { start_falling(); fall_timer = -8; }
				else {
					// Keep Recoiling
					grid_move_up(4);
				}
				break;
			}
			case PLAYER_STATES.LADDER:
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {
				// Decide New State Based on Player Input
				var _closest_ladder = get_closest_ladder();
				if (instance_exists(_closest_ladder)) {
					if (key_up || key_down) { is_up = key_up; }

					if (key_up && can_ladder_up(_closest_ladder)) {
						state = PLAYER_STATES.LADDER_UP;
						play_sound(snd_player_ladder_step);
						grid_move_up_direct(1);
					}
					else if (key_down && can_ladder_down(_closest_ladder)) {
						state = PLAYER_STATES.LADDER_DOWN;
						play_sound(snd_player_ladder_step);
						grid_move_down_direct(1);
					}
					else if ((key_left || key_right) && (is_on_ground() && !is_inside_solid())) { is_left = key_left; start_walking(); }
					else { state = PLAYER_STATES.LADDER; }
				}
				else { start_falling(); }
						

				break;
			}
			case PLAYER_STATES.CLIMB: {
				if (is_on_ground()) {
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
	}
}

set_cape_state = function(_state, _sprite, _image, _timer) {
	cape_state = _state;
	cape_sprite_index = _sprite;
	cape_image_index = _image;
	cape_timer = _timer;

}

start_cape_flutter = function() { set_cape_state(CAPE_STATES.FLUTTER, spr_cape_flutter, 0, 8); }
start_cape_flutter_end = function() { set_cape_state(CAPE_STATES.STOP_FLUTTER, spr_cape_stop_flutter, 0, 4); }
start_cape_fly = function() { set_cape_state(CAPE_STATES.FLY, spr_cape_fly, 0, 8); }
start_cape_fall = function() { set_cape_state(CAPE_STATES.FALL, spr_cape_fall, 0, 8); }
start_cape_fall_begin = function() { set_cape_state(CAPE_STATES.FALL_START, spr_cape_fall_start, 0, 4); }
start_cape_fall_onto_ladder = function() { set_cape_state(CAPE_STATES.FALL_TO_LADDER, spr_cape_fall_to_ladder, 2, 4); }
start_cape_fall_onto_ladder_full = function() { set_cape_state(CAPE_STATES.FALL_TO_LADDER, spr_cape_fall_to_ladder, 0, 8); }
start_cape_crushed = function() { set_cape_state(CAPE_STATES.STAND, spr_cape_crushed, 0, 0); }
start_cape_win = function() { set_cape_state(CAPE_STATES.WIN, spr_cape_crushed, 0, 52); }
start_cape_stand = function() { set_cape_state(CAPE_STATES.STAND, spr_cape_stand, 0, 0); }
start_cape_crouch = function() { set_cape_state(CAPE_STATES.CROUCH, spr_cape_crouch, 0, 0); }
start_cape_ladder = function() { set_cape_state(CAPE_STATES.LADDER, spr_cape_ladder, 0, 0); }
start_cape_land = function() { set_cape_state(CAPE_STATES.RECOIL, spr_cape_recoil, 0, 4); }
start_cape_recoil = function() { set_cape_state(CAPE_STATES.RECOIL, spr_cape_recoil, 0, 8); }
start_cape_turn = function() { set_cape_state(CAPE_STATES.TURN, spr_cape_turn, 0, 4); }
			
update_cape_graphics = function() {
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
			case CAPE_STATES.WIN: { start_cape_win(); break; }
			case CAPE_STATES.RECOIL: {
				if (is_fall_state()) { start_cape_fall_begin(); }
				else if (state == PLAYER_STATES.RECOIL) { start_cape_fly(); }
				else { start_cape_flutter(); }
				break;
			}
			case CAPE_STATES.FLUTTER:
			case CAPE_STATES.TURN: {
				if (state == PLAYER_STATES.WALK_FORWARD) { start_cape_flutter(); }
				else if (is_fall_state()) { start_cape_fall_begin(); }
				else if (is_ladder_state()) { start_cape_fall_onto_ladder(); }
				else { start_cape_flutter_end(); }
				break;
			}
			case CAPE_STATES.STOP_FLUTTER:
			case CAPE_STATES.STAND:
			case CAPE_STATES.CROUCH: {
				if (state == PLAYER_STATES.WALK_FORWARD) { start_cape_flutter(); }
				else if (is_crushed_state()) { start_cape_crushed(); }
				else if (is_stand_state() || is_push_state()) { start_cape_stand(); }
				else if (is_crouch_state()) { start_cape_crouch(); }
				else if (is_ladder_state()) { start_cape_ladder(); }
				else if (is_fall_state()) { start_cape_fall_begin(); }
				else if (state == PLAYER_STATES.WIN) { start_cape_crushed(); }
				break;
			}
			case CAPE_STATES.FLY: {
				if (is_fly_state()) { start_cape_fly(); }
				else if (is_fall_state()) { start_cape_fall_begin(); }
				else if (is_ladder_state()) { start_cape_ladder(); }
				break;
			}
			case CAPE_STATES.FALL_START: {
				if (is_fall_state()) { start_cape_fall(); }
				else if (state == PLAYER_STATES.LAND) { start_cape_land(); }
				else if (is_ladder_state()) { start_cape_fall_onto_ladder_full(); }
				else { start_cape_flutter_end(); }
				break;
			}
			case CAPE_STATES.FALL_TO_LADDER: {
				if (is_ladder_state()) { start_cape_ladder(); }
				else { start_cape_flutter_end(); }
				break;
			}
			case CAPE_STATES.FALL: {
				if (is_fall_state()) { start_cape_fall(); }
				else if (state == PLAYER_STATES.LAND) { start_cape_land(); }
				else if (state == PLAYER_STATES.RECOIL) { start_cape_recoil(); }
				else { start_cape_flutter_end(); }
				break;
			}
			default: {
				if (!is_ladder_state()) { start_cape_stand(); }
				break;
			}
		}
	}
	
	// Interrupt Previous Cape State to Set New One
	if (state != prev_state) {
		if ((cape_state == CAPE_STATES.FALL_START || cape_state == CAPE_STATES.FALL) && is_grounded_state()) { start_cape_flutter_end(); }
		else if (state == PLAYER_STATES.HOP_UP || state == PLAYER_STATES.HOP_UP_FORWARD) { start_cape_flutter_end(); }
		else if (state == PLAYER_STATES.HOP_DOWN || state == PLAYER_STATES.HOP_DOWN_FORWARD) { start_cape_flutter(); }
		else if (state == PLAYER_STATES.TURN) { start_cape_turn(); }
		else if (state == PLAYER_STATES.FLY || state == PLAYER_STATES.POWERFLY) {
			if (cape_state != CAPE_STATES.FLY) { start_cape_fly(); }
		}
		else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.DAZED_FALL) { start_cape_fall_begin(); }
		else if (state == PLAYER_STATES.WIN) { start_cape_win(); }
		else if (state == PLAYER_STATES.LAND) { start_cape_land(); }
		else if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN) {
			if (cape_state == CAPE_STATES.FLUTTER || cape_state == CAPE_STATES.FALL) { start_cape_fall_onto_ladder(); }
			else if (cape_state != CAPE_STATES.FALL_TO_LADDER) { start_cape_ladder(); }
		}
	}
	else if (state == PLAYER_STATES.LAND && image_index > 0) {
		// Switch from falling to behind cape in the middle of landing animatiom
		start_cape_flutter_end()
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

update_player_graphics = function() {
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
				sprite_index = spr_player_fly;
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
			if (animation_timer % animation_speed == 0) { image_index++; if (state == PLAYER_STATES.STAND) { idle_timer++; } }
			image_index = image_index % image_number;
			// Update Step Index
			if (state == PLAYER_STATES.LADDER_DOWN || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.WALK_FORWARD || state == PLAYER_STATES.PUSH_FORWARD) {
				if (image_index % 2 == 1) { step_index = image_index + 2; }
			}
		}
		
		// Update Images for Idle Animations
		if (sprite_index == spr_player_idle && state == PLAYER_STATES.STAND) {
			if (idle_timer >= 12 && idle_cycle == 0) { idle_timer = 0; idle_cycle++; }
			else if (idle_timer >= 13 && idle_cycle == 1) { idle_timer = 0; idle_cycle++; }
			else if (idle_timer >= 14 && idle_cycle == 2) { idle_timer = 0; idle_cycle++; }
			else if (idle_timer >= 16 && idle_cycle == 3) { idle_timer = 0; idle_cycle++; }
			else if (idle_timer >= 18 && idle_cycle == 4) { idle_timer = 0; idle_cycle++; }
			else if (idle_timer >= 24 && idle_cycle == 5) { idle_timer = 0; idle_cycle = 0; }
		
			if (idle_timer >= 0 && idle_timer < 12) { image_index = 0; }
			else if (idle_timer >= 12 && idle_timer < 14) { image_index = 1; }
			else if (idle_timer >= 14 && idle_timer < 16) { image_index = 2; }
			else if (idle_timer >= 16 && idle_timer < 18) { image_index = 3; }
			else if (idle_timer >= 18 && idle_timer < 19) { image_index = 4; }
			else if (idle_timer >= 19 && idle_timer < 21) { image_index = 3; }
			else if (idle_timer >= 21 && idle_timer < 23) { image_index = 2; }
			else if (idle_timer >= 23) { image_index = 1; }
		}

		// Update Palette
		main_palette = original_palette;
		if ((state == PLAYER_STATES.POWERFLY || state == PLAYER_STATES.POWERFALL || state == PLAYER_STATES.POWERCROUCH) && (animation_timer % 2 == 0)) {
			main_palette = powered_palette; 
		}
	}
}

update_player_collisions_at_position = function() {
	// Get Destroyed From Stepping on Lethal Tiles
	var _grounded_objects = get_ground_objects();
	for (var _i = 0; _i < array_length(_grounded_objects); _i++) {
		var _inst = _grounded_objects[_i]
		if (instance_exists(_inst)) {
			if (object_index == obj_player && _inst.is_player_lethal) { instance_destroy(); }
			if (object_index != obj_player && _inst.is_robot_lethal) { instance_destroy(); }
		}
	}
	
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
	
	// Collide with Full Overlaps
	var _fully_overlapping_instances = instances_at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	for (var _i = 0; _i < array_length(_fully_overlapping_instances); _i++) {
		var _inst = _fully_overlapping_instances[_i];
		if (!instance_exists(_inst)) { continue; }
		
		if (is_a(_inst, obj_door)) {
			if (can_be_controlled && _inst.image_index > 0 && (is_grounded_state() || is_fall_state())) {
				start_winning();
				stop_music();
				play_sound(snd_level_clear);
			}
		}
		if (is_a(_inst, obj_key)) {
			if (can_be_controlled) {
				with (_inst) {
					instance_destroy();
					create_sparkles(8 + irandom(8));
				}
			}
		}
	}
}
