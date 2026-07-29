// Draw Static Areas
if (!surface_exists(static_area_surface) || global.should_rebuild_static_area) { rebuild_static_area_surface(); }
shader_reset();
draw_surface(static_area_surface, 0, 0);
shader_set(shd_palettizer);
shader_set_uniform_f(global.u_tint_amount, 0.35);