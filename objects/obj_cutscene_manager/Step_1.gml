cutscene_timer++;

with (obj_player) {
	// Replace Real With Scripted Input for Player
	reset_controls();
	if (other.cutscene_timer > 8) {
		key_right = true;
		key_up = (state != PLAYER_STATES.WIN || (other.cutscene_timer > other.cutscene_timer_max && transition_timer == 0));
	}
}

// Set Jump and Restart Based on Release Only
gamepad_h_axis_value = 0;
gamepad_v_axis_value = 0;

key_left = keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(global.gamepad, gp_padl);
key_right = keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(global.gamepad, gp_padr);
key_up = keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(global.gamepad, gp_padu);
key_down = keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(global.gamepad, gp_padd);
key_jump = keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(global.gamepad, gp_face1) || gamepad_button_check_pressed(global.gamepad, gp_face2) || gamepad_button_check_pressed(global.gamepad, gp_face3) || gamepad_button_check_pressed(global.gamepad, gp_face4);
key_restart = keyboard_check_pressed(ord("R")) || keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(global.gamepad, gp_start) || gamepad_button_check_pressed(global.gamepad, gp_select);

if (abs(gamepad_axis_value(global.gamepad, gp_axislh)) > 0.5 && gamepad_h_axis_value == 0) {
	gamepad_h_axis_value = gamepad_axis_value(global.gamepad, gp_axislh);
	key_left = (sign(gamepad_h_axis_value) == -1);
	key_right = (sign(gamepad_h_axis_value) == 1);
}
else if (abs(gamepad_axis_value(global.gamepad, gp_axislh)) == 0) { gamepad_h_axis_value = 0; }

if (abs(gamepad_axis_value(global.gamepad, gp_axislv)) > 0.5 && gamepad_v_axis_value == 0) {
	gamepad_v_axis_value = gamepad_axis_value(global.gamepad, gp_axislv);
	key_up = (sign(gamepad_v_axis_value) == -1);
	key_down = (sign(gamepad_v_axis_value) == 1);
}
else if (abs(gamepad_axis_value(global.gamepad, gp_axislv)) == 0) { gamepad_v_axis_value = 0; }
