event_inherited();

// Gameplay Variables
hits = 1;
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_climbable = true;

// Sprite Variables
main_palette = PALETTES.GRAY_LIGHT;
particle_palette = PALETTES.ALL_WHITE;
particle_frequency = 0;
	
// Sound Variables
step_sound = snd_eih_step;
damaged_sound = snd_eih_die;
destroyed_sound = snd_eih_die;

// New Variables
walk_timer = 0;

global.controller.target_room = room_next(rm_intro);