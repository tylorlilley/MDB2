event_inherited();

// Gameplay Variables
hits = 0;

// Sprite Variables
main_palette = PALETTES.METAL;
main_sprite = spr_metal;
outline_sprite = spr_metal_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_metal_fuzzing;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = false;
particle_frequency = 0;
	
// Sound Variables
step_sound = snd_step_metal;
damaged_sound = snd_solid_invulnerable;
destroyed_sound = snd_explosion;