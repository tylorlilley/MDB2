cutscene_timer++;

// TODO: Don't read these from player, read them itself
with (obj_player) {
	update_controls();
	other.key_right = key_right;
	other.key_left = key_left;
	other.key_up = key_up;
	other.key_down = key_down;
	reset_controls();
	
	if (other.cutscene_timer > 8) {
		key_right = true;
		key_up = (state != PLAYER_STATES.WIN || (other.cutscene_timer > other.cutscene_timer_max && transition_timer == 0));
	}
}

// Set Jump and Restart Based on Release Only
key_jump =  (keyboard_check_released(ord("Z")) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_face1) || gamepad_button_check_released(global.gamepad, gp_face2) || gamepad_button_check_released(global.gamepad, gp_face3) || gamepad_button_check_released(global.gamepad, gp_face4))));
key_restart = (keyboard_check_released(ord("R")) || keyboard_check_released(vk_enter) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_start) || gamepad_button_check_released(global.gamepad, gp_select))));
