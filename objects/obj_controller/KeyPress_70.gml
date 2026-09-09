if (debug_enabled && room_world == WORLDS.FOREST) {
	audio_stop_all();
	latest_quip = "";
	transition_room(room_next(room));
}