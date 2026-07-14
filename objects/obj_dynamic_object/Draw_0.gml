var _y_offset = get_float_offset();
var _drawn_x_scale = (is_left) ? -1 : 1;
var _x_offset = (_drawn_x_scale == -1) ? sprite_get_width(sprite_index) : 0;

shader_set(shd_palettizer);
shader_set_uniform_f_array(u_base_colors, GRAYSCALE_PALETTE);
shader_set_uniform_f_array(u_replacement_colors, ((shine_timer == 0) ? ALL_WHITE_PALETTE : main_palette));

draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+_y_offset, _drawn_x_scale, 1, 0, image_blend, image_alpha);

shader_reset();
