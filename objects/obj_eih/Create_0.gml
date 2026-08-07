event_inherited();

hits = 1;
particle_palette = PALETTES.ALL_WHITE;
walk_timer = 0;
destroyed_sound = snd_eih_die;

is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_climbable = true;
step_sound = snd_eih_step;

global.controller.target_room = room_next(rm_intro);