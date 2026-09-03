event_inherited();

// Game Object Variable Overrides
has_gravity = true;
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_portalable = true;
// is_left is set by variable definition and room start
is_up = false;

damaged_sound = snd_player_idle_yell;
destroyed_sound = snd_player_die;
	
/// Player State Variables
state = PLAYER_STATES.STAND;
prev_state = PLAYER_STATES.STAND;
air_walk = false;
climbed_inst = noone;
fall_sound = undefined;
pose_dir = DIRECTIONS.NONE;

// Palette and Visual Variables
set_depth(PLAYER_DEPTH);
sprite_index = spr_player_idle;
original_palette = PALETTES.PLAYER;
main_palette = original_palette;
particle_palette = PALETTES.BLUE;
powered_palette = get_world_palette(object_index);; // Needs to be set by controller at Room Start
death_sprite = spr_particle_player_dying;
afterimage_sprite = spr_player_dying;
silhouette_surface = undefined;
solid_mask_surface = undefined;

// Boolean Ability Flags
controlled_by_human = true;
can_power_up = true;
can_climb = true;
can_ladder = true;
can_push_objects = true//!global.original_controls;
can_duck = true//!global.original_controls;
can_look_up = true//!global.original_controls;
can_fly = !global.original_controls;
can_carry_objects = !global.original_controls;
can_be_crushed = !global.original_controls;

// Cape Variables
has_cape = true;
cape_depth = PLAYER_DEPTH + 1;
cape_state = CAPE_STATES.STAND;
cape_sprite_index = spr_cape_stand;
cape_image_index = 0;
cape_timer = 0;

// Timer Variables
portal_lockout_timer = 0;
animation_timer = 0;
ring_out_timer = 0;
crouch_timer = 0;
fly_timer = 0;
swim_timer = 0;
pose_timer = 0;
idle_timer = 0;
idle_loops = 0;
win_loops = 0;
step_index = 1;

// Functions
scr_player_functions();
treat_object_as_solid = function(_inst) { return _inst.is_a(obj_spikes) || _inst.is_a(obj_lava) || !would_be_damaged_by(_inst); }

game_object_step = function() {
	update_player_state();
	
	if (instance_exists(id)) {
		update_last_grid_position();
		update_player_graphics();
		if (has_cape) { update_cape_graphics(); }
	}
}

parent_update_virtual_y_offset = update_virtual_y_offset;	
update_virtual_y_offset = function() {
	if (state == PLAYER_STATES.CLIMB && instance_exists(climbed_inst)) {
		climbed_inst.update_virtual_y_offset();
		virtual_y_offset = climbed_inst.virtual_y_offset;
		if (array_contains(get_ground_objects(), climbed_inst)) { virtual_y_offset += get_deformed_offset(); }
	}
	else if (is_grounded_state()) {
		parent_update_virtual_y_offset();
		
		// Add offset from rounded corners
		var _left_ground = get_left_ground_object(), _right_ground = get_right_ground_object(), _ground_objects = [_left_ground, _right_ground], _min_corner_offset = 9999;
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i];
			if (!instance_exists(_inst)) { continue; }
			
			_min_corner_offset = min(_min_corner_offset, _inst.virtual_y_offset);
		}
		if (_min_corner_offset == 9999) { _min_corner_offset = 0; }
		virtual_y_offset += _min_corner_offset;
		
		// Add even more offset when teeterring on edge
		if (state == PLAYER_STATES.STAND_EDGE) || (state == PLAYER_STATES.LOOK_UP && ((is_left && !instance_exists(_left_ground)) || (!is_left && !instance_exists(_right_ground)))) { virtual_y_offset += 1; }
	}
	else { virtual_y_offset = 0; }
}

// Creation Code
reset_controls();

if (object_index == obj_player) {
	global.controller.x = virtual_x;
	global.controller.y = virtual_y;
}