event_inherited();

// Gameplay Variables
hits = 2;

// Sprite Variables
main_palette = PALETTES.BROWN;
main_sprite = spr_rock;
outline_sprite = spr_rock_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = undefined;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = true;
particle_frequency = 2;
	
// Sound Variables
step_sound = snd_step_rock;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_explosion;