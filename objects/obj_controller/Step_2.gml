// Play All Sounds in Sound Buffer
if (transition_timer <= TRANSITION_DELAY || transition_timer >= (TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD)) {
	while (array_length(frame_sounds) > 0) {
		var _entry = array_pop(frame_sounds);
		var _avg_x = _entry.x_sum / _entry.plays;
		audio_play_sound_panned(_entry.snd, _avg_x);
	}
}
else { frame_sounds = []; }

// Do Screen Resize
if (screen_resize_timer > 0) {
	screen_resize_timer--;
	if (screen_resize_timer == 0) {
		if (window_fullscreen_pending) { update_window_fullscreen(); }
		else { update_window_size(); }
	}
}

// Do Screenshake
var _screen_x = 8, _screen_y =  8, _cam = view_camera[0];
if (screen_shake_timer > 0) {
	screen_shake_timer--;
	if (screen_shake_timer > 0) {
		_screen_x += get_shake_value(screen_shake_timer);
		_screen_y += get_shake_value(screen_shake_timer);
	}
	camera_set_view_pos(_cam, _screen_x, _screen_y);
}
