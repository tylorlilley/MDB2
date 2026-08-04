stop_music();
transition_timer++;
if (transition_timer == 24) { audio_play_sound(bgm_transition, 100, false); }

with (obj_player) {
	//update_controls = function (_arg) { };
	is_left = false;
	//can_be_controlled = false;
	if (other.transition_timer > 8) {
		key_right = true;
		key_up = (state != PLAYER_STATES.WIN || (other.transition_timer > other.transition_max && transition_timer == 0));
	}
}