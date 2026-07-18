event_inherited();

step_sound = snd_step_metal;
switch_color = noone;
hits = 0;
main_palette = PALETTES.GRAY_DARK;
main_sprite = spr_metal;
outline_sprite = spr_metal_outline;
fuzzing_sprite = spr_metal_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);
walk_particles = 0;