event_inherited();
step_sound = snd_step_sand;

walk_particles = 2;
particle_color = make_color_rgb(222, 202, 131);
main_sprite = spr_sand;
outline_sprite = spr_sand_outline;
fuzzing_sprite = spr_sand_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);