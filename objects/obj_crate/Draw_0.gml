// Draw Self
event_inherited();

// Draw Contents
var _drawn_x_scale = (is_left) ? -1 : 1;
var _x_offset = (_drawn_x_scale == -1) ? sprite_get_width(sprite_index) : 0;
var _y_offset = get_float_offset();
if (instance_exists(contents)) {
	//draw_sprite_silhoutte(contents.sprite_index, 0, virtual_x+_x_offset, virtual_y+_y_offset, 1, 1, 0, c_white, 1);
	draw_sprite_ext(contents.sprite_index, 0, x+_x_offset, y+_y_offset, _drawn_x_scale, 1, 0, c_white, 0.5);
}