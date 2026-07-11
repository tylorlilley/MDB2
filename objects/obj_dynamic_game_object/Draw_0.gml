event_inherited();

var _y_offset = get_float_offset();
var _x_offset = (image_xscale == -1) ? sprite_get_width(sprite_index) : 0;
if (carrier_count > 0) { _x_offset += (carrier_x_offset div carrier_count); }

draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+_y_offset, image_xscale, 1, 0, image_blend, image_alpha);