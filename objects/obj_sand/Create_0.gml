event_inherited();

// Gameplay Variables
hits = 1;

// Sprite Variables
main_palette = PALETTES.SAND;
main_sprite = spr_sand;
outline_sprite = spr_sand_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_sand_fuzzing;
	
// Visual Drawing Variables
animated = false;
has_square_shape = true;
has_darker_particles = false;
particle_frequency = 4;
	
// Sound Variables
step_sound = snd_step_sand;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_explosion;