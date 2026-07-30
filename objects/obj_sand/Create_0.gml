event_inherited();

// Game Object Overrides
main_palette = PALETTES.SAND;
particle_palette = PALETTES.SAND;

// Static Area Overrides
main_sprite = spr_sand;
outline_sprite = spr_sand_outline;
fuzzing_sprite = spr_sand_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);
has_square_shape = true;

step_sound = snd_step_sand;
particle_frequency = 4;