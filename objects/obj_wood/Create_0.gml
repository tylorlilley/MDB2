event_inherited();

hits = 2;
is_connected = true;
step_sound = snd_step_wood;

walk_particles = 1;
main_palette = PALETTES.BROWN;
main_sprite = spr_wood_vertical;
outline_sprite = spr_wood_outline;
fuzzing_sprite = spr_wood_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);