event_inherited();

scr_static_area_functions();
initialize_static_area();

is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_climbable = true;

step_sound = noone;

has_darker_particles = false;

mark_manager_for_redraw = function() { if (instance_exists(manager)) { manager.should_redraw = true; } }
