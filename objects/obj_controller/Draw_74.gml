draw_set_alpha(1);
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, gui_scale, gui_scale, 1));
shader_set(shd_palettizer);
shader_set_uniform_f(global.u_tint_amount, 0);