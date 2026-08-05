event_inherited();
audio_stop_sound(bgm_transition)
with (obj_player) {
	key_right = false;
	sprite_index = spr_player_walk;
	image_index = 1;
	if (cape_state != CAPE_STATES.FLUTTER) { start_cape_flutter(); }
}