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

// Palette and Visual Variables
depth = PLAYER_DEPTH;
sprite_index = spr_player_idle;
original_palette = PALETTES.PLAYER;
main_palette = original_palette;
particle_palette = PALETTES.BLUE;
powered_palette = PALETTES.RED;
death_sprite = spr_particle_player_dying;

last_x = undefined;
last_y = undefined;

// Boolean Ability Flags
can_be_controlled = true;
can_power_up = true;
can_climb = true;
can_ladder = true;
can_push_objects = !global.original_controls;
can_be_crushed = !global.original_controls;

// Cape Variables
has_cape = true;
cape_depth = PLAYER_DEPTH + 1;
cape_state = CAPE_STATES.STAND;
cape_sprite_index = spr_cape_stand;
cape_image_index = 0;
cape_timer = 0;

// Timer Variables
transition_timer = 0;
animation_timer = 0;
ring_out_timer = 0;
crouch_timer = 0;
fly_timer = 0;
swim_timer = 0;
idle_timer = 0;
idle_loops = 0;
win_loops = 0;
step_index = 1;

// Functions
scr_player_functions();

game_object_step = function() {
	if (x > 0 && y > 0 && x < room_width && y < room_height) {
		last_x = x;
		last_y = y;
	}
	
	update_player_state();
	
	if (instance_exists(id)) {
		update_player_graphics();
		if (has_cape) { update_cape_graphics(); }
	}
}

update_virtual_y_offset = function() {
	if (state == PLAYER_STATES.CLIMB && instance_exists(climbed_inst)) {
		climbed_inst.update_virtual_y_offset();
		virtual_y_offset = climbed_inst.virtual_y_offset;
	}
	else if (is_grounded_state()) {
		virtual_y_offset = get_switch_offset() + get_float_offset();
	}
}

// Creation Code
reset_controls();

global.controller.x = x;
global.controller.y = y;