player_state_string = player_state_to_string(state);
player_timer_string = "";

switch (state) {
	case PLAYER_STATES.CROUCH: { player_timer_string = string(crouch_timer); break; }
	case PLAYER_STATES.POWERCROUCH: { player_timer_string = string(crouch_timer); break; }
	case PLAYER_STATES.FLY: { player_timer_string = string(fly_timer); break; }
	case PLAYER_STATES.POWERFLY: { player_timer_string = string(fly_timer); break; }
	case PLAYER_STATES.FALL: { player_timer_string = string(fall_timer); break; }
	case PLAYER_STATES.POWERFALL: { player_timer_string = string(fall_timer); break; }
	case PLAYER_STATES.RECOIL: { player_timer_string = string(recoil_timer); break; }
	case PLAYER_STATES.SWIM: { player_timer_string = string(swim_timer); break; }
	case PLAYER_STATES.SWIM_FORWARD: { player_timer_string = string(swim_timer); break; }
}
draw_set_font(ft_teko);
draw_set_color(c_white);
draw_text(4, room_height-32, "Player State: " + player_state_string + " " + player_timer_string);
draw_text(4, room_height-20, "Tranistion: " + string(transition_timer));

draw_text(
	room_width-56,
	room_height-20,
	((key_up) ? "U" : "_") +
	((key_right) ? "R" : "_") +
	((key_down) ? "D" : "_") +
	((key_left) ? "L" : "_") +
	((key_jump) ? "J" : "_")
);