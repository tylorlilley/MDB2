event_inherited();

step_sound = snd_step_rock;

hits = 3;
main_palette = PALETTES.GRAY;
outline_sprite = spr_brick_outline;
fuzzing_sprite = spr_brick_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);
main_sprite = spr_brick;
walk_particles = 0;