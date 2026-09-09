if (debug_enabled && room_world == WORLDS.BEACH) {
	audio_stop_all();
	latest_quip = "";
	transition_room(room_next(room));
}