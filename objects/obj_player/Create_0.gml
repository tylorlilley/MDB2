event_inherited();

// Game Object Variables
has_gravity = true;
is_ground = true;
is_ceiling = false;
is_right_wall = false;
is_left_wall = false;
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
