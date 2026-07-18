// Draw Static Areas
if (!surface_exists(static_area_surface) || should_rebuild_static_area) { rebuild_static_area_surface(); }
draw_surface(static_area_surface, 0, 0);