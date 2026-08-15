event_inherited();
audio_stop_sound(bgm_mdb_w1);
audio_stop_sound(bgm_old_w1);

if (y > 1536 || get_restart_released() || get_jump_released()) {
	audio_stop_sound(bgm_mdb_cutscene);
	global.controller.transition_room(room_next(room));
}

if (global.controller.transition_timer == 0) {
	vspeed = 1;
	if (get_down_held() || get_right_held()) { vspeed = 2; }
	else if (get_up_held() || get_left_held()) { vspeed = 0; }
}