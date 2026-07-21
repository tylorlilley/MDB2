var _drawn_x_scale = (is_left) ? -1 : 1;
var _x_offset = (_drawn_x_scale == -1) ? sprite_get_width(sprite_index) : 0;

set_shader_palette();
draw_sprite_ext(sprite_index, 0, x+_x_offset, y, _drawn_x_scale, 1, 0, image_blend, image_alpha);
if (sign_symbol >= 0) { draw_sprite_ext(spr_arrows, sign_symbol, x+_x_offset+6, y+7, _drawn_x_scale, 1, 0, image_blend, image_alpha); }
