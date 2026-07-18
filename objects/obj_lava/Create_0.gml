// Inherit the parent event
event_inherited();
image_blend = global.C_RED;
depth = -20;

anim_timer = 0;
main_palette = PALETTES.RED;

is_climbable = false;
is_connected = true;
is_player_lethal = true;
is_robot_lethal = true;

hits = 0;
walk_particles = 4;
step_sound = noone; // TODO