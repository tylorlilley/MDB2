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
	SURFACE,
	SWIM,
	SWIM_FORWARD,
	LAND,
	// Non-Grounded States
	FLY, // Currently Unused
	HOP_UP,
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
	key_restart = false;
}

function determine_gamepad() {
	var gp_num = gamepad_get_device_count();
	global.gamepad = noone;
	for (var i = 0; i < gp_num; i++;) {
	    if (gamepad_is_connected(i)) { global.gamepad = i; break; }
	}
	return global.gamepad;
}
	
update_controls = function(_inverted) {
	// Accumulate Inputs
	var _new_left_value = ((_inverted) ? key_right : key_left) || keyboard_check(vk_left) || gamepad_button_check(global.gamepad, gp_padl) || gamepad_axis_value(global.gamepad, gp_axislh) < -0.5;
	var _new_right_value = ((_inverted) ? key_left : key_right) || keyboard_check(vk_right) || gamepad_button_check(global.gamepad, gp_padr) || gamepad_axis_value(global.gamepad, gp_axislh) > 0.5;
	var _new_up_value = key_up || keyboard_check(vk_up) || gamepad_button_check(global.gamepad, gp_padu) || gamepad_axis_value(global.gamepad, gp_axislv) < -0.5;
	var _new_down_value = key_down || keyboard_check(vk_down) || gamepad_button_check(global.gamepad, gp_padd) || gamepad_axis_value(global.gamepad, gp_axislv) > 0.5;
	var _new_jump_value = key_jump || ((global.original_controls) ? false : (keyboard_check(ord("Z")) || gamepad_button_check(global.gamepad, gp_face1) || gamepad_button_check(global.gamepad, gp_face2) || gamepad_button_check(global.gamepad, gp_face3) || gamepad_button_check(global.gamepad, gp_face4)));
	var _new_restart_value = key_restart || keyboard_check(ord("R")) || gamepad_button_check(global.gamepad, gp_start) || gamepad_button_check(global.gamepad, gp_select);
	
	// Cancel out released inputs
	if (keyboard_check_released(vk_left) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padl)))) { _new_left_value = false; }
	if (keyboard_check_released(vk_right) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padr)))) { _new_right_value = false; }
	if (keyboard_check_released(vk_up) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padu)))) { _new_up_value = false; }
	if (keyboard_check_released(vk_down) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padd)))) { _new_down_value = false; }
	if (keyboard_check_released(ord("Z")) || gamepad_button_check_released(global.gamepad, gp_face1) || gamepad_button_check_released(global.gamepad, gp_face2) || gamepad_button_check_released(global.gamepad, gp_face3) || gamepad_button_check_released(global.gamepad, gp_face4)) { _new_jump_value = false; }
	if (keyboard_check_released(ord("R")) || gamepad_button_check_released(global.gamepad, gp_start) || gamepad_button_check_released(global.gamepad, gp_select)) { _new_restart_value = false; }

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
	key_jump = (global.original_controls) ? false : (_new_jump_value || ((global.combine_up_and_jump_controls) ? _new_up_value : false));
	key_restart = _new_restart_value;
}
	
// State Updating Functions
start_pushing = function(_pushed_obj) {
	// Push Box
	if (!_pushed_obj.start_being_pushed(is_left)) { return false; }
	// Push Self
	return grid_move_horizontal(get_left_value());
}
	
start_winning = function() {
	start_cape_win();
	state = PLAYER_STATES.WIN;
	transition_timer = 52;
	image_index = 0;
}
	
start_climbing = function() {	
	state = PLAYER_STATES.CLIMB;
	transition_timer = 24;
	climbed_inst = get_climbed_object();
	return true;
}

start_fallback_state = function(_is_crushed = false) {
	if (should_start_laddering()) { start_laddering(); }
	else if (is_on_ground()) { start_standing(_is_crushed); }
	else { start_falling(); }
}
	
start_standing = function(_is_crushed = false) {
	state = PLAYER_STATES.STAND;
	if (_is_crushed) { state = PLAYER_STATES.CRUSHED_STAND; }
	else if (key_down && !global.original_controls) { state = PLAYER_STATES.CROUCH; }
	else if (key_up && !global.original_controls) { state = PLAYER_STATES.LOOK_UP; }
	transition_timer = (_is_crushed) ? 4 : 0;
	air_walk = false;
	if (key_left || key_right) { is_left = key_left; }
}

start_falling = function(_is_dazed = false) {
	transition_timer = 0;
	y_transition_timer = 0;
	x_transition_timer = 0;
	grid_move_down(2); // If this fails, we still proceed with setting the fall state as the ultimate state fallback
	state =  (_is_dazed) ? PLAYER_STATES.DAZED_FALL : PLAYER_STATES.FALL;
	fall_timer = 0;
	audio_stop_sound(fall_sound);
	fall_sound = audio_play_sound_panned(snd_player_fall, x);
}

start_laddering = function() {
	state = PLAYER_STATES.LADDER;
	transition_timer = 4;
	play_sound(snd_player_ladder_step);
}

should_start_laddering = function() {
	var _auto_grab = global.original_controls && ((is_grounded_state() && !is_on_ground()) || is_fall_state());
	var _should_ladder = ((key_up || key_down || _auto_grab) && can_start_laddering());
	
	return _should_ladder;
}


start_turning = function() {
	if (state == PLAYER_STATES.TURN) { prev_state = PLAYER_STATES.STAND; }
	state = PLAYER_STATES.TURN;
	transition_timer = 4;
	walk_on_ground_objects();
}

start_walking = function(_is_crushed = false) {
	// First, walk on next object
	var _prev_x = x, _prev_y = y;
	grid_move_to((is_left) ? x - GRID_SIZE : x + GRID_SIZE, y);
	walk_on_ground_objects();
	if (!instance_exists(id)) { exit; }
	grid_move_to(_prev_x, _prev_y);
		
	// Continue with Walking or Fall
	var _speed = (_is_crushed) ? 0.5 : 2;
	if (grid_move_horizontal(_speed * get_left_value())) {
		transition_timer = (_is_crushed) ? 4 : 0;
		state = (_is_crushed) ? PLAYER_STATES.CRUSHED_FORWARD : PLAYER_STATES.WALK_FORWARD;
	}
}
	
start_hopping = function(_should_move_horizontally = false) {
	virtual_y_offset = get_switch_offset(); // This gets reset elsewhere if we remain grounded before being used in the Draw
	
	if (_should_move_horizontally && grid_move_horizontal(get_left_value())) { state = PLAYER_STATES.HOP_UP_FORWARD; }
	else { state = PLAYER_STATES.HOP_UP; }
	
	play_sound(snd_player_jump);
	if (grid_move_up(1)) { transition_timer = 8; }
	else { start_fallback_state(); }
}

// Interactions with Other Object Functions
get_left_and_right_objects = function(_get_above = false, _impact_fragile = false) {
	var _objects = (_get_above) ? get_ceiling_objects() : get_ground_objects(), _left_object = noone, _right_object = noone, _returned_objects = [];
	var _y_offset = (_get_above) ? -GRID_SIZE : sprite_get_height(sprite_index);
			
	for (var _i = 0; _i < array_length(_objects); _i++) {
		var _inst = _objects[_i];
		if (!instance_exists(_inst)) { continue; }
		
		if (is_instance_at_grid_position(x, y + _y_offset, _inst)) {
			if (_impact_fragile && _inst.is_fragile) { _inst.get_damaged(); }
			else if (!instance_exists(_left_object) || _left_object.depth > _inst.depth) { _left_object = _inst; }
		}
		else if (is_instance_at_grid_position(x + GRID_SIZE, y + _y_offset, _inst)) {
			if (_impact_fragile && _inst.is_fragile) { _inst.get_damaged(); }
			else if (!instance_exists(_right_object) || _right_object.depth > _inst.depth) { _right_object = _inst; }
		}
	}

	if (_left_object == _right_object) { _right_object = noone; }
	if (instance_exists(_left_object)) { array_push(_returned_objects, _left_object); }
	if (instance_exists(_right_object)) { array_push(_returned_objects, _right_object); }
	return _returned_objects;
}

get_damaged_by_object = function(_inst) {
	if ((object_index == obj_player && _inst.is_player_lethal) || (object_index != obj_player && _inst.is_robot_lethal)) {
		instance_destroy();
		_inst.deal_damage();
	}
}

damage_objects = function(_damage_above = false) {
	var _objects_to_damage = get_left_and_right_objects(_damage_above);
	
	// Also Damage Static Area Objects One Layer Deeper
	for (var _i = 0; _i < array_length(_objects_to_damage); _i++) {
		var _inst = _objects_to_damage[_i];
		if (_inst.is_a(obj_static_area)) {
			var _prev_y = y;
			grid_move_to(x, y + (_damage_above ? -GRID_SIZE : GRID_SIZE));
			var _deeper_objects_to_damage = get_left_and_right_objects(_damage_above);
			for (var _d = 0; _d < array_length(_deeper_objects_to_damage); _d++) {
				var _deeper_inst = _deeper_objects_to_damage[_d];
				if (!instance_exists(_deeper_inst)) { continue; }
		
				if (_deeper_inst.is_a(obj_static_area) && _deeper_inst.object_index == _inst.object_index && _deeper_inst.x == _inst.x && !array_contains(_objects_to_damage, _deeper_inst)) { array_push(_objects_to_damage, _deeper_inst); }
			}
			grid_move_to(x, _prev_y);
		}
	}
	
	// Damage Objects
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
		if (_damage_above) { _inst.powerfly_into(id); }
		else { _inst.powerfall_on(id); }
		play_sound(snd_impact);
		
		// Interact with Reamining Objects
		if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
		if (!instance_exists(id)) { break; }
	}
}

powerfall_on_ground_objects = function() { damage_objects(false); }
powerfly_into_ceiling_objects = function() { damage_objects(true); }

fall_on_ground_objects = function() {
	var _ground_objects = get_left_and_right_objects(false, true);
		
	for (var _i = 0; _i < array_length(_ground_objects); _i++) {
		var _inst = _ground_objects[_i];
		if (instance_exists(_inst)) {
			_inst.fall_on(fall_timer);
			//get_damaged_by_object(_inst);
		}
	}
}

fly_into_ceiling_objects = function() {
	var _ceiling_objects = get_left_and_right_objects(true, true);
		
	for (var _i = 0; _i < array_length(_ceiling_objects); _i++) {
		var _inst = _ceiling_objects[_i];
		if (instance_exists(_inst)) {
			_inst.fly_into(fly_timer);
			//get_damaged_by_object(_inst);
		}
	}
}

walk_on_ground_objects = function() {
	// if (!is_on_ground() && !air_walk) { exit; }
	
	var _ground_objects = get_left_and_right_objects();
		
	for (var _i = 0; _i < array_length(_ground_objects); _i++) {
		var _inst = _ground_objects[_i];
		if (instance_exists(_inst)) {
			_inst.walk_on();
			get_damaged_by_object(_inst);
			if (!instance_exists(id)) { break; }
		}
	}
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

get_climbed_object = function() {
	if (is_under_ceiling() || (!key_jump && !key_up && !global.original_controls) || (global.original_controls && y <= 24)) { return noone; }
	var _diagonal_ceiling_objects = (is_left) ? get_left_ceiling_objects() : get_right_ceiling_objects();
	if (array_length(_diagonal_ceiling_objects) > 0) { return noone; }
	
	var _climbable_objects = (is_left) ? get_left_climbable_objects([id]) : get_right_climbable_objects([id]);
	var _climbed_obj = grid_array_first(_climbable_objects);

	return (instance_exists(_climbed_obj) && y < _climbed_obj.y) ? _climbed_obj : noone;
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
	return (!is_crushed_state() && at_each_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder));
}

// Main Functions
update_player_state = function() {
	prev_state = state;

	// Check Controls
	update_controls(object_index == obj_mirror_player);
	
	// Restart Room
	if (key_restart) { instance_destroy(); exit; }

	// Reset Timers
	if (!is_ladder_state()) { is_up = false; }
	if (!is_fall_state() && fall_sound != noone) { audio_stop_sound(fall_sound); fall_sound = noone; }
	if (state != PLAYER_STATES.STAND) { idle_timer = 0; idle_cycle = 0; }
	if (state != PLAYER_STATES.CROUCH && state != PLAYER_STATES.POWERCROUCH) { crouch_timer = 0; }
	if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.TUMBLE && state != PLAYER_STATES.POWERFALL) { fall_timer = 0; }
	if (state != PLAYER_STATES.FLY && state != PLAYER_STATES.POWERFLY) { fly_timer = 0; }
	if (state != PLAYER_STATES.SWIM && state != PLAYER_STATES.SWIM_FORWARD) { swim_timer = 0; }
	
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
					if (!grid_move_up(4)) { play_sound(snd_soft_thud); transition_timer = 2; }
				}
				
				break;
			}
			case PLAYER_STATES.CLIMB: {
				if (transition_timer == 20) {
					if (!grid_move_up(1)) { start_fallback_state(); }
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
				if (global.original_controls && transition_timer <= 2) {
					transition_timer = 0;
					y_transition_timer = 0;
				}
				
				break;
			}
			case PLAYER_STATES.WIN: {
				if ((key_up || key_jump) && prev_state == PLAYER_STATES.WIN) { transition_timer = 0; }
				else if (visible) {
					if (transition_timer == 51) { image_index = 0; cape_image_index = 0; }
					else if (transition_timer == 36) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); }
					else if (transition_timer == 28) { image_index = 0; cape_image_index = 0; }
					else if (transition_timer == 24) { image_index = 1; cape_image_index = 1; play_sound(snd_player_jump); }
					else if (transition_timer == 20) { image_index = 0; cape_image_index = 0; }
					else if (transition_timer == 14) {
						image_index = 3;
						cape_image_index = 0;
						play_sound(snd_key);
						var _prev_x = x;
						grid_move_to(x + (get_left_value() * GRID_SIZE), y);
						//create_particles(4 + irandom(6), PARTICLE_TYPES.SPARKLE, PALETTES.GRAY_LIGHT);
						grid_move_to(_prev_x, y);
					}
					else if (transition_timer < 14) { image_index = 2; } // + (transition_timer % 2); }
					else if (transition_timer == 1) { image_index = 0; start_cape_win(); }
				}
				break;
			}
		}
	}
	
	// Get Destroyed From Solids
	update_player_collisions_at_position();
	if (!instance_exists(id)) { exit; }
	
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
						transition_timer = 8;
						state = PLAYER_STATES.SWIM_FORWARD;
					}
					else { state = PLAYER_STATES.SWIM; }
				}
				break;
			}
			case PLAYER_STATES.WIN: {
				if (visible && (key_up || key_jump) && prev_state == PLAYER_STATES.WIN) {
					visible = false;
					play_sound(snd_impact);
					with (obj_door) { image_index = 2; } // create_particles(8 + irandom(8)); }
					// TODO: Do this in controller instead of player?
					global.controller.transition_timer = 1;
					global.controller.x = x;
					global.controller.y = y;
				}
				else { start_winning(); }
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
				grid_move_to((is_left) ? x - GRID_SIZE : x + GRID_SIZE, y);
				_on_hop_height_ground = is_on_ground();
				grid_move_to(_prev_x, _prev_y);

				// Determine New State
				if (should_start_laddering()) { start_laddering() }
				else if (is_on_ground()) { start_standing(); }
				else if (_on_hop_height_ground && _can_walk && _horizontal_input) { air_walk = true; start_walking(); }
				else if (state == PLAYER_STATES.HOP_UP && (_horizontal_input || global.original_controls) && instance_exists(get_climbed_object())) { start_climbing(); }
				else {
					// Continue with Hop Down
					if (_can_walk && state == PLAYER_STATES.HOP_UP_FORWARD && grid_move_horizontal(get_left_value())) {
						state = PLAYER_STATES.HOP_DOWN_FORWARD
					}
					else { state = PLAYER_STATES.HOP_DOWN; }
					
					if (grid_move_down(1)) { transition_timer = 8; }
					else { start_fallback_state(); }
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
						transition_timer = 4;
						fall_on_ground_objects();
					}
					else if (state == PLAYER_STATES.WALK_FORWARD && air_walk) {
						start_standing();
						transition_timer = 4;
					}
						
					// Switch to New State Based on Player Input
					if (transition_timer == 0) {
						if (should_start_laddering()) { start_laddering(); }
						else if (key_left || key_right) {
							// Determine if Can Climb
							var _prev_y = y;
							grid_move_to(x, y - GRID_SIZE);
							var _can_climb = instance_exists(get_climbed_object());
							grid_move_to(x, _prev_y);
							
							// Determine if Can Hop
							var _diagonal_ceiling_objects = (is_left) ? get_left_ceiling_objects() : get_right_ceiling_objects(), _under_diagonal_ceiling = (array_length(_diagonal_ceiling_objects) > 0);
							var _can_walk = (is_on_ground() || air_walk)  && ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right());
							var _can_hop_up = !is_under_ceiling() && (key_jump || (_can_climb && global.original_controls));
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
							else if (state == PLAYER_STATES.POWERCROUCH && can_power_up && grid_move_up(2)) {
								state = PLAYER_STATES.POWERFLY;
								play_sound(snd_player_takeoff);
							}
							else if (!global.original_controls) { start_hopping(); }
							else { start_fallback_state(); }
						}
						else if (key_down && !global.original_controls) {
							if (state == PLAYER_STATES.CROUCH) { crouch_timer++; }
							else if (state != PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.CROUCH; transition_timer = 4; }

							if (crouch_timer == 32 && state != PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.POWERCROUCH; play_sound(snd_player_powerup); }
						}
						else { start_fallback_state(); }
					
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
							powerfall_on_ground_objects();
							if (!instance_exists(id)) { exit; }
							
							state = PLAYER_STATES.RECOIL;
							transition_timer = 8;
							if (!grid_move_up(4)) { play_sound(snd_soft_thud); transition_timer = 2; }
						}
						else if (state != PLAYER_STATES.TUMBLE) {
							// Land without extra Delay
							start_standing();
							transition_timer = 0;
						}
						else {
							// Landing Delay for Tumbling animation
							if (key_left || key_right) { is_left = key_left; }
							state = PLAYER_STATES.LAND;
							transition_timer = 8;
							play_sound(snd_soft_thud);
						}
					}
					else if (grid_move_down(2)) {
						// Keep Falling
						if (can_power_up) {
							if (fall_timer >= 8 && state == PLAYER_STATES.FALL) { state = PLAYER_STATES.TUMBLE; }
							if (fall_timer >= 12 && state == PLAYER_STATES.TUMBLE) { state = PLAYER_STATES.POWERFALL; }
						}
						if (state = PLAYER_STATES.POWERFALL) {
							play_sound(snd_player_powerfall);
							if (fall_sound != noone) { audio_stop_sound(fall_sound); fall_sound = noone; }
						}
						
					}
					else { start_fallback_state(); }
				}
				break;
			}
			case PLAYER_STATES.RECOIL: {
				// Decide New State
				start_fallback_state();
				if (is_fall_state()) { fall_timer = -GRID_SIZE; }
				
				break;
			}
			case PLAYER_STATES.LADDER:
			case PLAYER_STATES.LADDER_UP:
			case PLAYER_STATES.LADDER_DOWN: {
				// Decide New State Based on Player Input
				var _closest_ladder = get_closest_ladder();
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
					//else if (key_down && !can_ladder_down(_closest_ladder)) { start_standing(); }
					else if ((key_left || key_right) && (is_on_ground() && !is_inside_solid())) {
						is_left = key_left;
						if ((is_left) ? !is_blocked_on_left() : !is_blocked_on_right()) { start_walking(); }
						else { state = PLAYER_STATES.LADDER; }
					}
					else { state = PLAYER_STATES.LADDER; }
				}
				else { start_fallback_state(); }
						

				break;
			}
			case PLAYER_STATES.CLIMB: {
				if (is_on_ground()) {
					transition_timer = 4;
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

	// Update transition speeds
	y_transition_speed = undefined;
	x_transition_speed = undefined;
	if (is_hop_up_state()) {
		var _speed = [0, 0, -1, -1, -1, -1, -2, -2];
		y_transition_speed = _speed[transition_timer-1];
	}
	else if (is_hop_down_state()) {
		var _speed = [2, 2, 1, 1, 1, 1, 0, 0];
		y_transition_speed = _speed[transition_timer-1];
	}
	else if (state == PLAYER_STATES.RECOIL) {
		var _speed = [0, 0, -2, -2, -2, -2, -4, -4];
		y_transition_speed = _speed[transition_timer-1];
	}
	else if (state == PLAYER_STATES.CLIMB) {
		y_transition_speed = 0;
		x_transition_speed = 0;
		var _y_speed = [0, 0, 0, 0, 0, 0, 0, 0,
					   0, 0, 0, -2, 0, -2, 0, 0,
					   0, 0, 0, 0, -1, -1, -1, -1];
		var _x_speed = [0, 0, 0, 0, 0, 0, 0, 0,
					   1, 1, 1, 1, 0, 0, 0, 2,
					   0, 2, 0, 0, 0, 0, 0, 0];
		y_transition_speed = _y_speed[transition_timer-1];
		x_transition_speed = _x_speed[transition_timer-1] * get_left_value();
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
				else if (is_ladder_state()) { start_cape_ladder(); }
				else if (is_fall_state()) { start_cape_fall_begin(); }
				else if (is_hop_up_state()) { start_cape_crouch(); }
				else if (cape_state == CAPE_STATES.STOP_FLUTTER || state == PLAYER_STATES.STAND) { start_cape_stand(); }
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
		else if ((cape_state == CAPE_STATES.FALL_START || cape_state == CAPE_STATES.FALL) && is_grounded_state()) { start_cape_flutter_end(); }
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
			if (transition_timer <= 4) { cape_depth = depth + 1; }
			else if (image_index < 2) { cape_depth = depth - 1; }
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
		if (state == PLAYER_STATES.RECOIL && transition_timer <= 4) { sprite_index = spr_player_fall; }
		
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

draw_cape_graphics = function() {
	var _cape_x = virtual_x, _cape_y = virtual_y;
	if (state != PLAYER_STATES.LADDER &&
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
			_cape_x += get_draw_x_scale() * -GRID_SIZE * ((state == PLAYER_STATES.TURN) ? -1 : 1);
		}
	}
	if (state == PLAYER_STATES.FALL || state == PLAYER_STATES.DAZED_FALL) { _cape_y -= 4; }
	else if (state == PLAYER_STATES.POWERFALL) { _cape_y -= 1; }
	else if (is_ladder_state()) { _cape_y += 1; }
	
	set_shader_palette(PALETTES.GRAY_LIGHT);
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x + get_x_draw_offset(), _cape_y+virtual_y_offset, get_draw_x_scale(), 1, 0, image_blend, 1);
}

update_player_collisions_at_position = function() {
	// Get Destroyed From Lethal Objects
	if (is_grounded_state()) {
		// Destroy if Standing on Lethal Object and No Other Solids
		var _ground_objects = get_left_and_right_objects();
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i]
			if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
		}
		
		// Destroy if Carrying Lethal Object
		var _carried_objects = get_carried_objects();
		for (var _i = 0; _i < array_length(_carried_objects); _i++) {
			var _inst = _carried_objects[_i]
			if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
		}
	}
	
	// Destroy if Inside Lethal object
	var _inside_objects = get_inside_objects(obj_dynamic_object);
	for (var _i = 0; _i < array_length(_inside_objects); _i++) {
		var _inst = _inside_objects[_i]
		if (instance_exists(_inst)) { get_damaged_by_object(_inst); }
	}
	
	// Destroy if Inside Solid
	if (is_inside_solid() && !is_ladder_state()) { instance_destroy(); }
		
	if (!instance_exists(id)) { exit; }
	
	// Hanlde Water
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
		
		if (_inst.is_a(obj_door)) {
			if (can_be_controlled && _inst.image_index > 0 && _inst.is_fully_on_ground() && state != PLAYER_STATES.WIN && (is_grounded_state() || is_fall_state())) {
				start_winning();
				stop_music();
				play_sound(snd_level_clear);
			}
		}
		else if (_inst.is_a(obj_key)) {
			if (can_be_controlled) {
				with (_inst) { instance_destroy(); }
			}
		}
		else if (_inst.is_a(obj_portal) && _inst.activated) {
			_inst.deactivate_portal(main_palette);
			if (instance_exists(_inst.linked_portal)) {
				_inst.linked_portal.deactivate_portal(main_palette);
				grid_move_to(_inst.linked_portal.x, _inst.linked_portal.y);
				virtual_x = x;
				virtual_y = y;
				start_fallback_state();
			}
		}
	}
	var _fully_overlapping_switches = instances_at_grid_position_exact(x, y + GRID_SIZE, sprite_get_width(sprite_index), GRID_SIZE);
	for (var _i = 0; _i < array_length(_fully_overlapping_switches); _i++) {
		var _inst = _fully_overlapping_switches[_i];
		
		if (_inst.is_a(obj_switch) && !_inst.pressed) {
			_inst.press_switch();
		}
	}
}
