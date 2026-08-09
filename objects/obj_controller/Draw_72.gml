draw_set_alpha(1);
shader_set(shd_palettizer);
shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);