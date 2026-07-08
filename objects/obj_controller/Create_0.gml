window_set_size(256*3, 240*3);
game_set_speed(30, gamespeed_fps);
depth = -9999;
global.controller = id;
original_controls = false;
draw_game_object_grid = false;
transition_surface = noone;
transition_duration = 24;
transition_hold = 12;
transition_delay = 40;

frame_sounds = [];

initialize_room = function(_new_room) {
	play_sound(snd_fade_in);
	
	transition_timer = transition_delay + transition_duration + transition_hold;
	last_player_x = -32;
	last_player_y = -32;
	
	var _cols = room_get_info(_new_room).width div 8, _rows = room_get_info(_new_room).height div 8;
	game_object_grid = array_create(_cols);
	for (var _x = 0; _x < _cols; _x++) {
		game_object_grid[_x] = array_create(_rows, []);
		for (var _y = 0; _y < _rows; _y++) {
	        game_object_grid[_x][_y] = [];
	    }
	}
}

reset_room = function() {
	transition_room(room);
}

transition_room = function(_new_room) {
	initialize_room(_new_room);
	room_goto(_new_room);
}

transition_room(rm_ladder_test);