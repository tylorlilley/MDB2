// Inherit the parent event
event_inherited();
depth = WATER_DEPTH;
animated = true;

anim_timer = 0;
main_palette = PALETTES.RED;

is_climbable = false;
is_connected = true;
is_player_lethal = true;
is_robot_lethal = true;

hits = 0;
step_sound = snd_step_metal;
damaged_sound = snd_solid_invulnerable;
main_palette = PALETTES.RED;
main_sprite = spr_lava_old;
outline_sprite = spr_lava_outline;
walk_particles = 8;