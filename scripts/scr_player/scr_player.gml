/*
enum PLAYER_STATES
{
	// Grounded States
	STAND,
	WALK,
	PUSH,
	CROUCH,
	POWERCROUCH,
	// Non-Grounded States
	HOP,
	HOP_UP,
	FLY,
	POWERFLY,
	FALL,
	POWERFALL,
	CLIMB,
	LADDER,
	LADDER_UP,
	LADDER_DOWN
}

function player_init() {
	// Game Object Variables
	is_fixed = false;
	is_ground = true;
	is_ceiling = false;
	is_right_wall = false;
	is_left_wall = false;
	
	// Player Specific Variables
	state = PLAYER_STATES.STAND;
	crouch_timer = 0;
	fall_timer = 0;
	fly_timer = 0;
	climb_timer = 0;
	hop_timer = 0;
	
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
}

function update_player_state() {
	var _prev_state = state;
	var _ground_objects = get_ground_objects(), _on_ground = is_grounded();
	var _ceiling_objects = get_ceiling_objects(), _under_ceiling = is_under_ceiling();
	var _wall_objects = noone, _pushing_on_wall = false;
	var _ladder_objects = ds_list_create(), _total_ladder_objects = instance_place_list(x, y, obj_ladder, _ladder_objects, false), _able_to_ladder = false;
	var _key_left = keyboard_check(vk_left), _key_right = keyboard_check(vk_right), _key_up = keyboard_check(vk_up), _key_down = keyboard_check(vk_down), _key_jump = keyboard_check(ord("Z"));
	x_speed = 0;
	y_speed = 0;
	
	// Cancel out opposite inputs
	if (_key_left && _key_right) {
		if (is_left) { _key_right = false; }
		else { _key_left = false; }
	}
	if (_key_up && _key_down) {
		if (is_up) { _key_down = false; }
		else { _key_up = false; }
	}
	var _player_can_input = (state != PLAYER_STATES.CLIMB); //(x % 8 == 0) && (y % 8 == 0);
	
	// Reset various player state timers
	if (!is_ladder_state()) { is_up = false; }
	if (state != PLAYER_STATES.CROUCH && state != PLAYER_STATES.POWERCROUCH) { crouch_timer = 0; }
	if (state != PLAYER_STATES.FALL && state != PLAYER_STATES.POWERFALL) { fall_timer = 0; }
	if (state != PLAYER_STATES.FLY && state != PLAYER_STATES.POWERFLY) { fly_timer = 0; }
	if (state != PLAYER_STATES.HOP && state != PLAYER_STATES.HOP_UP) { hop_timer = 0; }
	if (state != PLAYER_STATES.CLIMB) { climb_timer = 0; }
	else {
		_wall_objects = is_left ? get_left_climbable_objects() : get_right_climbable_objects();
		_pushing_on_wall = (ds_list_size(_wall_objects) > 0);
		ds_list_destroy(_wall_objects);
			
		if (!_pushing_on_wall && !_on_ground) {
			if (climb_timer == 7) { state = PLAYER_STATES.WALK; }
			else { state = PLAYER_STATES.FALL; }
		}
	}
	
	// Check for ladders
	var _most_overlapping_ladder = noone, _most_ladder_overlap = 0;
	for (var i = 0; i < _total_ladder_objects; i++) {
		var _ladder = _ladder_objects[| i];
		if (!place_meeting(_ladder.x, _ladder.y-_ladder.sprite_height, obj_ladder) && _ladder.y > y) { continue; }
		var _ladder_overlap = instance_overlap_area(_ladder);
		if (_ladder_overlap > _most_ladder_overlap) {
			_most_overlapping_ladder = _ladder;
			_most_ladder_overlap = _ladder_overlap;
		}
	}
	_able_to_ladder = instance_exists(_most_overlapping_ladder) && abs(_most_overlapping_ladder.x - x) < sprite_width/4;
	
	
	// Switch State Based on Inputs
	switch (state) {
		case PLAYER_STATES.STAND:
		case PLAYER_STATES.WALK:
		case PLAYER_STATES.PUSH:
		case PLAYER_STATES.CROUCH:
		case PLAYER_STATES.POWERCROUCH: {
			if (!_on_ground && climb_timer != 7) { state = PLAYER_STATES.FALL; }
			else if (_player_can_input) {
				// Change State due to Player Input
				if (_key_jump && !_under_ceiling) {
					state = PLAYER_STATES.HOP_UP;
					is_left = _key_left;
					if (_key_left || _key_right) { state = PLAYER_STATES.HOP; }
				}
				else if (_key_left || _key_right) {
					is_left = _key_left;
					state = PLAYER_STATES.WALK;
						
					// Try to Climb
					_wall_objects = is_left ? get_left_climbable_objects() : get_right_climbable_objects();
					_pushing_on_wall = (ds_list_size(_wall_objects) > 0);
					ds_list_destroy(_wall_objects);
						
					if (_key_up && _pushing_on_wall && !_under_ceiling) {
						state = PLAYER_STATES.CLIMB;
					}
					else {
						// Try to Push
						_wall_objects = is_left ? get_left_wall_objects() : get_right_wall_objects();
						_pushing_on_wall = (ds_list_size(_wall_objects) > 0);
						ds_list_destroy(_wall_objects);
								
						if (_pushing_on_wall) { state = PLAYER_STATES.PUSH; }
					}
				}
				else if (_key_up) {
					if (state == PLAYER_STATES.CROUCH) { state = PLAYER_STATES.STAND; }
					else if (state == PLAYER_STATES.POWERCROUCH && !_under_ceiling) { state = PLAYER_STATES.FLY; }
				}
				else if (_key_down) {
					if (state == PLAYER_STATES.CROUCH) { crouch_timer++; }
					else if (state != PLAYER_STATES.POWERCROUCH) { state = PLAYER_STATES.CROUCH; }
					if (crouch_timer == 32) { state = PLAYER_STATES.POWERCROUCH; }
				}
				
				// Change State due to lack of Player Input
				if (!_key_down && (state == PLAYER_STATES.CROUCH || state == PLAYER_STATES.POWERCROUCH)) { state = PLAYER_STATES.STAND; }
				if (!_key_left && !_key_right && (state == PLAYER_STATES.WALK || state == PLAYER_STATES.PUSH)) { state = PLAYER_STATES.STAND; }
			}
			
			break;
		}
		case PLAYER_STATES.FLY:
		case PLAYER_STATES.POWERFLY: {
			if (_under_ceiling) {
				// Bonk against ceiling
				if (state == PLAYER_STATES.POWERFLY) { 
					// TODO: Damage ceiling
				}
				y_speed -= 2;
				state = PLAYER_STATES.FALL;
			}
			else {
				if (state == PLAYER_STATES.FLY) { fly_timer++; }
				if (fly_timer == 32) { state = PLAYER_STATES.POWERFLY; }
			}
				
			break;
		}
		case PLAYER_STATES.HOP:
		case PLAYER_STATES.HOP_UP: {
			if (_on_ground) { state =  PLAYER_STATES.STAND; }
			else if (hop_timer >= 8) { state = PLAYER_STATES.FALL; }
			else { hop_timer++; }
		}
		case PLAYER_STATES.FALL:
		case PLAYER_STATES.POWERFALL: {
			if (_on_ground) {
				// Bonk against ceiling
				if (state == PLAYER_STATES.POWERFALL) { 
					y -= 8; // TODO: Don't bounce up if under a ceiling?
					state =  PLAYER_STATES.FALL;
					// TODO: Damage floor
				}
				else { state =  PLAYER_STATES.STAND; }
			}
			else {
				if (state == PLAYER_STATES.FALL) { fall_timer++; }
				if (fall_timer == 32) { state = PLAYER_STATES.POWERFALL; }
			}
				
			break;
		}
		case PLAYER_STATES.LADDER:
		case PLAYER_STATES.LADDER_UP:
		case PLAYER_STATES.LADDER_DOWN: {
			// TODO: Ladders
			if (!_able_to_ladder) { 
				state = _on_ground ? PLAYER_STATES.STAND : PLAYER_STATES.FALL; 
			}
			else if (_player_can_input) {
				// Change State due to Player Input
				if (_key_up) {
					var _can_ladder_up = false;
					with (_most_overlapping_ladder) {
						_can_ladder_up = y < other.y || place_meeting(x, y-1, obj_ladder);
					};
					if (_can_ladder_up) { state = PLAYER_STATES.LADDER_UP; is_up = true; }
					else { state = PLAYER_STATES.LADDER; }
						
				}
				else if (_key_down) {
					state = PLAYER_STATES.LADDER_DOWN;
					var _above_ladder = y < _most_overlapping_ladder.y;
					var _in_solid = place_meeting(x, y, obj_solid);
					var _above_another_ladder = place_meeting(_most_overlapping_ladder.x, _most_overlapping_ladder.y+sprite_height, obj_ladder);
					var _can_ladder_down = _in_solid || _above_another_ladder || _above_ladder || !is_grounded();
					if (_can_ladder_down) { state = PLAYER_STATES.LADDER_DOWN; is_up = false; }
					else { state = PLAYER_STATES.LADDER; }
				}
				else {
					state = PLAYER_STATES.LADDER;
					y_speed = 0;
				}
			}
			break;
		}
		case PLAYER_STATES.CLIMB: {
			climb_timer++;
			break;
		}
	}
	
	// Get on or Off Ladder Manually
	if (_player_can_input) {
		if (is_ladder_state() && _on_ground && !place_meeting(x,y,obj_solid)) {
			if ((_key_left || _key_right) && !_key_up && !_key_down) { state = PLAYER_STATES.STAND; }
		}
		else if (!is_ladder_state() && _able_to_ladder) {
			if (_key_up || _key_down) { state = PLAYER_STATES.LADDER; }
		}
	}
	
	// Update player position for moving platforms
	for (var i = 0; i < ds_list_size(_ground_objects); i++) {
		var obj = _ground_objects[| i];
		if (instance_exists(obj) && obj.id != id && obj.is_moving) {
			x_speed += obj.x_speed;
			y_speed += obj.y_speed;
		}
		else { x_speed = 0; y_speed = 0; break; }
	}
	
	switch (state) {
		case PLAYER_STATES.WALK:
		case PLAYER_STATES.PUSH: {
			_wall_objects = is_left ? get_left_pushable_objects() : get_right_pushable_objects();
			_pushing_on_wall = (ds_list_size(_wall_objects) > 0);
								
			if (_pushing_on_wall || state == PLAYER_STATES.WALK) {
				var _x_change = (is_left ? -2 : 2)
				x_speed += _x_change;
				for (var i = 0; i < ds_list_size(_wall_objects) ; i++) {
					var _wall_obj = _wall_objects[| i], _moved_amount = 0;
					
					with _wall_obj { 
						if (!is_grounded()) { continue; }
						
						_moved_amount = x_move(_x_change);
					}
					x_speed = min(_x_change, x_speed);
				}
			}
			ds_list_destroy(_wall_objects);
			break;
		}
		case PLAYER_STATES.LADDER_DOWN: {
			y_speed += 1;
			break;
		}
		case PLAYER_STATES.LADDER_UP: {
			y_speed -= 1;
			break;
		}
		case PLAYER_STATES.FLY:
		case PLAYER_STATES.POWERFLY: {
			y_speed -= 2;
			break;
		}
		case PLAYER_STATES.FALL:
		case PLAYER_STATES.POWERFALL: {
			y_speed += 2;
			break;
		}
		case PLAYER_STATES.HOP_UP:
		case PLAYER_STATES.HOP: {
			switch(hop_timer) {
				case 0: { y_speed += -2; break; }
				case 1:
				case 2: { y_speed += -1; break; }
				case 3:
				case 4: { y_speed += 0; break; }
				case 5:
				case 6: { y_speed += 1; break; }
				default: { y_speed += 2; break; }
			}
			if (state == PLAYER_STATES.HOP) { x_speed += (is_left) ? -1 : 1; }
			break;
		}
		case PLAYER_STATES.CLIMB: {
			_wall_objects = is_left ? get_left_climbable_objects() : get_right_climbable_objects();
			_pushing_on_wall = (ds_list_size(_wall_objects) > 0);
			ds_list_destroy(_wall_objects);
			
			if (_pushing_on_wall) { y_speed -= 2; }
			else { x_speed += (is_left ? -2 : 2); }
		}
	}
	
	// Actually move player
	if (is_ladder_state()) {
		x = _most_overlapping_ladder.x;
		y += y_speed;
	}
	else {
		x_move(x_speed);
		y_move(y_speed);
	}
	
	// Clean up ds lists
	if (_ground_objects != undefined && ds_exists(_ground_objects, ds_type_list)) { ds_list_destroy(_ground_objects); }
	if (_ceiling_objects != undefined && ds_exists(_ceiling_objects, ds_type_list)) { ds_list_destroy(_ceiling_objects); }
	if (_wall_objects != undefined && ds_exists(_wall_objects, ds_type_list)) { ds_list_destroy(_wall_objects); }
	if (_ladder_objects != undefined && ds_exists(_ladder_objects, ds_type_list)) { ds_list_destroy(_ladder_objects); }
}

function update_player_graphics() {
	if (state == PLAYER_STATES.POWERCROUCH || state == PLAYER_STATES.POWERFALL || state == PLAYER_STATES.POWERFLY) {
		visible = !visible;
	}
	else { visible = true; }
}

