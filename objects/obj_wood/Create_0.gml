event_inherited();

// Gameplay Variables
hits = 2;
is_connected = true;

// Sprite Variables
main_palette = PALETTES.BROWN;
main_sprite = spr_wood_vertical;
outline_sprite = spr_wood_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_wood_fuzzing;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = true;
particle_frequency = 1;
	
// Sound Variables
step_sound = snd_step_wood;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_explosion;