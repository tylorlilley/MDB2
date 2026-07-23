var _drawn_x_scale = (is_left) ? -1 : 1;
var _x_offset = (_drawn_x_scale == -1) ? sprite_get_width(sprite_index) : 0;

set_shader_palette();
draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+virtual_y_offset, _drawn_x_scale, 1, 0, image_blend, image_alpha);