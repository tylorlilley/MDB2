shader_set(shd_palettizer);

shader_set_uniform_f_array(global.controller.u_base_colors, global.GRAYSCALE_PALETTE);
shader_set_uniform_f_array(global.controller.u_replacement_colors, ((shine_timer == 0) ? global.ALL_WHITE_PALETTE : main_palette));

draw_self();
shader_reset();