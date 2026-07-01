window_set_size(256*3, 240*3);
game_set_speed(30, gamespeed_fps);
depth = -9999;

var _cols = room_width div 8, _rows = room_height div 8;

global.controller = id;

game_object_grid = array_create(_cols);
for (var _x = 0; _x < _cols; _x++) {
	game_object_grid[_x] = array_create(_rows, []);
	for (var _y = 0; _y < _rows; _y++) {
        game_object_grid[_x][_y] = [];
    }
}

room_goto(rm_area_test);