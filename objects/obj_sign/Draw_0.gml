var _x_offset = (image_xscale == -1) ? sprite_get_width(sprite_index) : 0;
draw_sprite_ext(sprite_index, 0, virtual_x+_x_offset, virtual_y, image_xscale, 1, 0, image_blend, image_alpha);
if (sign_symbol >= 0) { draw_sprite_ext(spr_arrows, sign_symbol, virtual_x+_x_offset+6, virtual_y+7, image_xscale, 1, 0, image_blend, image_alpha); }