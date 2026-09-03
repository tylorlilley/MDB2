enum PLAYER_STATES
{
	// Grounded States
	STAND,
	STAND_EDGE,
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
	SURFACE,
	SWIM,
	SWIM_FORWARD,
	LAND,
	// Non-Grounded States
	FLY, // Currently Unused
	HOP_UP,
	HOP_HANG,
	HOP_DOWN,
	HOP_UP_FORWARD,
	HOP_DOWN_FORWARD,
	POWERFLY,
	FALL,
	DAZED_FALL,
	TUMBLE,
	POWERFALL,
	RECOIL,
	LADDER,
	LADDER_LOOK,
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

enum DIRECTIONS { NONE, LEFT, RIGHT, UP, DOWN }

player_state_to_string = function(_state) {
	var _player_state_string = "UNKNOWN STATE"
	switch (_state) {
		case PLAYER_STATES.STAND: { _player_state_string = "Stand"; break; }
		case PLAYER_STATES.STAND_EDGE: { _player_state_string = "Stand on Edge"; break; }
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
		case PLAYER_STATES.LADDER_LOOK: { _player_state_string = "Ladder Look"; break; }
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

cape_state_to_string = function(_cape_state) {
	var _cape_state_string = "UNKNOWN STATE"
	switch (_cape_state) {
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

is_pose_state = function() {
	return (state == PLAYER_STATES.LOOK_UP || state == PLAYER_STATES.CROUCH || state == PLAYER_STATES.PUSH_STAND || state == PLAYER_STATES.LADDER_LOOK);
}

should_pose = function(_dir, _in_pose) { return (pose_dir == _dir && pose_timer >= ((_in_pose) ? 1 : 4)); }

is_powered_state = function() {
	return (state == PLAYER_STATES.POWERFALL || state == PLAYER_STATES.POWERFLY);
}

is_push_state = function() {
	return (state == PLAYER_STATES.PUSH_STAND || state == PLAYER_STATES.PUSH_FORWARD)
}

is_crushed_state = function() {
	return (state == PLAYER_STATES.CRUSHED_STAND || state == PLAYER_STATES.CRUSHED_FORWARD);
}

is_stand_state = function() {
	return (state == PLAYER_STATES.STAND_EDGE || state == PLAYER_STATES.STAND || state == PLAYER_STATES.LOOK_UP || state == PLAYER_STATES.PUSH_STAND || state == PLAYER_STATES.CRUSHED_STAND);
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
	return (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_LOOK || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.LADDER_DOWN)
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
	key_restart = false;
}

function determine_gamepad() {
	var _gp_num = gamepad_get_device_count();
	global.gamepad = noone;
	for (var _i = 0; _i < _gp_num; _i++) {
	    if (gamepad_is_connected(_i)) { global.gamepad = _i; break; }
	}
	return global.gamepad;
}
	
update_controls = function(_inverted = false) {
	// Accumulate Inputs
	var _new_left_value = ((_inverted) ? key_right : key_left) || get_left_held();
	var _new_right_value = ((_inverted) ? key_left : key_right) || get_right_held();
	var _new_up_value = key_up || get_up_held();
	var _new_down_value = key_down || get_down_held();
	var _new_jump_value = key_jump || get_jump_held();
	var _new_restart_value = key_restart || get_restart_held();
	
	// Cancel out released inputs
	if (get_left_released()) { _new_left_value = false; }
	if (get_right_released()) { _new_right_value = false; }
	if (get_up_released()) { _new_up_value = false; }
	if (get_down_released()) { _new_down_value = false; }
	if (get_jump_released()) { _new_jump_value = false; }
	if (get_restart_released()) { _new_restart_value = false; }

	// Cancel out opposite inputs in favor of currently moving direction
	if (_new_left_value && _new_right_value) {
		if (is_left) { _new_right_value = false; }
		else { _new_left_value = false; }
	}
	if (_new_up_value && _new_down_value) {
		if (is_up) { _new_down_value = false; }
		else { _new_up_value = false; }
	}
	
	key_left = (_inverted) ? _new_right_value : _new_left_value;
	key_right = (_inverted) ? _new_left_value : _new_right_value;
	key_up = _new_up_value;
	key_down = _new_down_value;
	key_jump =_new_jump_value;
	key_restart = _new_restart_value;
}
	
// State Updating Functions
start_pushing = function(_pushed_obj) {
	// Push Box
	if (!_pushed_obj.start_being_pushed(is_left)) { return false; }
	// Push Self
	return grid_move_horizontal(get_left_value());
}

start_tumble_landing = function() {
	if (state == PLAYER_STATES.POWERFALL) { create_afterimage(); }
	play_sound(snd_soft_thud);
	state = PLAYER_STATES.LAND;
	do_player_object_collisions();
	if (!instance_exists(id)) { exit; }
	
	if (key_left || key_right) { is_left = key_left; }
	set_transition_timer(8); // MUST HAPPEN AFTER COLLISIONS
}
	
start_winning = function() {
	start_cape_win();
	state = PLAYER_STATES.WIN;
	set_transition_timer(52);
	image_index = 0;
}
	
start_climbing = function() {	
	state = PLAYER_STATES.CLIMB;
	set_transition_timer(24);
	climbed_inst = get_climbed_object();
	return true;
}

start_fallback_state = function(_is_crushed = false) {
	if (should_start_laddering()) { start_laddering(); }
	else if (is_on_ground()) { start_standing(_is_crushed); }
	else { start_falling(); }
}
	
start_standing = function(_is_crushed = false) {
	if (_is_crushed) { state = PLAYER_STATES.CRUSHED_STAND; }
	else if (state == PLAYER_STATES.PUSH_STAND && should_pose((is_left) ? DIRECTIONS.LEFT : DIRECTIONS.RIGHT, true)) { /* Keep the push pose while it drains */ }
	else if (can_duck && state != PLAYER_STATES.STAND_EDGE && should_pose(DIRECTIONS.DOWN, state == PLAYER_STATES.CROUCH)) { state = PLAYER_STATES.CROUCH; }
	else if (can_look_up && should_pose(DIRECTIONS.UP, state == PLAYER_STATES.LOOK_UP)) { state = PLAYER_STATES.LOOK_UP; }
 	else { state = PLAYER_STATES.STAND; }
	
	set_transition_timer((_is_crushed) ? 4 : 0);
	air_walk = false;
	if (key_left || key_right) { is_left = key_left; }
}

start_falling = function(_is_dazed = false) {
	transition_timer = 0;
	sync_transition_timer();
	fall_timer = 0;
	grid_move_down(2); // If this fails, we still proceed with setting the fall state as the ultimate state fallback
	state =  (_is_dazed) ? PLAYER_STATES.DAZED_FALL : PLAYER_STATES.FALL;
	stop_sound(fall_sound);
	fall_sound = audio_play_sound_panned(snd_player_fall, x);
}

start_laddering = function() {
	state = PLAYER_STATES.LADDER;
	set_transition_timer(4);
	play_sound(snd_player_ladder_step);
}

should_start_laddering = function() {
	var _auto_grab = global.original_controls && ((is_grounded_state() && !is_on_ground()) || is_fall_state());
	var _should_ladder = ((key_up || key_down || _auto_grab) && can_ladder_at(x, y));
	
	return _should_ladder;
}

start_turning = function() {
	if (state == PLAYER_STATES.TURN) { prev_state = PLAYER_STATES.STAND; }
	state = PLAYER_STATES.TURN;
	set_transition_timer(4);
	walk_on_ground_objects();
}

start_walking = function(_is_crushed = false) {
	// First, walk on next object
	var _prev_x = x, _prev_y = y;
	grid_move_to((is_left) ? x - GRID_SIZE : x + GRID_SIZE, y, false);
	walk_on_ground_objects();
	if (!instance_exists(id)) { exit; }
	grid_move_to(_prev_x, _prev_y, false);
		
	// Continue with Walking or Fall
	var _speed = (_is_crushed) ? 0.5 : 2;
	if (grid_move_horizontal(_speed * get_left_value())) {
		state = (_is_crushed) ? PLAYER_STATES.CRUSHED_FORWARD : PLAYER_STATES.WALK_FORWARD;
	}
}
	
start_hopping = function(_should_move_horizontally = false) {
	virtual_y_offset = get_switch_offset(); // This gets reset elsewhere if we remain grounded before being used in the Draw
	
	if (_should_move_horizontally && grid_move_horizontal(get_left_value())) { state = PLAYER_STATES.HOP_UP_FORWARD; }
	else { state = PLAYER_STATES.HOP_UP; set_transition_timer(8); }
	
	play_sound(snd_player_jump);
	if (!grid_move_up(2)) { start_fallback_state(); }
}

// Interactions with Other Object Functions
get_destroyed_by_object = function() {
	if (state == PLAYER_STATES.WIN) { exit; }
	
	play_sound(damaged_sound);
	if (instance_exists(id)) { instance_destroy(); }
}

get_damaged_by_object = function(_inst) {
	if (state == PLAYER_STATES.WIN) { exit; }
	
	if (would_be_damaged_by(_inst)) {
		get_destroyed_by_object();
		_inst.deal_damage();
	}
}

damage_objects = function(_damage_above = false) {
	var _objects_to_damage = (_damage_above) ? get_ceiling_objects() : get_ground_objects();
	
	// Also Damage Static Area Objects One Layer Deeper
	for (var _i = 0; _i < array_length(_objects_to_damage); _i++) {
		var _inst = _objects_to_damage[_i];
		if (_inst.is_a(obj_static_area)) {
			var _prev_y = y;
			grid_move_to(x, y + (_damage_above ? -GRID_SIZE : GRID_SIZE), false);
			var _deeper_objects_to_damage = (_damage_above) ? get_ceiling_objects() : get_ground_objects();
			for (var _d = 0; _d < array_length(_deeper_objects_to_damage); _d++) {
				var _deeper_inst = _deeper_objects_to_damage[_d];
				if (!instance_exists(_deeper_inst)) { continue; }
		
				if (_deeper_inst.is_a(obj_static_area) && _deeper_inst.object_index == _inst.object_index && _deeper_inst.x == _inst.x && !array_contains(_objects_to_damage, _deeper_inst)) { array_push(_objects_to_damage, _deeper_inst); }
			}
			grid_move_to(x, _prev_y, false);
		}
	}
	
	// Damage Objects
	var _damaged_objects = [];
	while (array_length(_objects_to_damage) > 0) {
		var _inst = array_pop(_objects_to_damage);
		if (!instance_exists(_inst)) { continue; }
		
		// Remove Connected Instances from Objects to Damage
		if (_inst.is_a(obj_static_area) && _inst.is_connected) {
			var _connected_instances = _inst.get_connected_instances([_inst]);
			for (var _i = 0; _i < array_length(_connected_instances); _i++) {
				var _connected_inst = _connected_instances[_i];
				if (!instance_exists(_connected_inst)) { continue; }

				var _index = array_get_index(_objects_to_damage, _connected_inst);
				if (_index >= 0) { array_delete(_objects_to_damage, _index, 1); }
			}
		}
		
		// Damage the Objects
		if (instance_exists(id)) {
			array_push(_damaged_objects, _inst.id);
			play_sound(snd_impact);
			if (_damage_above) { _inst.powerfly_into(id); }
			else { _inst.powerfall_on(id); }
		}
		
		// Interact with Reamining Objects
		if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
	}
	
	return (_damage_above) ? is_under_ceiling() : is_on_ground();
}

powerfall_on_ground_objects = function() { return damage_objects(false); }
powerfly_into_ceiling_objects = function() { return damage_objects(true); }

fall_on_ground_objects = function() {
	var _ground_objects = get_ground_objects(true);
		
	for (var _i = 0; _i < array_length(_ground_objects); _i++) {
		var _inst = _ground_objects[_i];
		if (!instance_exists(_inst)) { continue; }

		_inst.fall_on(fall_timer);
	}
}

fly_into_ceiling_objects = function() {
	var _ceiling_objects = get_ceiling_objects(true);
		
	for (var _i = 0; _i < array_length(_ceiling_objects); _i++) {
		var _inst = _ceiling_objects[_i];
		if (!instance_exists(_inst)) { continue; }
		
		_inst.fly_into(fly_timer);
		get_damaged_by_object(_inst);
	}
}

walk_on_ground_objects = function() {
	var _ground_objects = get_ground_objects();
		
	for (var _i = 0; _i < array_length(_ground_objects); _i++) {
		var _inst = _ground_objects[_i];
		if (!instance_exists(_inst)) { continue; }
		
		_inst.walk_on((controlled_by_human) ? 1 : 0);
	}
}
	
// Positional Functions
get_ladder_at = function(_x = x, _y = y) {
	if (!can_ladder) { return noone; }
	
	var _closest_ladder = noone, _ladder_objects = instances_at_grid_position(_x, _y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder);
	
	for (var _i = 0; _i < array_length(_ladder_objects); _i++) {
		var _ladder = _ladder_objects[_i];
		if (_x == _ladder.x) { _closest_ladder = _ladder; }
	}
	
	return _closest_ladder;
}

get_climbed_object = function() {
	if (!can_climb || is_under_ceiling() || (!key_jump && !key_up && !global.original_controls) || (global.original_controls && y <= 24)) { return noone; }
	var _diagonal_ceiling_objects = (is_left) ? get_left_diagonal_ceiling_objects() : get_right_diagonal_ceiling_objects();
	if (array_length(_diagonal_ceiling_objects) > 0) { return noone; }
	
	var _climbable_objects = (is_left) ? get_left_climbable_objects([id]) : get_right_climbable_objects([id]);
	var _climbed_obj = grid_array_first(_climbable_objects);

	return (instance_exists(_climbed_obj) && y < _climbed_obj.y) ? _climbed_obj : noone;
}

can_ladder_up = function(_closest_ladder) {
	return (
		instance_exists(_closest_ladder) &&
		x == _closest_ladder.x &&
		(y > _closest_ladder.y || can_ladder_at(x, y - sprite_get_height(sprite_index)))
	);
}

can_ladder_down = function(_closest_ladder) {
	return (
		instance_exists(_closest_ladder) &&
		x == _closest_ladder.x &&
		(!is_on_ground() || can_ladder_at(x, y + sprite_get_height(sprite_index)))
	);
}

can_ladder_at = function(_x = x, _y = y) {
	if (is_crushed_state()) { return false; }
	
	return (instance_exists(get_ladder_at(_x, _y)) && at_each_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder));
}

can_start_climbing = function() {
	var _prev_y = y;
	grid_move_to(x, y - GRID_SIZE, false);
	var _can_climb = instance_exists(get_climbed_object());
	grid_move_to(x, _prev_y, false);
	return _can_climb;
}

// Main Functions
update_player_state = function() {
	prev_state = state;
	
	// Press Switches
	do_switch_collisions();
	
	// Restart Room
	if (key_restart && state != PLAYER_STATES.WIN) { instance_destroy(); exit; }

	// Reset Timers
	if (!is_ladder_state()) { is_up = false; }
	if (!is_fall_state()) { stop_sound(fall_sound); fall_sound = undefined; }
	if (state != PLAYER_STATES.STAND) { idle_timer = 0; idle_loops = 0; }
	if (state != PLAYER_STATES.CROUCH && state != PLAYER_STATES.POWERCROUCH) { crouch_timer = 0; }
	if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.TUMBLE && state != PLAYER_STATES.POWERFALL) { fall_timer = 0; }
	if (state != PLAYER_STATES.FLY && state != PLAYER_STATES.POWERFLY) { fly_timer = 0; }
	if (state != PLAYER_STATES.SWIM && state != PLAYER_STATES.SWIM_FORWARD) { swim_timer = 0; }
	var _held_dir = (key_left) ? DIRECTIONS.LEFT : ((key_right) ? DIRECTIONS.RIGHT : ((key_up) ? DIRECTIONS.UP : ((key_down) ? DIRECTIONS.DOWN : DIRECTIONS.NONE)));
	if (_held_dir != DIRECTIONS.NONE && _held_dir != pose_dir) { pose_dir = _held_dir; pose_timer = 0; }
	pose_timer = clamp(pose_timer + ((_held_dir == pose_dir) ? 1 : -1), 0, 4);
	
	// Update Timers
	switch (state) {
		case PLAYER_STATES.SWIM_FORWARD: { swim_timer ++; break; }
		case PLAYER_STATES.FLY: { fly_timer++; break; }
		case PLAYER_STATES.TUMBLE:
		case PLAYER_STATES.FALL:
		case PLAYER_STATES.DAZED_FALL:
		case PLAYER_STATES.POWERFALL: { fall_timer++; break; }
	}
	
	// While Transitioning
	if (transition_timer > 0) {
		// Do things during a state transition (other than moving virtual visuals)
		switch (state) {
			case PLAYER_STATES.RECOIL: {
				if (transition_timer == 6) {
					if (!grid_move_up(4)) { play_sound(snd_soft_thud); set_transition_timer(2); }
				}
				
				break;
			}
			case PLAYER_STATES.CLIMB: {
				if (transition_timer == 20) {
					if (!grid_move_up(1)) { start_fallback_state(); }
					//else { do_player_object_collisions(); }
				}
				else if (transition_timer == 18) {
					if (grid_move_horizontal(get_left_value())) {
						walk_on_ground_objects();
						if (!instance_exists(id)) { exit; }
						start_cape_flutter_end();
					}
					else { start_fallback_state(); }
				}
				else if (transition_timer == 12) { start_cape_crouch(); }
				else if (transition_timer < 10) { transition_timer = 0; }
				
				break;
			}
			case PLAYER_STATES.HOP_UP:
			case PLAYER_STATES.HOP_UP_FORWARD: {
				// Shorten Hop Time for Original Controls
				// TODO: Allow player to grab ledge at any point after 4, autograb in original_controls
				if (global.original_controls && transition_timer <= 4 && x_transition_timer == 0) {
					reset_transition_timer();
				}
				
				break;
			}
			case PLAYER_STATES.WIN: {
				if ((key_up || key_jump) && prev_state == PLAYER_STATES.WIN && win_loops > 0) { reset_transition_timer(); }
				else if (visible) {
					if (transition_timer == 51) { image_index = 0; cape_image_index = 0; }
					else if (transition_timer == 36) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); virtual_y -= 2; }
					else if (transition_timer == 28) { image_index = 0; cape_image_index = 0; virtual_y += 2; }
					else if (transition_timer == 24) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); virtual_y -= 2; }
					else if (transition_timer == 20) { image_index = 0; cape_image_index = 0; virtual_y += 2; }
					else if (transition_timer == 14) { image_index = 3; cape_image_index = 0; play_sound(snd_key); }
					else if (transition_timer == 1) { image_index = 0; win_loops++; }
					else if (transition_timer < 14) { image_index = 2; }
				}
				break;
			}
		}
	}
	
	// Do Collisions Before Movement
	do_player_object_collisions();
	
	// While Not Transitioning
	if (instance_exists(id) && transition_timer == 0) {
		switch (state) {
			case PLAYER_STATES.SWIM:
			case PLAYER_STATES.SWIM_FORWARD: {
				if (is_on_ground()) { start_standing(); }
				// else if (fully_submerged()) { start_surfacing(); }
				else if (!is_partially_submerged()) { start_fallback_state(); }
				else {
					if (key_left || key_right) { is_left = key_left; }
					
					var _can_walk = (is_left) ? !is_blocked_on_left() : !is_blocked_on_right();
					var _horizontal_input = ((is_left && key_left) || (!is_left && key_right));
					
					if (_horizontal_input && instance_exists(get_climbed_object())) { start_climbing(); }
					else if (_horizontal_input && _can_walk && grid_move_horizontal(get_left_value())) {
						set_transition_timer(8);
						state = PLAYER_STATES.SWIM_FORWARD;
					}
					else { state = PLAYER_STATES.SWIM; }
				}
				break;
			}
			case PLAYER_STATES.WIN: {
				if (visible && (key_up || key_jump || key_restart) && win_loops > 0) {
					visible = false;
					play_sound(snd_impact);
					with (obj_door) { image_index = 2; }
					if (room == rm_intro) { global.controller.transition_room(room_next(room)); }
					else {
						global.controller.room_transition_timer = 1;
						global.controller.x = virtual_x;
						global.controller.y = virtual_y;
					}
				}
				else {
					start_winning();
				}
				break;
			}
			case PLAYER_STATES.LAND: {
				start_fallback_state();
				break;
			}
			case PLAYER_STATES.HOP_UP:
			case PLAYER_STATES.HOP_UP_FORWARD: {
				// Check Current Position
				var _can_walk = ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right());
				var _horizontal_input = ((is_left && key_left) || (!is_left && key_right));
				var _on_hop_height_ground = false, _prev_x = x, _prev_y = y;
				grid_move_to((is_left) ? x - GRID_SIZE : x + GRID_SIZE, y, false);
				_on_hop_height_ground = is_on_ground();
				grid_move_to(_prev_x, _prev_y, false);

				// Determine New State
				if (should_start_laddering()) { start_laddering(); }
				else if (is_on_ground()) { start_standing(); }
				else if (_on_hop_height_ground && _can_walk && _horizontal_input) { air_walk = true; start_walking(); }
				else if (state == PLAYER_STATES.HOP_UP && (_horizontal_input || global.original_controls) && instance_exists(get_climbed_object())) { start_climbing(); }
				else {
					// Continue with Hop Down
					if (_can_walk && state == PLAYER_STATES.HOP_UP_FORWARD && grid_move_horizontal(get_left_value())) {
						state = PLAYER_STATES.HOP_DOWN_FORWARD
					}
					else { state = PLAYER_STATES.HOP_DOWN; set_transition_timer(8); }
					
					if (!grid_move_down(2)) { start_fallback_state(); }
				}
				break;
			}
			case PLAYER_STATES.HOP_DOWN:
			case PLAYER_STATES.HOP_DOWN_FORWARD:
			case PLAYER_STATES.STAND:
			case PLAYER_STATES.STAND_EDGE:
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
				if (!is_on_ground()) { start_fallback_state(); }
				else {
					// Update Whether Crushed By Objects
					var _ceiling_objects = get_ceiling_objects(), _crushed_by_object = false;
					if (can_be_crushed) {
						for (var _i = 0; _i < array_length(_ceiling_objects); _i++) {
							var _inst = _ceiling_objects[_i];
							if (instance_exists(_inst) && _inst.has_gravity && _inst.is_on_ground()) {
								is_solid_from_above = false;
								if (!_inst.is_on_ground() && _inst.state != PLAYER_STATES.FALL) { _crushed_by_object = true; }
								is_solid_from_above = true;
							}
						}
					}
						
					// Update Facing Direction and Add Turn Delay
					var _prev_is_left = is_left;
					if (key_left || key_right) { is_left = key_left; }
					
					// Force Crushed or Turn States
					if (_crushed_by_object) {
						var _can_walk = (is_on_ground() || air_walk)  && ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right());
						
						if (_can_walk && (key_left || key_right)) { start_walking(true); }
						else { start_fallback_state(true); }
					}
					else if (is_left != _prev_is_left &&
						(prev_state == PLAYER_STATES.STAND ||
							prev_state == PLAYER_STATES.STAND_EDGE ||
							prev_state == PLAYER_STATES.LOOK_UP ||
							prev_state == PLAYER_STATES.HOP_UP_FORWARD ||
							prev_state == PLAYER_STATES.HOP_DOWN_FORWARD ||
							prev_state == PLAYER_STATES.WALK_FORWARD ||
							prev_state == PLAYER_STATES.PUSH_FORWARD ||
							prev_state == PLAYER_STATES.PUSH_STAND ||
							prev_state == PLAYER_STATES.TURN)) {
						start_turning();
					}
						
					// Update Landing on Objects from Hop/Airwalk
					if (is_hop_down_state()) {
						if (transition_timer == 0) { start_standing(); }
						set_transition_timer(4);
						fall_on_ground_objects();
					}
					else if (state == PLAYER_STATES.WALK_FORWARD && air_walk) {
						start_standing();
						set_transition_timer(4);
					}
						
					// Switch to New State Based on Player Input
					if (transition_timer == 0) {
						if (should_start_laddering()) { start_laddering(); }
						else if (key_left || key_right) {
							// Determine if Can Hop
							var _diagonal_ceiling_objects = (is_left) ? get_left_diagonal_ceiling_objects() : get_right_diagonal_ceiling_objects(), _under_diagonal_ceiling = (array_length(_diagonal_ceiling_objects) > 0);
							var _can_walk = (is_on_ground() || air_walk)  && ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right());
							var _can_hop_up = !is_under_ceiling() && (key_jump || (can_start_climbing() && global.original_controls));
							var _can_hop_forward = _can_walk && _can_hop_up && !_under_diagonal_ceiling && !global.original_controls;
							
							if (_can_hop_forward) {
								start_hopping(_can_hop_forward);
							}
							else if (_can_walk) {
								start_walking();
							}
							else if (_can_hop_up) {
								start_hopping(false);
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

								if (can_push_objects && _can_walk && instance_exists(_pushed_obj) && y == _pushed_obj.y && start_pushing(_pushed_obj)) {
									state = PLAYER_STATES.PUSH_FORWARD;
								}
								else if (can_push_objects && should_pose((is_left) ? DIRECTIONS.LEFT : DIRECTIONS.RIGHT, prev_state == PLAYER_STATES.PUSH_STAND)) {
									// Push Against Solid Wall
									state = PLAYER_STATES.PUSH_STAND;
								}
								else {
									// Stand Still - ROBOTS ONLY
									state = PLAYER_STATES.STAND;
									set_transition_timer(4)
								}

							}
						}
						else if (key_up || key_jump) {
							if (is_under_ceiling()) { start_standing(); }
							else if (state == PLAYER_STATES.POWERCROUCH && can_power_up && grid_move_up(2)) {
								state = PLAYER_STATES.POWERFLY;
								play_sound(snd_player_takeoff);
							}
							else if (!global.original_controls) { start_hopping(); }
							else { start_fallback_state(); }
						}
						else if (key_down && can_duck) {
							if (state == PLAYER_STATES.CROUCH) { crouch_timer++; }
							else if (state != PLAYER_STATES.POWERCROUCH && state != PLAYER_STATES.STAND_EDGE && should_pose(DIRECTIONS.DOWN, false)) { state = PLAYER_STATES.CROUCH; }

							if (crouch_timer == 32 && state != PLAYER_STATES.POWERCROUCH && can_fly) { state = PLAYER_STATES.POWERCROUCH; play_sound(snd_player_powerup); }
						}
						else { start_fallback_state(); }
					}
				}
				break;
			}
			case PLAYER_STATES.FLY:
			case PLAYER_STATES.POWERFLY: {
				if (should_start_laddering()) { start_laddering(); }
				else {
					// First, fly into ceiilng objects
					if (is_under_ceiling()) { fly_into_ceiling_objects(); }
				
					// If still under ceiling, collide with them
					if (is_under_ceiling()) {
						if (state == PLAYER_STATES.POWERFLY) {
							powerfly_into_ceiling_objects();
							if (instance_exists(id)) { start_falling(true); }
						}
						else { start_fallback_state(); }
					}
					else if (grid_move_up(2)) {
						// Keep Flying
						if (fly_timer >= 16 && state != PLAYER_STATES.POWERFLY) { state = PLAYER_STATES.POWERFLY; }
						if (state == PLAYER_STATES.POWERFLY) { play_sound(snd_player_powerfall); }
					}
					else { start_fallback_state(); }
				}
				break;
			}
			case PLAYER_STATES.FALL:
			case PLAYER_STATES.DAZED_FALL:
			case PLAYER_STATES.TUMBLE:
			case PLAYER_STATES.POWERFALL: {
				if (should_start_laddering()) { start_laddering(); }
				else {
					// First, land on ground objects to clear out any fragile ones
					if (is_on_ground()) { fall_on_ground_objects(); }
				
					if (is_on_ground()) {
						// Bonk against floor
						if (state == PLAYER_STATES.POWERFALL && !is_fully_submerged() && !is_partially_submerged()) {
							// Player reaction to landing
							var _damaged_object_exists = powerfall_on_ground_objects();
							if (!instance_exists(id)) { exit; }
							
							if (_damaged_object_exists) { start_tumble_landing(); }
							else {
								// Start Recoil
								if (!grid_move_up(4)) { start_tumble_landing(); }
								else {
									state = PLAYER_STATES.RECOIL;
									set_transition_timer((global.original_controls) ? 4 : 8);
									do_player_object_collisions();
									if (!instance_exists(id)) { exit; }
								}
							}
						}
						else if (state != PLAYER_STATES.TUMBLE) {
							// Land without extra Delay
							start_standing();
						}
						else {
							// Landing Delay for Tumbling animation
							start_tumble_landing();
						}
					}
					else if (grid_move_down(2)) {
						// Keep Falling
						if (can_power_up) {
							if (fall_timer >= 8 && state == PLAYER_STATES.FALL) { state = PLAYER_STATES.TUMBLE; }
							if (fall_timer >= 12 && state == PLAYER_STATES.TUMBLE) { state = PLAYER_STATES.POWERFALL; }
						}
						if (state == PLAYER_STATES.POWERFALL) {
							play_sound(snd_player_powerfall);
							//stop_sound(fall_sound); fall_sound = undefined;
						}
						
					}
					else { start_fallback_state(); }
				}
				break;
			}
			case PLAYER_STATES.RECOIL: {
				start_fallback_state();
				if (!global.original_controls && is_fall_state()) { fall_timer -= GRID_SIZE; }
				
				break;
			}
			case PLAYER_STATES.LADDER:
			case PLAYER_STATES.LADDER_LOOK:
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {
				// Decide New State Based on Player Input
				var _closest_ladder = get_ladder_at(x, y);
				if (instance_exists(_closest_ladder)) {
					if (key_up || key_down) { is_up = key_up; }
					var _ladder_speed = (global.original_controls) ? 2 : 1;

					if (key_up && can_ladder_up(_closest_ladder) && grid_move_up_direct(_ladder_speed)) {
						state = PLAYER_STATES.LADDER_UP;
						play_sound(snd_player_ladder_step);
					}
					else if (key_down && can_ladder_down(_closest_ladder) && grid_move_down_direct(_ladder_speed)) {
						state = PLAYER_STATES.LADDER_DOWN;
						play_sound(snd_player_ladder_step);
					}
					else if ((key_left || key_right) && (is_on_ground() && !is_inside_solid())) {
						is_left = key_left;
						
						if ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right()) { start_walking(); }
						else if (can_start_climbing() && !is_under_ceiling()) { start_hopping(false); }
						else { state = PLAYER_STATES.LADDER; }
					}
					else { state = PLAYER_STATES.LADDER; }
					
					if (state == PLAYER_STATES.LADDER || state == PLAYER_STATES.LADDER_LOOK) {
						var _look_dir = (key_left) ? DIRECTIONS.LEFT : ((key_right) ? DIRECTIONS.RIGHT : ((is_left) ? DIRECTIONS.LEFT : DIRECTIONS.RIGHT));
						if (should_pose(_look_dir, prev_state == PLAYER_STATES.LADDER_LOOK)) { state = PLAYER_STATES.LADDER_LOOK; if (key_left || key_right) { is_left = key_left; } }
						else { state = PLAYER_STATES.LADDER; }
					}
				}
				else { start_fallback_state(); }
						

				break;
			}
			case PLAYER_STATES.CLIMB: {
				if (is_on_ground()) {
					set_transition_timer(4);
					state = PLAYER_STATES.CROUCH;
				}
				else { start_fallback_state(); }
				break;
			}
			default: {
				show_debug_message("ERROR: Unknown State: " + player_state_to_string(state));
				break;
			}
		}
	
		// Reset Controls

		reset_controls();
	}
	
	// Update On Edge Status
	if (state == PLAYER_STATES.STAND) {
		if ((is_left && !instance_exists(get_left_ground_object())) || (!is_left && !instance_exists(get_right_ground_object()))) {
			state = PLAYER_STATES.STAND_EDGE;
		}
	}
	
	// Define Speed Arrays - iterated backwards!
	//static tumble_speeds = [2, 2, 3, 3];
	static hop_up_speeds = [0, 0, 0, 0, -1, -1, -2, -4];
	static hop_down_speeds = [4, 2, 1, 1, 0, 0, 0, 0];
	static recoil_speeds = [2, 0, -2, -2, -2, -4, -4, -4];
	static recoil_speeds_slow = [0, 0, -4, -4];
	static climb_y_speeds = [0, 0, 0, 0, 0, 0, 0, 0,
					  0, 0, 0, -2, 0, -2, 0, 0,
					  0, 0, 0, 0, -1, -1, -1, -1];
	static climb_x_speeds = [0, 0, 0, 0, 0, 0, 0, 0,
					  1, 1, 1, 1, 0, 0, 0, 2,
					  0, 2, 0, 0, 0, 0, 0, 0];

	// Update transition speeds
	y_transition_speed = undefined;
	x_transition_speed = undefined;
	
	var _speed_index = max(0, (transition_timer-1));
	if (is_hop_up_state()) { y_transition_speed = hop_up_speeds[_speed_index]; }
	else if (is_hop_down_state()) { y_transition_speed = hop_down_speeds[_speed_index]; }
	else if (state == PLAYER_STATES.RECOIL) {
		y_transition_speed = (global.original_controls) ? recoil_speeds_slow[_speed_index] : recoil_speeds[_speed_index];
	}
	//else if (state == PLAYER_STATES.TUMBLE) { y_transition_speed = tumble_speeds[_speed_index]; }
	else if (state == PLAYER_STATES.CLIMB) {
		y_transition_speed = climb_y_speeds[_speed_index];
		x_transition_speed = climb_x_speeds[_speed_index] * get_left_value();
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
		if (global.original_controls && state == PLAYER_STATES.RECOIL) { cape_timer--; }
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
				else if (is_ladder_state()) { start_cape_ladder(); }
				else if (is_fall_state()) { start_cape_fall_begin(); }
				else if (is_hop_up_state()) { start_cape_crouch(); }
				else if (cape_state == CAPE_STATES.STOP_FLUTTER || is_stand_state()) { start_cape_stand(); }
				else { start_cape_crouch(); }
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
		if (state == PLAYER_STATES.WIN) { start_cape_win(); }
		else if (state == PLAYER_STATES.RECOIL) { start_cape_recoil(); }
		else if ((cape_state == CAPE_STATES.FALL_START || cape_state == CAPE_STATES.FALL) && is_grounded_state()) { start_cape_flutter_end(); }
		else if (is_hop_up_state()) { start_cape_flutter_end(); }
		else if (is_hop_down_state()) { start_cape_flutter(); }
		else if (state == PLAYER_STATES.TURN) { start_cape_turn(); }
		else if (is_fly_state()) {
			if (cape_state != CAPE_STATES.FLY) { start_cape_fly(); }
		}
		else if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.DAZED_FALL) { start_cape_fall_begin(); }
		else if (state == PLAYER_STATES.WIN) { start_cape_win(); }
		else if (state == PLAYER_STATES.LAND) { start_cape_land(); }
		else if (is_ladder_state()) {
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
			if (transition_timer <= (global.original_controls ? 2 : 4)) { cape_depth = depth + 1; }
			else if (image_index < 2) { cape_depth = depth - 1; }
			else { cape_depth = depth + 1; }
			break;
		}
		case PLAYER_STATES.LADDER:
		case PLAYER_STATES.LADDER_LOOK:
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
		
		/*
		if (is_ladder_state()) { depth = LADDER_DEPTH - 1; }
		else { depth = PLAYER_DEPTH; }
		*/
		
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
			case PLAYER_STATES.STAND_EDGE: {
				sprite_index = spr_player_on_edge;
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
			case PLAYER_STATES.LADDER_LOOK: {
				sprite_index = spr_player_ladder_look;
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
		if (!global.original_controls && state == PLAYER_STATES.RECOIL && transition_timer <= 4) { sprite_index = spr_player_fall; }
		
		// Update Current Animations
		animation_timer++;
		animation_timer = animation_timer % 96;
		animation_speed = 1;
		
		// Set Speed for Different Animations
		switch (state) {
			case PLAYER_STATES.STAND:
			case PLAYER_STATES.CRUSHED_STAND: { animation_speed = 32; break; }
			case PLAYER_STATES.PUSH_STAND:
			case PLAYER_STATES.PUSH_FORWARD: 
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: 
			case PLAYER_STATES.SWIM:
			case PLAYER_STATES.STAND_EDGE:
			case PLAYER_STATES.SWIM_FORWARD:{ animation_speed = 8; break; }
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
		if (global.original_controls && is_ladder_state()) { animation_speed /= 2; }
		
		// Update Images in Animations
		if (animation_speed > 0) {
			// Update Animation Based on Selected Speed
			if (animation_timer % animation_speed == 0) { image_index++; if (state == PLAYER_STATES.STAND) { idle_timer++; image_index--; } }
			image_index = image_index % image_number;
			// Update Step Index
			if (state == PLAYER_STATES.LADDER_DOWN || state == PLAYER_STATES.LADDER_UP || state == PLAYER_STATES.WALK_FORWARD || state == PLAYER_STATES.PUSH_FORWARD) {
				if (image_index % 2 == 1) { step_index = image_index + 2; }
			}
		}
		
		// Update Images for Idle Animations
		if (sprite_index == spr_player_idle && state == PLAYER_STATES.STAND) {
			if (idle_timer >= 12 && idle_loops == 0) { idle_timer = 0; idle_loops++; }
			else if (idle_timer >= 13 && idle_loops == 1) { idle_timer = 0; idle_loops++; }
			else if (idle_timer >= 14 && idle_loops == 2) { idle_timer = 0; idle_loops++; }
			else if (idle_timer >= 16 && idle_loops == 3) { idle_timer = 0; idle_loops++; }
			else if (idle_timer >= 18 && idle_loops == 4) { idle_timer = 0; idle_loops++; }
			else if (idle_timer >= 24 && idle_loops == 5) { idle_timer = 0; idle_loops = 0; }
		
			if (idle_timer >= 0 && idle_timer < 12) { image_index = 0; }
			else if (idle_timer >= 12 && idle_timer < 14) { image_index = 1; }
			else if (idle_timer >= 14 && idle_timer < 16) { image_index = 2; }
			else if (idle_timer >= 16 && idle_timer < 18) { image_index = 3; }
			else if (idle_timer >= 18 && idle_timer < 19) {
				if (image_index != 4) {
					play_sound(snd_player_idle_yell);
					image_index = 4;
				}
				else if (!audio_is_playing(snd_player_idle_yell)) { image_index = 3; idle_timer++; }
			}
			else if (idle_timer >= 19 && idle_timer < 21) { image_index = 3; }
			else if (idle_timer >= 21 && idle_timer < 23) { image_index = 2; }
			else if (idle_timer >= 23) { image_index = 1; }
		}

		// Update Palette
		main_palette = original_palette;
		if ((state == PLAYER_STATES.POWERFLY || state == PLAYER_STATES.POWERFALL || state == PLAYER_STATES.POWERCROUCH)) {
			main_palette = (animation_timer % 3 == 0) ? original_palette : powered_palette; 
		}
	}
}

draw_cape_graphics = function(_x_offset = 0, _y_offset = 0, _image_alpha = undefined) {
	_image_alpha ??= image_alpha;
	var _cape_x = virtual_x, _cape_y = virtual_y, _cape_image_x_scale = get_left_value(), _cape_x_offset = get_x_draw_offset();
	
	// Determine Cape X
	if (state != PLAYER_STATES.LADDER &&
		state != PLAYER_STATES.LADDER_LOOK &&
		state !=  PLAYER_STATES.LADDER_UP &&
		state != PLAYER_STATES.LADDER_DOWN &&
		state != PLAYER_STATES.FALL &&
		state != PLAYER_STATES.DAZED_FALL &&
		state != PLAYER_STATES.RECOIL &&
		state != PLAYER_STATES.TUMBLE &&
		state != PLAYER_STATES.POWERFALL &&
		state != PLAYER_STATES.WIN &&
		state != PLAYER_STATES.FLY &&
		state != PLAYER_STATES.POWERFLY &&
		state != PLAYER_STATES.CRUSHED_STAND &&
		state != PLAYER_STATES.CRUSHED_FORWARD) {
		if (state != PLAYER_STATES.LAND || image_index > 0) {
			_cape_x += get_left_value() * -GRID_SIZE * ((state == PLAYER_STATES.TURN) ? -1 : 1);
		}
	}
	
	// Determine Cape Y
	if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.DAZED_FALL) { _cape_y -= 4; }
	else if (state == PLAYER_STATES.POWERFALL) { _cape_y -= 2; }
	else if (state == PLAYER_STATES.LAND && image_index == 0) { _cape_y += 2; }
	else if (is_ladder_state()) { _cape_y += 1; _cape_image_x_scale = 1; _cape_x_offset = 0; }
	
	// Draw Cape
	set_shader_palette(PALETTES.GRAY_LIGHT);
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x + _cape_x_offset + _x_offset, _cape_y + virtual_y_offset + _y_offset, _cape_image_x_scale, 1, 0, image_blend, _image_alpha);
}

do_player_object_collisions = function(_skip_portals = false) {
	// Destroy if Inside Lethal object
	var _inside_objects = get_inside_objects(obj_game_object);
	for (var _i = 0; _i < array_length(_inside_objects); _i++) {
		var _inst = _inside_objects[_i]
		if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
	}
	if (!instance_exists(id)) { exit; }
	
	// Destroy if Inside Solid
	if (is_inside_solid() && !is_ladder_state()) { get_destroyed_by_object(); }
	if (!instance_exists(id)) { exit; }
	
	
	// Only Collide With the Following After Player has "Settled"
	var _is_settled = !(transition_timer != 0 && (state != PLAYER_STATES.CLIMB || transition_timer != 20));
	
	// Collect Keys
	var _objects_at_position = instances_at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	if (_is_settled) {
		if (controlled_by_human) {
			for (var _i = 0; _i < array_length(_objects_at_position); _i++) {
				var _inst = _objects_at_position[_i];
				if (!instance_exists(_inst) || !_inst.is_a(obj_key)) { continue; }
			
				with (_inst) { instance_destroy(); }
			}
		}
	
		// Go Through Portals
		if (!_skip_portals && do_portal_collisions(_objects_at_position)) {
			do_player_object_collisions(false);
	        if (instance_exists(id) && state != PLAYER_STATES.WIN) { set_transition_timer(1); }
	        exit;
		}
	
		// Go Through Open Doors
		if (controlled_by_human) {
			if (state != PLAYER_STATES.WIN && transition_timer == 0 && (is_grounded_state() || is_fall_state())) {
				for (var _i = 0; _i < array_length(_objects_at_position); _i++) {
					var _inst = _objects_at_position[_i];
					if (!instance_exists(_inst) || !_inst.is_a(obj_door)) { continue; }
				
					with (_inst) {
						if (image_index > 0 && is_fully_on_ground()) {
							audio_stop_all();
							other.start_winning();
							play_global_sound(snd_level_clear);
							exit;
						}
					}
				}
			}
		}
	
		// Get Destroyed From Adjacent Lethal Objects
		if (is_grounded_state()) {
			// Destroy if Standing on Lethal Object and No Other Solids
		
			var _ground_objects = get_ground_objects(), _safe = false, _damaged = false;
			for (var _i = 0; _i < array_length(_ground_objects); _i++) {
				var _inst = _ground_objects[_i];
				if (instance_exists(_inst)) {
					if (!would_be_damaged_by(_inst)) { _safe = true; }
				}
			}
			if (!_safe) {
				for (var _i = 0; _i < array_length(_ground_objects); _i++) {
				var _inst = _ground_objects[_i];
					if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
				}
			}
		
			// Destroy if Carrying Lethal Object
			var _carried_objects = get_carried_objects();
			for (var _i = 0; _i < array_length(_carried_objects); _i++) {
				var _inst = _carried_objects[_i]
				if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
			}
		}
	
		if (!instance_exists(id)) { exit; }
	}

	// Handle Water
	/* TODO: What order in the collisions should the water happen?
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
	*/
}

do_portal_collisions = function(_objects_at_position) {
	for (var _i = 0; _i < array_length(_objects_at_position); _i++) {
		var _inst = _objects_at_position[_i];
			if (!instance_exists(_inst) || !_inst.is_a(obj_portal)) { continue; }
			
		if (_inst.activated) {
			_inst.deactivate_portal(get_darker_palette(particle_palette));
			if (instance_exists(_inst.linked_portal)) {
				_inst.linked_portal.deactivate_portal(get_darker_palette(particle_palette));
				grid_move_to(_inst.linked_portal.x, _inst.linked_portal.y);
				virtual_x = x;
				virtual_y = y;
				portal_lockout_timer = 8;
				var _prev_x = x, _prev_y = y;
				start_fallback_state();
				grid_move_to(_prev_x, _prev_y, false);
				reset_transition_timer(); // This reset is needed to make the recursion work; they get overwritten immediately later in the collision call chain
				return true;
			}
		}
	}
	
	return false;
}

// Silhoutte Functions
#macro SILHOUETTE_SURFACE_SIZE 32
#macro SILHOUETTE_PAD 8
#macro SILHOUETTE_ALPHA 0.33
build_solid_mask_surface = function(_origin_x, _origin_y) {
	if (!surface_exists(solid_mask_surface)) { solid_mask_surface = surface_create(SILHOUETTE_SURFACE_SIZE, SILHOUETTE_SURFACE_SIZE); }
	if (!surface_set_target(solid_mask_surface)) { show_debug_message("ERROR SETTING SOLID MASK WINDOW"); return false; }
	draw_clear_alpha(c_black, 0);

	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	with (obj_static_area_manager) {
		if (depth > other.depth && is_occluder && surface_exists(static_area_surface)) {
			draw_surface_part_ext(static_area_surface, _origin_x, _origin_y, SILHOUETTE_SURFACE_SIZE, SILHOUETTE_SURFACE_SIZE, 0, 0, 1, 1, c_white, 1);
		}
	}
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	return true;
}

draw_with_static_area_clipping = function() {
	var _origin_x = clamp(floor(virtual_x) - SILHOUETTE_PAD, 0, room_width - SILHOUETTE_SURFACE_SIZE);
	var _origin_y = clamp(floor(virtual_y + virtual_y_offset) - SILHOUETTE_PAD, 0, room_height - SILHOUETTE_SURFACE_SIZE);

	if (!build_solid_mask_surface(_origin_x, _origin_y)) { return false; }

	// Unoccluded pixels always draw normally
	if (!build_silhouette_composite(_origin_x, _origin_y, bm_inv_src_alpha)) { return false; }
	draw_silhouette_composite(_origin_x, _origin_y, c_white, image_alpha);

	// Draw occluded pixels as silhouttes while only on ladder
	if (is_ladder_state()) {
		if (!build_silhouette_composite(_origin_x, _origin_y, bm_src_alpha)) { return false; }
		draw_silhouette_composite(_origin_x, _origin_y, c_black, SILHOUETTE_ALPHA * image_alpha);
	}

	return true;
}

build_silhouette_composite = function(_origin_x, _origin_y, _mask_factor) {
	if (!surface_exists(silhouette_surface)) { silhouette_surface = surface_create(SILHOUETTE_SURFACE_SIZE, SILHOUETTE_SURFACE_SIZE); }
	if (!surface_set_target(silhouette_surface)) { show_debug_message("ERROR SETTING SILHOUETTE SURFACE"); return false; }
	draw_clear_alpha(c_black, 0);

	// Both sprites at alpha 1: overlapping pixels resolve into one shape instead of
	// two stacked alphas. Opacity is applied once, at blit time.
	if (visible && has_cape && cape_depth >= depth) { draw_cape_graphics(-_origin_x, -_origin_y, 1); }
	draw_dynamic_object(-_origin_x, -_origin_y, 1);
	if (visible && has_cape && cape_depth < depth) { draw_cape_graphics(-_origin_x, -_origin_y, 1); }

	// Only the mask's alpha channel is read
	gpu_set_blendmode_ext(bm_zero, _mask_factor);
	draw_surface_ext(solid_mask_surface, 0, 0, 1, 1, 0, c_white, 1);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	return true;
}

draw_silhouette_composite = function(_origin_x, _origin_y, _colour, _alpha) {
	// Must bypass the palettizer: the composite already holds final palette colours,
	shader_reset();
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface_ext(silhouette_surface, _origin_x, _origin_y, 1, 1, 0, _colour, _alpha);
	gpu_set_blendmode(bm_normal);
	shader_set(shd_palettizer);
	shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);
}