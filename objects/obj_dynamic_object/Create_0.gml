// Inherit the parent event
event_inherited();

state = STATES.FALLING;

virtual_x = x;
virtual_y = y;
x_transition_timer = 0;
y_transition_timer = 0;
transition_timer = 0;

fall_timer = 0;
swim_timer = 0;

is_ground = true;
is_ceiling = true;
is_right_wall = true;
is_left_wall = true;

is_climbable = true;
has_gravity = true;

walk_particles = 0;
step_sound = noone;

depth = 9;

scr_dynamic_object_functions();