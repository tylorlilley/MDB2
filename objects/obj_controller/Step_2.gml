// Play All Sounds in Sound Buffer
while (array_length(frame_sounds) > 0) {
	var _entry = array_pop(frame_sounds);
	var _avg_x = _entry.x_sum / _entry.plays;
	var _pan = ((clamp(_avg_x, 0, room_width) / room_width) * 2 - 1) * SOUND_PAN_STRENGTH;
	var _ang = _pan * SOUND_PAN_MAX_ANGLE;
	audio_play_sound_at(_entry.snd, dsin(_ang) * SOUND_PAN_RADIUS, dcos(_ang) * SOUND_PAN_RADIUS, 0, SOUND_PAN_RADIUS, SOUND_PAN_RADIUS, 1, false, 1);
}

// Do Screenshake
var _screen_x = 8, _screen_y =  8, _cam = view_camera[0];
if (screen_shake_timer > 0) {
	_screen_x = 8 + (irandom(1 + (screen_shake_timer div 2)) * ((irandom(1) == 0) ? -1 : 1));
	_screen_y = 8 + (irandom(1 + (screen_shake_timer div 2)) * ((irandom(1) == 0) ? -1 : 1));
	screen_shake_timer--;
}
camera_set_view_pos(_cam, _screen_x, _screen_y);