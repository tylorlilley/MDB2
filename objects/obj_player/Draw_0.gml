var _cape_x = virtual_x, _cape_y = virtual_y;

if (state != PLAYER_STATES.LADDER &&
	state !=  PLAYER_STATES.LADDER_UP &&
	state != PLAYER_STATES.LADDER_DOWN &&
	state != PLAYER_STATES.FALL &&
	state != PLAYER_STATES.POWERFALL &&
	state != PLAYER_STATES.FLY &&
	state != PLAYER_STATES.POWERFLY) {
	_cape_x += ((is_left) ? 8 : -8);
}

var _x_offset = (is_left) ? sprite_width : 0;
if (cape_depth <= depth) {
	draw_sprite_ext(sprite_index, image_index, virtual_x-_x_offset, virtual_y, image_xscale, 1, 0, image_blend, 1);
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x-_x_offset, _cape_y, image_xscale, 1, 0, c_white, 1);
}
else {
	draw_sprite_ext(cape_sprite_index, cape_image_index, _cape_x-_x_offset, _cape_y, image_xscale, 1, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, virtual_x-_x_offset, virtual_y, image_xscale, 1, 0, c_white, 1);
}
//draw_sprite_ext(spr_box, 0, virtual_x, virtual_y, 1, 1, 0, c_red, 0.5);

player_state_string = player_state_to_string(state);
player_timer_string = "";

switch (state) {
	case PLAYER_STATES.CROUCH: { player_timer_string = string(crouch_timer); break; }
	case PLAYER_STATES.POWERCROUCH: { player_timer_string = string(crouch_timer); break; }
	case PLAYER_STATES.FLY: { player_timer_string = string(fly_timer); break; }
	case PLAYER_STATES.POWERFLY: { player_timer_string = string(fly_timer); break; }
	case PLAYER_STATES.FALL: { player_timer_string = string(fall_timer); break; }
	case PLAYER_STATES.POWERFALL: { player_timer_string = string(fall_timer); break; }
}
draw_set_font(ft_teko);
draw_set_color(c_black);
draw_text(4, 4, "Player State: " + player_state_string + " " + player_timer_string);
draw_text(4, room_height-20, "Tranistion: " + string(transition_timer));

draw_text(
	room_width-40,
	room_height-12,
	((key_up) ? "U" : "_") +
	((key_right) ? "R" : "_") +
	((key_down) ? "D" : "_") +
	((key_left) ? "L" : "_") +
	((key_jump) ? "J" : "_")
);