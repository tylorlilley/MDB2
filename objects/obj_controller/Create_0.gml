#macro GAME_TITLE "Mighty Dive Bomber"
#macro PAUSE_MESSAGE_STRING "PAUSED\n\nPress RESTART to go to title.\nPress any other key to resume."
#macro TITLE_PAUSE_MESSAGE_STRING "PAUSED\n\nPress RESTART to exit.\nPress any other key to resume."

#macro GRID_SIZE 8
#macro SCREEN_WIDTH 256
#macro SCREEN_HEIGHT 240
#macro SCREEN_SCALE_FACTOR 4
#macro SCREEN_MIDDLE_X SCREEN_WIDTH/2
#macro SCREEN_MIDDLE_Y SCREEN_HEIGHT/2

#macro TRANSITION_DURATION 24
#macro TRANSITION_DELAY 40
#macro TRANSITION_HOLD 24//12

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

enum FPS_OPTIONS {
	FPS_30,
	FPS_60,
	FPS_120
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
quips_enabled = true;
debug_enabled = true;
level_number = 0;
classic_level = false;
draw_game_object_grid = false;
paused = false;

// FPS Variables
logical_fps = 30;
fps_ratio = 2;
fps_timer = 0;

// Paused Variables
pause_timer = 0;
paused = false;
unpausing = false;
paused_layers = [];

// Set Up Game Audio
frame_sounds = [];
audio_falloff_set_model(audio_falloff_none);
audio_listener_position(0, 0, 0);
audio_listener_orientation(0, 1, 0, 0, 0, 1); // forward = room +y, up = out of screen => room +x is listener right
palettes_init();

// Graphic Variables
depth = STATIC_AREA_DEPTH;
static_area_object_indexes_to_draw = [];
transition_surface = undefined;
screen_shake_timer = 0;

// Timers
screen_resize_timer = 0;
room_transition_timer = 0;
frame_timer = 0;
float_timer = 0;
creation_timer = 30;

// Gameplay Variables
blocked_switch_colors = [[], [], []];
pressed_switch_colors = [[], [], []];
pressed_switches = [];
game_object_grid = [];
room_seed = random_get_seed();
target_room = rm_intro_eih; //(irandom(100) == 0) ? rm_intro_eih : rm_intro;

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

start_room_transition = function() { room_transition_timer = TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD; }

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
			set_depth(_static_area_manager.depth - _i);
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
	window_fps_setting = ini_read_real("settings", "fps", get_maximum_fps());
	ini_close();
	
	window_fullscreen_setting = clamp(window_fullscreen_setting, 0, FULL_SCREEN_OPTIONS.WINDOWED);
	window_scale_setting = clamp(window_scale_setting, 1, get_maximum_screen_scale());
	window_fps_setting = clamp(floor(window_fps_setting / 30) * 30, 30, get_maximum_fps());
}

write_window_options = function() {
	ini_open("mdb.ini");
	ini_write_real("settings", "full_screen", window_fullscreen_setting);
	ini_write_real("settings", "screen_scale", window_scale_setting);
	ini_write_real("settings", "fps", window_fps_setting);
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

return_to_title = function() {
	audio_stop_all();
	play_title_music();
	transition_room(rm_title);
	screen_shake_timer = 0;
	room_transition_timer = 0;
	frame_timer = 0;
	fps_timer = 0;
	float_timer = 0;
	level_number = 0;
	latest_quip = "";
	classic_level = false;
}

latest_quip = "";
get_quip_text = function() {
	static _quip_text = [
		"Do something else.",
		"Really, Matt? Really?",
		"stop making him die",
		"Gosh, you really effed it this time.",
		"did you go to school?",
		"pls try",
		"im here with dr. mischevio and he is getting a little bit too excited about you dying a bunch",
		"lives are unlimited",
		"close, but no",
		"Oops, I guess you have to try again",
		"no cigar! just no cigar",
		"Try moving to different spaces.",
		"Shouldven't.",
		"You need all of the keys and to go to the door.",
		"Ya beefed it.",
		"not everyone can be a winner.",
		"You can cry if you want. You are allowed to. You are allowed to do it.",
		"I hope you're better at other stuff.",
		"Well howdy pardner! Ifn' ya suck so bad at this, I'da hate to see ya at high noon!",
		"Maybe give someone else a turn?",
		"Try ask Vince, he's good at helping",
		"For help call 614-747-0555 and ask for Tricky Dicky",
		"If you go to gamefaqs.com someone probably typed out the solution for this",
		"Tip: if you get stuck, you can always die",
		"Scrunty mustard sauce",
		"Watch a tutorial to beat the level",
		"Should we beat this one for you?",
		"Autoskip level lockout will initiate after: TWO [2] more deaths",
		"You were just pulling my leg with that one, right?",
		"Man even Leni beat that level and she doesn't even know any numbos yet",
		"I'm not trying to be mean-spirited at all, but you should really be better at this",
		"No one can say you didn't try.",
		"egg?",
		"Brought to you by the Carter Lilley Project",
		"Peej waz here",
		"And what exactly was the plan there?",
		"This time, try utilizing a strategy",
		"it okay, be quiet",
		"How did that help you again?",
		"I mean. It's a start!",
		"And what did we learn here today?",
		"That's not good enough...",
		"aw fuuuuuuuuuuuuck shit daaaaaaamn you bad",
		"WASTED",
		"you dieded",
		"That's rough, buddy.",
		"Have a problem? Consult a doctor!",
		"Scientists HATE this one weird trick: egg all their houses",
		"Skip this level for  $5.99?",
		"wow"
	]
	
	return _quip_text[irandom(array_length(_quip_text)-1)];
}

update_window_fps = function() {
	window_fps_setting = clamp(floor(window_fps_setting / 30) * 30, 30, get_maximum_fps());
	fps_timer = 0;
	fps_ratio = max(1, (window_fps_setting div logical_fps));
	game_set_speed(window_fps_setting, gamespeed_fps);
}

is_logic_frame = function() { return (fps_timer == 0 && !paused); }

get_frame_progress = function() { return fps_timer / fps_ratio; }

set_gui_matrix = function(_scaled) {
    matrix_set(matrix_world, _scaled ? matrix_build(0, 0, 0, 0, 0, 0, gui_scale, gui_scale, 1) : matrix_build_identity());
}

ensure_transition_surface = function() {
    var _w = SCREEN_WIDTH * gui_scale, _h = SCREEN_HEIGHT * gui_scale;
    if (surface_exists(transition_surface) && (surface_get_width(transition_surface) != _w || surface_get_height(transition_surface) != _h)) {
        surface_free(transition_surface);
    }
    if (!surface_exists(transition_surface)) { transition_surface = surface_create(_w, _h); }
}

// Read Window Size Properties
read_window_options();
update_window_fullscreen();
update_window_fps();