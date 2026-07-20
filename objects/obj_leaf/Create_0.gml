event_inherited();

step_sound = snd_step_leaf;
destroyed_sound = snd_pop;

hits = 1;
main_palette = PALETTES.GREEN_DARK;
main_sprite = spr_leaf_area;
outline_sprite = spr_leaf_outline;
walk_particles = 4;
fuzzing_sprite = spr_leaf_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);