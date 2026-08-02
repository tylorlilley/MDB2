#macro GRID_SIZE 8

#macro TRANSITION_DURATION 24
#macro TRANSITION_DELAY 40
#macro TRANSITION_HOLD 12

#macro PARTICLE_DEPTH -2
#macro WATER_DEPTH -1
#macro PLAYER_DEPTH 0
#macro CAPE_DEPTH 1
#macro DYNAMIC_OBJECT_DEPTH 2
#macro KEY_DEPTH 3
#macro CRATE_DEPTH 5
#macro LADDER_DEPTH 6
#macro SWITCH_BLOCK_DEPTH 7
#macro PORTAL_DEPTH 8
#macro SWITCH_DEPTH 9//4
#macro STATIC_OBJECT_DEPTH 10
#macro STATIC_AREA_DEPTH 11
#macro VISUAL_OBJECT_DEPTH 15 // Tree
#macro BACKGROUND_DEPTH 20

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
global.keys_collected = 0;
global.room_portals = 0;
global.world_tint = c_white;

// Debug Variables
level_number = -1;
show_debug_gui = false;
draw_game_object_grid = false;

// Set Up Game Window
window_set_size(256*4, 240*4);
window_enable_borderless_fullscreen(true);
window_set_fullscreen(true);

// Set Up Game Audio
frame_sounds = [];
audio_falloff_set_model(audio_falloff_none);
audio_listener_position(0, 0, 0);
audio_listener_orientation(0, 1, 0, 0, 0, 1); // forward = room +y, up = out of screen => room +x is listener right

game_set_speed(30, gamespeed_fps);
determine_gamepad(); // TODO: Poll This Constantly on Title Screen
palettes_init();

// Graphic Variables
depth = STATIC_AREA_DEPTH;
transition_surface = noone;
screen_shake_timer = 0;
scr_surface_manager_functions();
initialize_surface_manager();

// Timers
transition_timer = 0;
frame_timer = 0;

// Gameplay Variables
blocked_switch_colors = [false, false, false];
game_object_grid = [];
pending_switch_colors = [];
room_seed = random_get_seed();

initialize_room = function(_new_room) {
	play_sound(snd_fade_in);
	
	start_room_transition();
	global.room_keys = 0;
	global.room_portals = 0;
	global.keys_collected = 0;
	if (_new_room != room) { level_number++; }
	
	// Create an Empty Game Object Grid that matches the Room Size
	var _cols = room_get_info(_new_room).width div GRID_SIZE, _rows = room_get_info(_new_room).height div GRID_SIZE;
	initialize_game_object_grid(_cols, _rows);
}

reset_room = function() {
	transition_room(room, false);
}

transition_room = function(_new_room, _randomize_room_seed = false) {
	if (_randomize_room_seed) { room_seed = randomize(); }
	random_set_seed(room_seed);	
	global.should_rebuild_static_area = true;
	if (surface_exists(static_area_surface)) { surface_free(static_area_surface); static_area_surface = noone; }
	initialize_room(_new_room);
	audio_stop_sound(snd_player_fall);
	room_goto(_new_room);
}

start_screen_shake = function() { screen_shake_timer = 8; }

start_room_transition = function() { transition_timer = TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD; }

transition_room(rm_mdb_1_1, true); //rm_test_terrain