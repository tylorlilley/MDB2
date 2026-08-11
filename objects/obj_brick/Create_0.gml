event_inherited();

// Gameplay Variables
hits = 3;

// Sprite Variables
main_palette = PALETTES.GRAY_LIGHT;
main_sprite = spr_brick;
outline_sprite = spr_brick_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_brick_fuzzing;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = true;
particle_frequency = 1;
	
// Sound Variables
step_sound = snd_step_brick;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_explosion;