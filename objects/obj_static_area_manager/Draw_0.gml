if (should_redraw || !surface_exists(static_area_surface)) { redraw_static_area_surface(); }
draw_surface_without_shader(static_area_surface);