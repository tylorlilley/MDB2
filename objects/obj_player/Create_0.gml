event_inherited();

// Game Object Variables
has_gravity = true;
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_portalable = true;
is_left = true;
is_up = false;
	
cape_state = CAPE_STATES.STAND;
cape_sprite_index = spr_cape_stand;
cape_image_index = 0;
cape_timer = 0;
step_index = 1;
air_walk = false;
climbed_inst = noone;
fall_sound = noone;
	
// Player Specific Variables
prev_state = PLAYER_STATES.STAND;
state = PLAYER_STATES.STAND;
image_speed = 0;
depth = PLAYER_DEPTH;
cape_depth = PLAYER_DEPTH + 1;
sprite_index = spr_player_idle;
original_palette = PALETTES.PLAYER;
main_palette = original_palette;
particle_palette = PALETTES.BLUE;
powered_palette = PALETTES.RED;
death_sprite = spr_particle_player_dying;
idle_timer = 0;
idle_cycle = 0;

can_be_controlled = true;
can_power_up = true;
can_push_objects = !global.original_controls;
can_be_crushed = !global.original_controls;
has_cape = true;
last_x = undefined;
last_y = undefined;

transition_timer = 0;
animation_timer = 0;
ring_out_timer = 0;
crouch_timer = 0;
fly_timer = 0;
swim_timer = 0;

scr_player_functions();
	
reset_controls();

global.last_player_x = x;
global.last_player_y = y;

game_object_step = function() {
	update_player_state();
	update_player_graphics();
	if (has_cape) { update_cape_graphics(); }

	if (x > 0 && y > 0 && x < room_width && y < room_height) {
		last_x = x;
		last_y = y;
	}
}

update_virtual_y_offset = function() {
	if (state == PLAYER_STATES.CLIMB) {
		climbed_inst.update_virtual_y_offset();
		virtual_y_offset = climbed_inst.virtual_y_offset;
	}
	else if (is_grounded_state()) {
		virtual_y_offset = get_switch_offset() + get_float_offset();
	}
}