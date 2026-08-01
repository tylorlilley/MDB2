if (!surface_exists(static_area_surface)) { static_area_surface = rebuild_surface(static_area_surface); }
draw_surface(static_area_surface, 0, 0);