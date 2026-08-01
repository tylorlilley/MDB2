event_inherited();

scr_static_area_functions();
initialize_static_area();

main_palette = PALETTES.BROWN_DARK;
depth = BACKGROUND_DEPTH;

main_sprite = spr_sand_background;
outline_sprite = spr_sand_background_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_sand_background_fuzzing;
fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1);
hits = 0;

