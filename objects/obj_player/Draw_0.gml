var _drawn_x_scale = (is_left) ? -1 : 1;
var _y_offset = (state == PLAYER_STATES.CLIMB) ? climbed_inst.get_float_offset() : get_float_offset();
var _x_offset = (is_left) ? sprite_get_width(sprite_index) : 0;
var _cape_x = virtual_x, _cape_y = virtual_y;
if (state != PLAYER_STATES.LADDER &&
	state !=  PLAYER_STATES.LADDER_UP &&
	state != PLAYER_STATES.LADDER_DOWN &&
	state != PLAYER_STATES.FALL &&
	state != PLAYER_STATES.DAZED_FALL &&
	state != PLAYER_STATES.RECOIL &&
	state != PLAYER_STATES.TUMBLE &&
	state != PLAYER_STATES.POWERFALL &&
	state != PLAYER_STATES.WIN &&
	state != PLAYER_STATES.FLY &&
	state != PLAYER_STATES.POWERFLY &&
	state != PLAYER_STATES.CRUSHED_STAND &&
	state != PLAYER_STATES.CRUSHED_FORWARD) {
	_cape_x += ((is_left) ? 8 : -8);
}



if (!has_cape) { draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+_y_offset, _drawn_x_scale, 1, 0, image_blend, 1); }
else if (cape_depth <= depth) {
	draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+_y_offset, _drawn_x_scale, 1, 0, image_blend, 1);
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x+_x_offset, _cape_y+_y_offset, _drawn_x_scale, 1, 0, image_blend, 1);
}
else {
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x+_x_offset, _cape_y+_y_offset, _drawn_x_scale, 1, 0, image_blend, 1);
	draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+_y_offset, _drawn_x_scale, 1, 0, image_blend, 1);
}
