event_inherited();

if (cutscene_timer == 24 && room == rm_intro_eih) { instance_create(-24, SCREEN_MIDDLE_Y, obj_eih); }
if (cutscene_timer == 40 && room == rm_intro) { instance_create(SCREEN_MIDDLE_X, -16, obj_player); }

with (obj_player) {
	key_right = false;
	if (room == rm_intro) { win_loops = 1; }
	if (state == PLAYER_STATES.WIN && image_index == 3) { 
		if (!audio_is_playing(bgm_title)) { play_global_sound(bgm_title, true); }
	}
}
with (obj_sand) { creator = other.id; }

if (key_jump || key_restart) {
	if (!audio_is_playing(bgm_title)) { play_global_sound(bgm_title, true); }
	global.controller.transition_room(room_next(room));
}
	