event_inherited();
audio_stop_sound(bgm_transition)
if (transition_timer == 24 && room == rm_intro_eih) { instance_create(-24, SCREEN_MIDDLE_Y, obj_eih); }
if (transition_timer == 40 && room == rm_intro) { instance_create(SCREEN_MIDDLE_X, -16, obj_player); }

with (obj_player) {
	key_right = false;
	if (state == PLAYER_STATES.WIN && image_index == 3 && other.bgm == noone) { other.bgm = audio_play_sound(bgm_title, 100, true); }
}

if (instance_number(obj_sand) == 0 && !made_particles) {
	made_particles = true;
	var _intro_string_length =  114; //string_width(intro_string)
	for (var _y_pos = SCREEN_MIDDLE_Y; _y_pos <= SCREEN_MIDDLE_X; _y_pos += 8) {
		for (var _x_pos = SCREEN_MIDDLE_X - _intro_string_length/2;_x_pos < SCREEN_MIDDLE_X + _intro_string_length/2; _x_pos += 8) {
			create_particles(irandom(2), PARTICLE_TYPES.DEBRIS, PALETTES.ALL_WHITE, _x_pos, _y_pos);
		}
	}
}