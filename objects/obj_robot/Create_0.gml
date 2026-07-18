// Inherit the parent event
event_inherited();

is_left = false;
can_power_up = false;
can_push_objects = false;
can_be_controlled = false;
can_be_crushed = false;
is_player_lethal = true;

has_cape = false;
walk_timer = 0;

sprite_index = spr_robot_walk;
death_sprite = spr_robot_dying_particle;
original_palette = global.PALETTE_GRAYSCALE;
main_palette = original_palette;

parent_is_blocked_on_left = is_blocked_on_left;
parent_is_blocked_on_right = is_blocked_on_right;
parent_is_inside_solid = is_inside_solid;
parent_get_carried_objects = get_carried_objects;

get_list_of_controllable_players = function() {
	var _ignored_objects = []
	with (obj_player) { if (can_be_controlled) { array_push(_ignored_objects, id); } }
	return _ignored_objects;
}

is_inside_solid = function() {
	return parent_is_inside_solid(get_list_of_controllable_players());
}

is_blocked_on_left = function() {
	return parent_is_blocked_on_left(get_list_of_controllable_players());
}

is_blocked_on_right = function() {
	return parent_is_blocked_on_right(get_list_of_controllable_players());
}

get_carried_objects = function(_sort_x_by_negative = true) {
	var _carried_objects = parent_get_carried_objects(_sort_x_by_negative), _modified_carried_objects = []
	for (var _i = 0; _i < array_length(_carried_objects); _i++) {
		var _inst = _carried_objects[_i];
		if (!is_a(_inst, obj_robot) || _inst.is_left == is_left) { array_push(_modified_carried_objects, _inst); }
	}
	return _modified_carried_objects;
}

update_controls = function() {
	// Check for turn around
	var _blocked_on_right = is_blocked_on_right(), _blocked_on_left = is_blocked_on_left(), _turned_around = false;

	if (_blocked_on_right && _blocked_on_left) { _turned_around = true; } // OLD: is_left = true;
	else if (is_left && _blocked_on_left) { key_right = true; _turned_around = true; }
	else if (!is_left && _blocked_on_right) { key_left = true; _turned_around = true; }
	
	walk_timer++;
	walk_timer = walk_timer % 8;
	if (state == PLAYER_STATES.FALL) { walk_timer = 0; }
	
	if (walk_timer == 0 && state != PLAYER_STATES.FALL) {
		var _freeze_on_top_of_robot = false, _ground_objects = get_ground_objects();
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i];
			if (is_a(_inst, obj_robot) && _inst.is_left == is_left) { _freeze_on_top_of_robot = true;  break; }
		}

		if (!_freeze_on_top_of_robot && !_turned_around) {
			key_left = is_left;
			key_right = !is_left;
		}
	}
		
}

parent_update_player_graphics = update_player_graphics;
update_player_graphics = function() {
	parent_update_player_graphics();
	var _image_index = image_index, _carried_objects = get_carried_objects()
	switch (sprite_index) {
		case spr_robot_walk:
		case spr_robot_carry:
		case spr_player_walk:
		case spr_player_idle: { sprite_index = (array_length(_carried_objects) > 0) ? spr_robot_carry : spr_robot_walk; break; }
		case spr_player_fall: { sprite_index = spr_robot_fall; break; }
		case spr_player_turn: { sprite_index = spr_robot_turn; break; }
	}
	
	image_index = (state == PLAYER_STATES.STAND) ? 0 : _image_index;
}