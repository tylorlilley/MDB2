event_inherited();

// Gameplay Variables
hits = 3;

// Sprite Variables
main_palette = PALETTES.RED;
main_sprite = spr_tile;
outline_sprite = spr_tile_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = undefined;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = false;
particle_frequency = 0;
	
// Sound Variables
step_sound = snd_step_bubble;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_explosion;