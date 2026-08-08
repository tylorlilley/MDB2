event_inherited();

// Override Variables
outline_sprite = spr_reforming_cloud_outline;
main_palette = PALETTES.GRAY;
hits = 2;

// Override Functions
connected_to = function(_inst) { return _inst.object_index == object_index; }