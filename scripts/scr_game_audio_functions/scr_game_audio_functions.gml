#macro SOUND_PAN_STRENGTH  0.8  // 1 = hard pan at room edges
#macro SOUND_PAN_MAX_ANGLE 30   // degrees off-centre the spatialiser treats as hard L/R
#macro SOUND_PAN_RADIUS    100  // fixed listener->source distance

function audio_play_sound_panned(_snd, _x) {
	var _pan = ((clamp(_x, 0, room_width) / room_width) * 2 - 1) * SOUND_PAN_STRENGTH;
	var _ang = _pan * SOUND_PAN_MAX_ANGLE;
	return audio_play_sound_at(_snd, dsin(_ang) * SOUND_PAN_RADIUS, dcos(_ang) * SOUND_PAN_RADIUS, 0, SOUND_PAN_RADIUS, SOUND_PAN_RADIUS, 1, false, 1);
}

function play_sound(_snd_index, _sound_x = x) {
	if (is_undefined(_snd_index)) { return false; }
	
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

function play_global_sound(_snd_index, _should_loop = false) {
	if (is_undefined(_snd_index)) { return false; }
	
	audio_play_sound(_snd_index, 0, _should_loop)
}

function stop_sound(_snd_index) {
	if (is_undefined(_snd_index)) { return false; }
	
	audio_stop_sound(_snd_index);
	return true;
}