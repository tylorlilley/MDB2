event_inherited();
audio_stop_sound(bgm_transition)
if (transition_timer == 24 && room == rm_intro_eih) { instance_create(-24, SCREEN_MIDDLE_Y, obj_eih); }
if (transition_timer == 40 && room == rm_intro) { instance_create(SCREEN_MIDDLE_X, -16, obj_player); }

with (obj_player) {
	key_right = false;
	if (state == PLAYER_STATES.WIN && image_index == 3 && other.bgm == noone) { other.bgm = audio_play_sound(bgm_title, 100, true); }
}
with (obj_sand) { creator = other.id; }