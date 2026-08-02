#macro SOUND_PAN_STRENGTH  0.8  // 1 = hard pan at room edges
#macro SOUND_PAN_MAX_ANGLE 30   // degrees off-centre the spatialiser treats as hard L/R
#macro SOUND_PAN_RADIUS    100  // fixed listener->source distance

function play_sound(_snd_index, _sound_x = x) {
	var _queue = global.controller.frame_sounds;
	var _len = array_length(_queue);
	for (var _i = 0; _i < _len; _i++) {
		var _entry = _queue[_i];
		if (_entry.snd == _snd_index) {
			_entry.x_sum += _sound_x;
			_entry.plays++;
			return false;
		}
	}
	array_push(_queue, { snd: _snd_index, x_sum: _sound_x, plays: 1 });
	return true;
}

function stop_music() {
	audio_stop_sound(bgm_w1);
	audio_stop_sound(bgm_w2);
	audio_stop_sound(bgm_w3);
	audio_stop_sound(bgm_w4);
	audio_stop_sound(bgm_w5);
	audio_stop_sound(snd_player_fall);
	audio_stop_sound(snd_player_takeoff);
}