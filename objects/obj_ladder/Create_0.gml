event_inherited();

// Visual Object Override
set_depth(LADDER_DEPTH);
main_palette = PALETTES.GRAY_LIGHT;
manager = noone;

// Overidden Functions
update_connections = function() {
	// Set Graphic Based on Adjacent Ladders and Solid Areas
	image_index = 0;
	var _spr_width = sprite_get_width(sprite_index), _spr_height = sprite_get_height(sprite_index);
	var _ladder_above = at_grid_position_exact(x, y-_spr_height, _spr_width, _spr_height, obj_static_area, false) || at_grid_position_exact(x, y-_spr_height, _spr_width, _spr_height, obj_ladder, false);
	var _ladder_below = at_grid_position_exact(x, y+_spr_height, _spr_width, _spr_height, obj_static_area, false) || at_grid_position_exact(x, y+_spr_height, _spr_width, _spr_height, obj_ladder, false);
	if (!_ladder_above && !_ladder_below) { image_index = 3; }
	else if (!_ladder_below) { image_index = 1; }
	else if (!_ladder_above) { image_index = 2; }
	if (instance_exists(manager)) { manager.should_redraw = true; }
}