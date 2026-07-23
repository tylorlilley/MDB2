window_set_size(256*3, 240*3);
game_set_speed(30, gamespeed_fps);
depth = 10;
global.controller = id;
original_controls = false;
draw_game_object_grid = false;
transition_surface = noone;
static_area_surface = noone;
should_rebuild_static_area = true;
transition_duration = 24;
transition_hold = 12;
transition_delay = 40;
room_seed = random_get_seed();
shine_timer = 1;
screen_timer = 0;

u_replacement_colors = shader_get_uniform(shd_palettizer, "u_replacement_colors");

frame_sounds = [];
palettes_init();

initialize_room = function(_new_room) {
	room_keys = 0;
	play_sound(snd_fade_in);
	
	transition_timer = transition_delay + transition_duration + transition_hold;
	last_player_x = -32;
	last_player_y = -32;
	
	var _cols = room_get_info(_new_room).width div 8, _rows = room_get_info(_new_room).height div 8;
	game_object_grid = array_create(_cols);
	for (var _x = 0; _x < _cols; _x++) {
		game_object_grid[_x] = array_create(_rows);
		for (var _y = 0; _y < _rows; _y++) {
	        game_object_grid[_x][_y] = [];
	    }
	}
}

reset_room = function() {
	transition_room(room, room_seed);
}

transition_room = function(_new_room, _new_room_seed = noone) {
	room_seed = (_new_room_seed == noone) ? randomize() : _new_room_seed;
	random_set_seed(room_seed);	
	should_rebuild_static_area = true;
	initialize_room(_new_room);
	if (room != _new_room) {
		// TODO: Play Music Here
		build_background(WORLDS.FOREST);
	}
	room_goto(_new_room);
}

rebuild_static_area_surface = function() {
	if (surface_exists(static_area_surface)) { surface_free(static_area_surface); }
	static_area_surface = surface_create(room_width, room_height);
	surface_set_target(static_area_surface);
	shader_set(shd_palettizer);
	draw_clear_alpha(0, 0);
	
	with (obj_static_area) { draw_static_area_tile(); }

	surface_reset_target();
	should_rebuild_static_area = false;
}

screen_shake = function() {
	screen_timer = 8;
}

transition_room(rm_w2_1);