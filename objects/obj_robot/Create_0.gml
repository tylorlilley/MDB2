// Inherit the parent event
event_inherited();

// Player Object Overrides
can_power_up = false;
can_push_objects = false;
can_be_controlled = false;
can_be_crushed = false;
has_cape = false;

// Game Object Overrides
is_player_lethal = true;

// Visual Object Overrides
sprite_index = spr_robot_walk;
death_sprite = spr_particle_robot_dying;
original_palette = PALETTES.GRAY_LIGHT;
particle_palette = original_palette;
main_palette = original_palette;

// New Variables
walk_timer = 0;
turn_timer = 0;
turn_pending = false;

// Function Overrides
parent_is_blocked_on_left = is_blocked_on_left;
parent_is_blocked_on_right = is_blocked_on_right;
parent_is_on_ground = is_on_ground;
parent_is_inside_solid = is_inside_solid;
parent_get_carried_objects = get_carried_objects;

// Functions
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

is_on_ground = function() {
	return parent_is_on_ground(get_list_of_controllable_players());
}

// Modify Parent to Exclude Robots Facing the Same Direction
get_carried_objects = function(_sort_x_by_negative = true) {
	var _carried_objects = parent_get_carried_objects(_sort_x_by_negative), _modified_carried_objects = []
	for (var _i = 0; _i < array_length(_carried_objects); _i++) {
		var _inst = _carried_objects[_i];
		if (!_inst.is_a(obj_robot) || _inst.is_left == is_left) { array_push(_modified_carried_objects, _inst); }
	}
	return _modified_carried_objects;
}

update_controls = function() {
	// Check for turn around
	var _blocked_on_right = is_blocked_on_right(), _blocked_on_left = is_blocked_on_left(), _prev_is_left = is_left;

	if (_blocked_on_right && _blocked_on_left) { is_left = true; } // OLD GAME: is_left = true;
	else if (is_left && _blocked_on_left) { is_left = false; }
	else if (!is_left && _blocked_on_right) { is_left = true; }
	if (is_left != _prev_is_left) { turn_pending = true; }
	
	// Update Walk Timer
	var _grounded = is_on_ground();
	if (!is_on_ground()) { walk_timer = 0; }
	else {
		walk_timer++;
		walk_timer = walk_timer % 8;
		// Update State
		if (walk_timer == 0) {
			var _freeze_on_top_of_robot = false, _ground_objects = get_ground_objects();
			for (var _i = 0; _i < array_length(_ground_objects); _i++) {
				var _inst = _ground_objects[_i];
				if (_inst.is_a(obj_robot) && _inst.is_left == is_left) { _freeze_on_top_of_robot = true;  break; }
			}

			if (!_freeze_on_top_of_robot) {
				key_left = is_left;
				key_right = !is_left;
			}
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
	}
	
	// Deal with deferred turn
	if (turn_pending && x_transition_timer == 0) { turn_pending = false; turn_timer = 4; }
	if (turn_timer > 0) {
		sprite_index = spr_robot_turn;
		image_index = (turn_timer > 2) ? 0 : 1;
		turn_timer--;
	}
	
	image_index = (state == PLAYER_STATES.STAND) ? 0 : _image_index;
}