event_inherited();

// Visual Variables
if (!variable_instance_exists(id, "is_left")) { is_left = false; }
interaction_depth = undefined;
particle_type = PARTICLE_TYPES.DEBRIS;
particle_frequency = 0;
particles_min = 2;
particles_max = 8;
virtual_y_offset = 0;

// Sound Variables
destroyed_sound = undefined;
damaged_sound = undefined;
step_sound = undefined;

// Gameplay Variables
hits = 1;
is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
has_gravity = false;
is_portalable = false;
is_climbable = false;
is_pushable = false;
is_fragile = false;
is_connected = false;
is_player_lethal = false;
is_powered_player_lethal = false;
is_robot_lethal = false;
creator = noone;
last_grid_x = x;
last_grid_y = y;

// Functions
scr_game_object_functions();

// Creation Code
grid_add();