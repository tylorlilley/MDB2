function play_sound(_snd_index) {
	if (!array_contains(global.controller.frame_sounds, _snd_index)) {
		array_push(global.controller.frame_sounds, _snd_index);
		return true;
	}
	else { return false; }
}

function stop_music() {
	audio_stop_sound(bgm_w1);
	audio_stop_sound(snd_player_takeoff);
}