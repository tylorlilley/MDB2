event_inherited();

// Gameplay Variables
hits = 2;

// Sprite Variables
main_palette = PALETTES.SAND;
main_sprite = spr_tough_cloud_area;
outline_sprite = spr_tough_cloud_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_tough_cloud_fuzzing;
	
// Visual Drawing Variables
animated = false;
has_square_shape = true;
has_darker_particles = false;
particle_frequency = 4;
	
// Sound Variables
step_sound = snd_step_cloud;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_pop;
