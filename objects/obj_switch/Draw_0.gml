shader_set(shd_palettizer);

shader_set_uniform_f_array(u_base_colors, GRAYSCALE_PALETTE);
shader_set_uniform_f_array(u_replacement_colors, ((shine_timer == 0) ? ALL_WHITE_PALETTE : get_switch_palette(switch_color)));

draw_self();
shader_reset();