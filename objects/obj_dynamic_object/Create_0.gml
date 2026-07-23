// Inherit the parent event
event_inherited();

state = STATES.FALLING;

virtual_x = x;
virtual_y = y;
virtual_y_offset = 0;
transition_timer = 0;
x_transition_timer = 0;
y_transition_timer = 0;
x_transition_speed = -1;
y_transition_speed = -1;

fall_timer = 0;
swim_timer = 0;

is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;

is_climbable = true;
has_gravity = true;
contents = noone;

walk_particles = 0;
step_sound = noone;

depth = 9;

scr_dynamic_object_functions();