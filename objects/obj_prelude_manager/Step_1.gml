event_inherited();
audio_stop_sound(bgm_mdb_w1);
audio_stop_sound(bgm_old_w1);

if (y > 1536 || key_restart || key_jump) {
	audio_stop_sound(bgm_mdb_cutscene);
	global.controller.transition_room(room_next(room));
}

if (global.controller.transition_timer == 0) {
	vspeed = 1;
	if (key_down || key_right) { vspeed = 2; }
	else if (key_up || key_left) { vspeed = 0.5; }
}