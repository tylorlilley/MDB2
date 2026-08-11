event_inherited();

creator = noone;
main_palette = PALETTES.GRAY_LIGHT;
particle_palette = undefined;
particle_type = PARTICLE_TYPES.DEBRIS;
particle_frequency = 0;
image_blend = global.world_tint;

has_gravity = false;
if (!variable_instance_exists(id, "is_left")) { is_left = false; }

is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;

is_portalable = false;
is_climbable = false;
is_pushable = false;
is_fragile = false;
is_connected = false;
is_player_lethal = false;
is_powered_player_lethal = false;
is_robot_lethal = false;

hits = 1;
shine_timer = 0;
destroyed_sound = undefined;
damaged_sound = undefined;
step_sound = undefined;
particle_frequency = 0;
virtual_y_offset = 0;

scr_game_object_functions();
grid_add();