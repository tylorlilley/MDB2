// Inherit the parent event
event_inherited();

// Visual Offset Variables
virtual_x = x;
virtual_y = y;
virtual_y_offset = 0;
x_transition_speed = undefined;
y_transition_speed = undefined;

// Timers
fall_timer = 0;
swim_timer = 0;
shine_timer = 0;

// State Variables
state = PLAYER_STATES.FALL;
can_carry_objects = false;
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_climbable = true;
has_gravity = true;

contents = noone;

scr_dynamic_object_functions();
reset_transition_timer();