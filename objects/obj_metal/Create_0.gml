event_inherited();

step_sound = snd_step_metal;

hits = 0;
main_sprite = spr_metal;
outline_sprite = spr_metal_outline;
fuzzing_sprite = spr_metal_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);
walk_particles = 0;
particle_color = make_color_rgb(189, 189, 189);