// Inherit the parent event
event_inherited();

// Player Object Overrides
can_power_up = false;
can_push_objects = false;
can_carry_objects = false;
can_be_controlled = false;
can_be_crushed = false;
can_ladder = false;
can_climb = false;
has_cape = false;

// Game Object Overrides
is_player_lethal = true;
damaged_sound = snd_robot_die;
destroyed_sound = snd_explosion;

// Visual Object Overrides
sprite_index = spr_robot_walk;
death_sprite = spr_particle_robot_dying;
original_palette = PALETTES.GRAY_LIGHT;
particle_palette = original_palette;
main_palette = original_palette;

// New Variables
walk_timer = 0;
should_walk = true;

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
	
	// Update Walk Timer
	if (!is_on_ground()) { walk_timer = 0; should_walk = true; }
	else {
		walk_timer = (walk_timer + 1) % 4;

		if (walk_timer == 0) {
			if (_blocked_on_right && _blocked_on_left) { key_left = false; key_right = false; should_walk = true; }
			else if (is_left && _blocked_on_left) { key_left = false; key_right = true; should_walk = true }
			else if (!is_left && _blocked_on_right) { key_left = true; key_right = false; should_walk = true; }
			else if (should_walk) { key_left = is_left; key_right = !is_left; should_walk = false; }
			else {
				key_left = false; key_right = false; should_walk = true;
				}
		}
	}	
}

parent_update_player_graphics = update_player_graphics;
update_player_graphics = function() {
	parent_update_player_graphics();
	
	// Assign Sprite Based on State
	var _image_index = image_index;
	if (state == PLAYER_STATES.STAND || state == PLAYER_STATES.WALK_FORWARD) { sprite_index = spr_robot_walk; }
	else if (state == PLAYER_STATES.TURN) { sprite_index = spr_robot_turn; }
	else { sprite_index = spr_robot_fall; }
	
	image_index = (state == PLAYER_STATES.STAND) ? 0 : _image_index;
}