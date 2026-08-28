shader_reset();

draw_set_alpha(image_alpha);
draw_line_width_color(x + 8, y + 8, dest_x + 8, dest_y + 8, 1, main_color, player_color);
draw_set_alpha(1);

shader_set(shd_palettizer);
shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);