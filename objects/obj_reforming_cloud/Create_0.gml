event_inherited();

// Override Variables
main_palette = PALETTES.GRAY;
hits = 2;

// Override Functions
connected_to = function(_inst) { return _inst.object_index == object_index; }