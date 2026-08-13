// Inherit the parent event
event_inherited();
reset_shine_timer();

// Visual Object Overrides
original_palette = PALETTES.YELLOW;
main_palette = original_palette;
particle_palette = get_darker_palette(PALETTES.YELLOW);

// Dynamic Object Overrides
contents = obj_key;
