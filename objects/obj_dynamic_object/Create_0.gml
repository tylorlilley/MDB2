// Inherit the parent event
event_inherited();

state = STATES.FALLING;

virtual_x = x;
virtual_y = y;

is_ground = true;
is_ceiling = true;
is_right_wall = true;
is_left_wall = true;

is_climbable = true;
has_gravity = true;

walk_particles = 0;
step_sound = noone;

depth = 9;

carried_objects = [];

scr_dynamic_object_functions();