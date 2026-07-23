// Play All Sounds in Sound Buffer
while (array_length(frame_sounds) > 0) {
	var _snd = array_pop(frame_sounds);
	audio_play_sound(_snd, 1, false);
}

// Do Screenshake
var _screen_x = 8, _screen_y =  8, _cam = view_camera[0];
if (screen_timer > 0) {
	_screen_x = 8 + (irandom(1 + (screen_timer div 2)) * ((irandom(1) == 0) ? -1 : 1));
	_screen_y = 8 + (irandom(1 + (screen_timer div 2)) * ((irandom(1) == 0) ? -1 : 1));
	screen_timer--;
}
camera_set_view_pos(_cam, _screen_x, _screen_y);