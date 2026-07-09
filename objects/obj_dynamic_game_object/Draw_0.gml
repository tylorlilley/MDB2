event_inherited();

var _x_offset = (image_xscale == -1) ? sprite_get_width(sprite_index) : 0;
var _y_offset = get_float_offset();
draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+_y_offset, image_xscale, 1, 0, image_blend, image_alpha);