#macro GAME_TITLE "Mighty Dive Bomber"
#macro GRID_SIZE 8
#macro SCREEN_WIDTH 256
#macro SCREEN_HEIGHT 240
#macro SCREEN_SCALE_FACTOR 4
#macro SCREEN_MIDDLE_X SCREEN_WIDTH/2
#macro SCREEN_MIDDLE_Y SCREEN_HEIGHT/2

#macro TRANSITION_DURATION 24
#macro TRANSITION_DELAY 40
#macro TRANSITION_HOLD 12

// --- Particles
#macro PARTICLE_DEPTH -100

// -- Liquids
#macro WATER_DEPTH -50

// -- Player
#macro PLAYER_DEPTH -20
#macro CAPE_DEPTH -19

// -- Static Objects
#macro KEY_DEPTH -11
#macro LADDER_DEPTH -10

#macro OUTLINE_DEPTH 0
//--- Dynamic Objects
#macro GEAR_DEPTH 6
#macro CRATE_DEPTH 7
#macro SWITCH_DEPTH 8
#macro PORTAL_DEPTH 9
#macro DOOR_DEPTH 10
#macro STATIC_AREA_DEPTH 30 // Lowest Depth, works upward from obj_metal
#macro VISUAL_OBJECT_DEPTH 40 // Door, Tree Nubs
#macro BACKGROUND_DEPTH 50

enum FULL_SCREEN_OPTIONS {
	FULL_SCREEN,
	BORDERLESS_FULL_SCREEN,
	WINDOWED
}

// Global Variables
global.controller = id;
global.gamepad = noone;
global.original_controls = true;
global.combine_up_and_jump_controls = true;
global.color_portals = false;
global.u_replacement_colors = shader_get_uniform(shd_palettizer, "u_replacement_colors");
global.u_tint_amount = shader_get_uniform(shd_palettizer, "u_tint_amount");
global.room_keys = 0;
global.keys_collected = 0;
global.room_portals = 0;
global.world_tint = c_white;
global.world_tint_strength = 0;
global.mask_portals = true;
global.border_alpha = 0.5;
global.static_area_scratch_surface = undefined;
global.last_gamepad_h_axis_value = 0;
global.last_gamepad_v_axis_value = 0;

// Debug Variables
level_number = 0;
classic_level = false;
debug_enabled = true;
draw_game_object_grid = false;

// Set Up Game Audio
frame_sounds = [];
audio_falloff_set_model(audio_falloff_none);
audio_listener_position(0, 0, 0);
audio_listener_orientation(0, 1, 0, 0, 0, 1); // forward = room +y, up = out of screen => room +x is listener right
game_set_speed(30, gamespeed_fps);
palettes_init();

// Graphic Variables
depth = STATIC_AREA_DEPTH;
static_area_object_indexes_to_draw = [];
transition_surface = undefined;
screen_shake_timer = 0;

// Timers
screen_resize_timer = 0;
transition_timer = 0;
frame_timer = 0;
float_timer = 0;
creation_timer = 30;

// Gameplay Variables
blocked_switch_colors = [[], [], []];
pressed_switch_colors = [[], [], []];
pressed_switches = [];
game_object_grid = [];
room_seed = random_get_seed();
target_room = (irandom(100) == 0) ? rm_intro_eih : rm_intro;

initialize_room = function(_new_room) {
	play_sound(snd_fade_in);
	
	// Reset Per-room variables
	start_room_transition();
	global.room_keys = 0;
	global.room_portals = 0;
	global.keys_collected = 0;
	if (surface_exists(global.static_area_scratch_surface)) { surface_free(global.static_area_scratch_surface); global.static_area_scratch_surface = undefined; }
	
	// If Leaving Non-Cutscene Room for a New Room
	if (!is_cutscene_room() && _new_room != room && _new_room != rm_title) {
		level_number++;
		
		// Save Current Room
		ini_open("mdb.ini");
		ini_write_real("progress", "current_level", _new_room);
		ini_write_real("progress", "level_number", level_number);
		ini_write_real("progress", "progress_level", 0);
		ini_close();
	}
	
	target_room = room_next(_new_room);
	
	// Create an Empty Game Object Grid that matches the Room Size
	var _cols = room_get_info(_new_room).width div GRID_SIZE, _rows = room_get_info(_new_room).height div GRID_SIZE;
	game_object_grid = create_object_grid(_cols, _rows);
}

reset_room = function() {
	transition_room(room, false);
}

transition_room = function(_new_room, _randomize_room_seed = true) {
	if (_randomize_room_seed) { room_seed = randomize(); }
	random_set_seed(room_seed, true);
	initialize_room(_new_room);
	stop_sound(snd_player_fall);
	room_goto(_new_room);
}

start_screen_shake = function() { screen_shake_timer = 8; }

start_room_transition = function() { transition_timer = TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD; }

create_object_grid = function(_cols, _rows) {
	var _game_object_grid = array_create(_cols);
	for (var _x = 0; _x < _cols; _x++) {
		_game_object_grid[_x] = array_create(_rows);
		for (var _y = 0; _y < _rows; _y++) {
	        _game_object_grid[_x][_y] = [];
	    }
	}
	return _game_object_grid;
}

connect_static_areas_to_manager = function(_obj_index_array, _depth) {
	var _static_area_manager = instance_create(x, y, obj_static_area_manager);
	_static_area_manager.depth = _depth;
	
	for (var _i = 0; _i < array_length(_obj_index_array); _i++) {
		var _obj_index = _obj_index_array[_i];
	
		// Set up Static Area Types
		with (_obj_index) {
			depth = _static_area_manager.depth - _i; // TODO: Change this and places it is used to something unique rather than overloading GM depth
			if (!is_undefined(fuzzing_sprite)) { fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1); }
			if (animated) { positional_animation_offset = ((((visual_origin_x div 8) - (visual_origin_y div 8)) % 4 + 4) % 4) * 2; }
			if (_obj_index != obj_bg_dirt) { update_connections(); } // TODO: Base this on something else
			main_palette = get_world_palette(object_index) ?? main_palette;
			particle_palette = (has_darker_particles) ? get_darker_palette(main_palette) : main_palette;
			manager = _static_area_manager;
		}
	
		array_push(_static_area_manager.static_area_objects, _obj_index);
	}
	
	return _static_area_manager;
}

read_window_options = function() {
	window_fullscreen_pending = false;
	
	ini_open("mdb.ini");
	window_fullscreen_setting = ini_read_real("settings", "full_screen", FULL_SCREEN_OPTIONS.BORDERLESS_FULL_SCREEN);
	window_scale_setting = ini_read_real("settings", "screen_scale", get_maximum_screen_scale());
	ini_close();
}

write_window_options = function() {
	ini_open("mdb.ini");
	ini_write_real("settings", "full_screen", window_fullscreen_setting);
	ini_write_real("settings", "screen_scale", window_scale_setting);
	ini_close();
}

update_window_fullscreen = function() {
	var _should_be_windowed = (window_fullscreen_setting == FULL_SCREEN_OPTIONS.WINDOWED);
    var _should_be_borderless = (window_fullscreen_setting == FULL_SCREEN_OPTIONS.BORDERLESS_FULL_SCREEN);
	var _window_width = SCREEN_WIDTH * window_scale_setting, _window_height = SCREEN_HEIGHT * window_scale_setting, _display_width = display_get_width(), _display_height = display_get_height();
       
    screen_resize_timer = 12;
	
    // Swapping between exclusive and borderless: the flag is only read on the way in
    if (_should_be_borderless && window_get_fullscreen() && !window_fullscreen_pending) {
		// Swap from exclusive full to windowed so we can swap to borderless full in 12 frames
		window_fullscreen_pending = true;
        window_set_fullscreen(false);
		window_set_position((_display_width/2) - (_window_width/2),(_display_height/2) - (_window_height/2));
    }
	else {
		// Swap to windowed or exclusive fullscreen
		window_fullscreen_pending = false;
	    window_enable_borderless_fullscreen(_should_be_borderless);
	    window_set_fullscreen(!_should_be_windowed);
	}

	window_set_position((_display_width/2) - (_window_width/2),(_display_height/2) - (_window_height/2));
}

update_window_size = function() {
	var _window_width = SCREEN_WIDTH * window_scale_setting, _window_height = SCREEN_HEIGHT * window_scale_setting, _display_width = display_get_width(), _display_height = display_get_height();

	window_set_size(_window_width, _window_height);
	window_set_position((_display_width/2) - (_window_width/2),(_display_height/2) - (_window_height/2));
}

return_to_title = function(_blank_screen) {
	audio_stop_all();
	play_title_music();
	transition_room(rm_title);
	screen_shake_timer = 0;
	transition_timer = 0;
	frame_timer = 0;
	float_timer = 0;
	blank_screen = true;
	level_number = 0;
	classic_level = false;
}

// Read Window Size Properties
read_window_options();
window_fullscreen_setting = FULL_SCREEN_OPTIONS.BORDERLESS_FULL_SCREEN;
update_window_fullscreen();