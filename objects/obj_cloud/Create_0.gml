event_inherited();

image_alpha = 0.8;
particle_color = c_white;
step_sound = snd_step_cloud;
destroyed_sound = snd_pop;
is_fragile = true;

hits = 1;
main_sprite = spr_box_16x16;
outline_sprite = spr_cloud_outline;
walk_particles = 4;
particle_color = c_white;
fuzzing_sprite = spr_cloud_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite));