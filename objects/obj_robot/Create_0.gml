// Inherit the parent event
event_inherited();

// Player Object Overrides
can_power_up = false;
can_push_objects = false;
can_carry_objects = false;
controlled_by_human = false;
can_be_crushed = false;
can_ladder = false;
can_climb = false;
has_cape = false;
spawned = false;

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

is_on_robot = function() {
	var _ground_objects = get_ground_objects();
	for (var _i = 0; _i < array_length(_ground_objects); _i++) {
		if (_ground_objects[_i].is_a(obj_robot)) { return true; }
	}
	return false;
}

// Function Overrides
treat_object_as_solid = function(_inst) { return _inst.is_a(obj_spikes) || _inst.is_a(obj_lava) || !would_be_damaged_by(_inst) && (!_inst.is_a(obj_player) || !_inst.controlled_by_human); }

update_controls = function() {
	if (!global.controller.is_logic_frame()) { exit; }
	
	// Check for turn around
	var _blocked_on_right = is_blocked_on_right(), _blocked_on_left = is_blocked_on_left(), _prev_is_left = is_left;
	
	// Update Walk Timer
	if (!is_on_ground()) { walk_timer = 0; should_walk = true; }
	else if (is_on_robot()) { walk_timer = 0; should_walk = true; }
	else {
		walk_timer = (walk_timer + 1) % 4;

		if (walk_timer == 0) {
			if (_blocked_on_right && _blocked_on_left) { key_left = false; key_right = false; should_walk = true; }
			else if (is_left && _blocked_on_left) { key_left = false; key_right = true; should_walk = true }
			else if (!is_left && _blocked_on_right) { key_left = true; key_right = false; should_walk = true; }
			else if (should_walk) { key_left = is_left; key_right = !is_left; should_walk = false; }
			else { key_left = false; key_right = false; should_walk = true; }
		}
	}	
}

parent_update_player_graphics = update_player_graphics;
update_player_graphics = function() {
	parent_update_player_graphics();
	
	// Assign Sprite Based on State
	var _image_index = image_index;
	if (state == PLAYER_STATES.STAND || state == PLAYER_STATES.WALK_FORWARD || state == PLAYER_STATES.STAND_EDGE) { sprite_index = spr_robot_walk; }
	else if (state == PLAYER_STATES.TURN) { sprite_index = spr_robot_turn; }
	else { sprite_index = spr_robot_fall; }
	
	image_index = (state == PLAYER_STATES.STAND) ? 0 : _image_index;
}