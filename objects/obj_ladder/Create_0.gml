event_inherited();

depth = 0;
main_palette = PALETTES.GRAY;

get_connections_for_graphics = function() {
	// Set Graphic Based on Adjacent Ladders and Solid Areas
	image_index = 0;
	var _spr_width = sprite_get_width(sprite_index), _spr_height = sprite_get_height(sprite_index);
	var _ladder_above = at_grid_position_exact(x, y-_spr_height, _spr_width, _spr_height, obj_static_area) || at_grid_position_exact(x, y-_spr_height, _spr_width, _spr_height, obj_ladder);
	var _ladder_below = at_grid_position_exact(x, y+_spr_height, _spr_width, _spr_height, obj_static_area) || at_grid_position_exact(x, y+_spr_height, _spr_width, _spr_height, obj_ladder);
	if (!_ladder_above && !_ladder_below) { image_index = 3; }
	else if (!_ladder_below) { image_index = 1; }
	else if (!_ladder_above) { image_index = 2; }
}