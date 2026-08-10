event_inherited();

scr_static_area_functions();
initialize_static_area();

main_palette = PALETTES.BACKGROUND_DIRT;
has_darker_particles = false;
// depth = BACKGROUND_DEPTH;

main_sprite = spr_sand_background;
outline_sprite = spr_sand_background_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = spr_sand_background_fuzzing;
hits = 0;

