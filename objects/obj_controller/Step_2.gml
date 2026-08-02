// Play All Sounds in Sound Buffer
while (array_length(frame_sounds) > 0) {
	var _entry = array_pop(frame_sounds);
	var _avg_x = _entry.x_sum / _entry.plays;
	audio_play_sound_panned(_entry.snd, _avg_x);
}

// Do Screenshake
var _screen_x = 8, _screen_y =  8, _cam = view_camera[0];
if (screen_shake_timer > 0) {
	_screen_x = 8 + (irandom(1 + (screen_shake_timer div 2)) * ((irandom(1) == 0) ? -1 : 1));
	_screen_y = 8 + (irandom(1 + (screen_shake_timer div 2)) * ((irandom(1) == 0) ? -1 : 1));
	screen_shake_timer--;
}
camera_set_view_pos(_cam, _screen_x, _screen_y);