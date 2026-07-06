var _area_above = at_grid_position(x, y-8, 8, 8, object_index);
var _area_below = at_grid_position(x, y+8, 8, 8, object_index);
var _area_left = at_grid_position(x-8, y, 8, 8, object_index);
var _area_right = at_grid_position(x+8, y, 8, 8, object_index);

var _x_offset = -32, _y_offset = -32;
if (!_area_above && !_area_left && _area_below && _area_right) { // Top Left Corner
	_x_offset = 0;
	_y_offset = 0;
}
else if (!_area_above && _area_left && _area_below && !_area_right) { // Top Right Corner
	_x_offset = 16;
	_y_offset = 0;
}
else if (!_area_above && _area_left && _area_below && _area_right) { // Top Side
	_x_offset = 8;
	_y_offset = 0;
}
else if (!_area_below && !_area_left && _area_above && _area_right) { // Bottom Left Corner
	_x_offset = 0;
	_y_offset = 16;
}
else if (!_area_below && _area_left && _area_above && !_area_right) { // Nottom Right Corner
	_x_offset = 16;
	_y_offset = 16;
}
else if (!_area_below && _area_left && _area_above && _area_right) { // Bottom Side
	_x_offset = 8;
	_y_offset = 16;
}
else if (_area_below && !_area_left && _area_above && _area_right) { // Left Side
	_x_offset = 0;
	_y_offset = 8;
}
else if (_area_below && _area_left && _area_above && !_area_right) { // Right Side
	_x_offset = 16;
	_y_offset = 8;
}
else if (_area_below && !_area_left && _area_above && !_area_right) { // Bridge From Right to Left
	_x_offset = 0;
	_y_offset = 24;
}
else if (!_area_below && _area_left && !_area_above && _area_right) { // Bridge From Left to Right
	_x_offset = 8;
	_y_offset = 24;
}
else if (!_area_below && !_area_left && !_area_above && !_area_right) { // Alone
	_x_offset = 16;
	_y_offset = 24;
}
else if (_area_below && !_area_left && !_area_above && !_area_right) { // Peninsula With Bottom
	_x_offset = 0;
	_y_offset = 32;
}
else if (!_area_below && !_area_left && _area_above && !_area_right) { // Peninsula With Top
	_x_offset = 8;
	_y_offset = 32;
}
else if (!_area_below && !_area_left && !_area_above && _area_right) { // Peninsula With Right
	_x_offset = 16;
	_y_offset = 32;
}
else if (!_area_below && _area_left && !_area_above && !_area_right) { // Peninsula With Bottom
	_x_offset = 24;
	_y_offset = 32;
}

// Draw Main Graphics
var _is_even_x = ((x div 8) % 2 == 0), _is_even_y = ((y div 8) % 2 == 0), _main_sprite_image_index = (hits-1 <= 0) ? 0 : hits-1;
var _main_left = ((_is_even_x) ? 0 : 8), _main_top = ((_is_even_y) ? 0 : 8), _main_width = 8, _main_height = 8, _main_x = x, _main_y = y;

if (outline_sprite != noone) {
	if (!_area_below) { _main_height--; }
	if (!_area_above) { _main_height--; _main_top++; _main_y++; }
	if (!_area_right) { _main_width--; }
	if (!_area_left) { _main_width--; _main_left++; _main_x++; }
}

draw_sprite_part(main_sprite, _main_sprite_image_index, _main_left, _main_top, _main_width, _main_height, _main_x, _main_y);
if (fuzzing_sprite != noone) {
	draw_sprite_part(fuzzing_sprite, fuzzing_image_index, 0, 0, 8, 8, x, y);
}

// Draw Outline Graphics
if (outline_sprite != noone) {
	if (_x_offset >= 0 && _y_offset >= 0) { draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	
	// Additionally Draw Corners
	_x_offset = -1;
	_y_offset = -1;
	var _area_above_right = at_grid_position(x+8, y-8, 8, 8, object_index);
	var _area_above_left = at_grid_position(x-8, y-8, 8, 8, object_index);
	var _area_below_right = at_grid_position(x+8, y+8, 8, 8, object_index);
	var _area_below_left = at_grid_position(x-8, y+8, 8, 8, object_index);
	
	if (!_area_above_right && _area_above && _area_right) { _x_offset = 32; _y_offset = 0; draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	if (!_area_above_left && _area_above && _area_left) { _x_offset = 24; _y_offset = 0; draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	if (!_area_below_right && _area_below && _area_right) { _x_offset = 32; _y_offset = 8;  draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	if (!_area_below_left && _area_below && _area_left) { _x_offset = 24; _y_offset = 8;  draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
}
