event_inherited();

image_alpha = 1;
step_sound = snd_step_cloud;
destroyed_sound = snd_pop;
//is_fragile = true;

hits = 1;
main_palette = PALETTES.GRAY;
main_sprite = spr_cloud_area;
outline_sprite = spr_cloud_outline;
walk_particles = 4;
fuzzing_sprite = spr_cloud_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);
particle_palette = PALETTES.GRAY;