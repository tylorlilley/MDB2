event_inherited();

// Game Object Overrides
main_palette = PALETTES.SAND;
particle_palette = PALETTES.SAND;

// Static Area Overrides
main_sprite = spr_sand;
outline_sprite = spr_sand_outline;
fuzzing_sprite = spr_sand_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);

step_sound = snd_step_sand;
walk_particles = 2;