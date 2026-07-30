#macro GRID_SIZE 8

#macro TRANSITION_DURATION 24
#macro TRANSITION_DELAY 40
#macro TRANSITION_HOLD 12

#macro PARTICLE_DEPTH -2
#macro WATER_DEPTH -1 // And Lava
#macro PLAYER_DEPTH 0
#macro CAPE_DEPTH 1
#macro DYNAMIC_OBJECT_DEPTH 2
#macro KEY_DEPTH 3
#macro SWITCH_DEPTH 4
#macro CRATE_DEPTH 5
#macro LADDER_DEPTH 6
#macro PORTAL_DEPTH 7
#macro STATIC_OBJECT_DEPTH 8
#macro STATIC_AREA_DEPTH 9
#macro VISUAL_OBJECT_DEPTH 10 // Tree

// Global Variables
global.controller = id;
global.gamepad = noone;
global.original_controls = true;
global.combine_up_and_jump_controls = true;
global.should_rebuild_static_area = true;
global.u_replacement_colors = shader_get_uniform(shd_palettizer, "u_replacement_colors");
global.u_tint_amount = shader_get_uniform(shd_palettizer, "u_tint_amount");
global.u_clip_uvs = shader_get_uniform(shd_palettizer, "u_clip_uvs");
global.u_clip_area = shader_get_uniform(shd_palettizer, "u_clip_area");
global.u_clip_enabled = shader_get_uniform(shd_palettizer, "u_clip_enabled");
global.u_clip_texture = shader_get_sampler_index(shd_palettizer, "u_clip_texture");
global.room_keys = 0;
global.world_tint = c_white;

// Debug Variables
show_debug_gui = true;
draw_game_object_grid = false;

// Set Up Game Window
window_set_size(256*4, 240*4);
window_set_fullscreen(false);
game_set_speed(30, gamespeed_fps);
determine_gamepad(); // Poll This Constantly on Title Screen
palettes_init();

// Graphic Variables
transition_surface = noone;
static_area_surface = noone;
screen_shake_timer = 0;
depth = STATIC_AREA_DEPTH;

// Timers
transition_timer = 0;
frame_timer = 0;

// Gameplay Variables
game_object_grid = [];
frame_sounds = [];
room_seed = random_get_seed();

initialize_room = function(_new_room) {
	play_sound(snd_fade_in);
	
	start_room_transition();
	global.last_player_x = undefined;
	global.last_player_y = undefined;
	global.room_keys = 0;
	
	// Create an Empty Game Object Grid that matches the Room Size
	var _cols = room_get_info(_new_room).width div GRID_SIZE, _rows = room_get_info(_new_room).height div GRID_SIZE;
	game_object_grid = array_create(_cols);
	for (var _x = 0; _x < _cols; _x++) {
		game_object_grid[_x] = array_create(_rows);
		for (var _y = 0; _y < _rows; _y++) {
	        game_object_grid[_x][_y] = [];
	    }
	}
}

reset_room = function() {
	transition_room(room, false);
}

transition_room = function(_new_room, _randomize_room_seed = false) {
	if (_randomize_room_seed) { room_seed = randomize(); }
	random_set_seed(room_seed);	
	global.should_rebuild_static_area = true;
	initialize_room(_new_room);
	room_goto(_new_room);
}

rebuild_static_area_surface = function() {
	// Set up Surface to Draw
	if (surface_exists(static_area_surface)) { surface_free(static_area_surface); }
	static_area_surface = surface_create(room_width, room_height);
	surface_set_target(static_area_surface);
	shader_set(shd_palettizer);
	draw_clear_alpha(0, 0);
	
	// Draw Tiles in Depth Order
	var _instances_to_draw = []
	with (obj_static_area) { array_push(_instances_to_draw, id); }
	array_sort(_instances_to_draw, function(_a, _b) { return _b.depth - _a.depth; });
	for (var _i = 0; _i < array_length(_instances_to_draw); _i++) {
		_instances_to_draw[_i].draw_static_area_tile();
	}
	
	// Reset Surface
	shader_reset();
	surface_reset_target();
	global.should_rebuild_static_area = false;
}

start_screen_shake = function() { screen_shake_timer = 8; }

start_room_transition = function() { transition_timer = TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD; }

transition_room(rm_mdb_1_1, true); //rm_test_terrain