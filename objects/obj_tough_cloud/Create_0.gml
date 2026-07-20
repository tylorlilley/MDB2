event_inherited();

image_alpha = 1;
step_sound = snd_step_cloud;
destroyed_sound = snd_pop;

hits = 2;
main_palette = PALETTES.SAND;
main_sprite = spr_tough_cloud_area;
outline_sprite = spr_tough_cloud_outline;
walk_particles = 4;
fuzzing_sprite = spr_tough_cloud_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);
