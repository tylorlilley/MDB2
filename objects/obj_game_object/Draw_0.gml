if (shine_timer == 0) { shader_set(shd_replace_black_with_white); }
draw_self();
if (shine_timer == 0) { shader_reset(); }