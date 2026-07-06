// Play All Sounds in Sound Buffer
while (array_length(frame_sounds) > 0) {
	var _snd = array_pop(frame_sounds);
	audio_play_sound(_snd, 1, false);
}
