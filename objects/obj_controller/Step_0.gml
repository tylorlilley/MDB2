if (instance_number(obj_player) == 0 && transition_timer == 0) { transition_timer = 1; target_room = room; }
else if (transition_timer > 0) {
	transition_timer++;
	
	if (transition_timer == transition_delay) { play_sound(snd_fade_out); }
	else if (transition_timer == transition_duration + transition_hold + transition_delay) { transition_room(target_room); play_sound(snd_fade_in); }
	else if (transition_timer >= (transition_duration * 2) + transition_hold + transition_delay) { transition_timer = 0; } //audio_play_sound(snd_bgm_w1, 100, true); } // TODO: Vary by level
}