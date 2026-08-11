event_inherited();

scr_static_area_functions();
initialize_static_area();

// Gameplay Variables
hits = 0;
is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

// Sprite Variables
main_palette = PALETTES.BACKGROUND_DIRT;
main_sprite = spr_sand_background;
outline_sprite = spr_sand_background_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_sand_background_fuzzing;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = false;
particle_frequency = 0;
	
// Sound Variables
step_sound = undefined;
damaged_sound = undefined;
destroyed_sound = undefined;