var _area_above = at_grid_position(x, y-8, 8, 8, object_index), _y_offset = (_area_above) ? 0 : 4;

draw_sprite_part_ext(spr_box_8x8, 0, 0, _y_offset, 8, 8-_y_offset, x, y+_y_offset, 1, 1, image_blend, image_alpha);
if (!_area_above) {
	var _x_offset = (anim_timer / 8 % 8);
	draw_sprite_part_ext(spr_water_outline, 0, _x_offset, 0, 8-_x_offset, _y_offset, x, y, 1, 1, image_blend, image_alpha);
	draw_sprite_part_ext(spr_water_outline, 0, 0, 0, _x_offset, _y_offset, x+(8-_x_offset), y, 1, 1, image_blend, image_alpha);
}
