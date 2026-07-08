var _virtual_x = round(virtual_x), _virtual_y = round(virtual_y);
var _cape_x = _virtual_x, _cape_y = _virtual_y;
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

var _x_offset = (is_left) ? sprite_get_width(sprite_index) : 0;
if (cape_depth <= depth) {
	draw_sprite_ext(sprite_index, image_index, _virtual_x+_x_offset, _virtual_y, image_xscale, 1, 0, image_blend, 1);
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x+_x_offset, _cape_y, image_xscale, 1, 0, c_white, 1);
}
else {
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x+_x_offset, _cape_y, image_xscale, 1, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, _virtual_x+_x_offset, _virtual_y, image_xscale, 1, 0, c_white, 1);
}
