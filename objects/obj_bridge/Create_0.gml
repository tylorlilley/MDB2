event_inherited();

// Gameplay Variables
hits = 1;
is_connected = true;
is_solid_from_left = false;
is_solid_from_right = false;
is_solid_from_below = false;

// Sprite Variables
main_palette = PALETTES.BROWN;
main_sprite = spr_bridge;
outline_sprite = undefined;
outline_mask_sprite = undefined;
fuzzing_sprite = undefined;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = true;
particle_frequency = 1;
	
// Sound Variables
step_sound = snd_step_bridge;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_explosion;