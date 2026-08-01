// Draw Static Areas
if (!surface_exists(bg_area_surface)) { bg_area_surface = rebuild_surface(bg_area_surface, obj_bg_dirt); }
if (!surface_exists(static_area_surface) || global.should_rebuild_static_area) { static_area_surface = rebuild_surface(static_area_surface, obj_static_area); }
shader_reset();
draw_surface(bg_area_surface, 0, 0);
draw_surface(static_area_surface, 0, 0);
shader_set(shd_palettizer);
shader_set_uniform_f(global.u_tint_amount, 0.42);