event_inherited();

// Gameplay Variables
hits = 1;
//is_fragile = true;

// Sprite Variables
main_palette = PALETTES.GRAY_LIGHT;
main_sprite = spr_cloud_area;
outline_sprite = spr_cloud_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_cloud_fuzzing;
	
// Visual Drawing Variables
animated = false;
has_square_shape = true;
has_darker_particles = false;
particle_frequency = 4;
	
// Sound Variables
step_sound = snd_step_cloud;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_pop;