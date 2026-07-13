event_inherited();

// Game Object Variables
has_gravity = true;
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_left = true;
	
cape_state = CAPE_STATES.STAND;
cape_sprite_index = spr_cape_stand;
cape_image_index = 0;
cape_timer = 0;
step_index = 1;
air_walk = false;
climbed_inst = noone;
	
// Player Specific Variables
prev_state = PLAYER_STATES.STAND;
state = PLAYER_STATES.STAND;
image_speed = 0;
depth = -2;
cape_x = x;
cape_y = y;
cape_depth = 1;

death_sprite = spr_player_dying_particle;
death_particle_color1 = make_color_rgb(60, 188, 255);
death_particle_color2 = make_color_rgb(0, 0, 255);

can_be_controlled = true;
can_power_up = true;
can_push_objects = !global.controller.original_controls;
can_be_crushed = !global.controller.original_controls;
has_cape = true;
last_x = -999;
last_y = -999;

transition_timer = 0;
animation_timer = 0;
ring_out_timer = 0;
crouch_timer = 0;
fly_timer = 0;
swim_timer = 0;

scr_player_functions();
	
reset_controls();

global.controller.last_player_x = x;
global.controller.last_player_y = y;

game_object_step = function() {
	update_player_state();
	update_player_graphics();
	update_cape_graphics();

	if (x > 0 && y > 0 && x < room_width && y < room_height) {
		last_x = x;
		last_y = y;
	}
}
