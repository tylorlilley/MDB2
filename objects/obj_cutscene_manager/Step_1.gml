if (!global.controller.paused) { update_controls(); }

if (!global.controller.is_logic_frame()) { exit; }

cutscene_timer++;

with (obj_player) {
	// Replace Real With Scripted Input for Player
	reset_controls();
	if (other.cutscene_timer > 8) {
		key_right = true;
		key_up = (state != PLAYER_STATES.WIN || (other.cutscene_timer > other.cutscene_timer_max && transition_timer == 0));
	}
}