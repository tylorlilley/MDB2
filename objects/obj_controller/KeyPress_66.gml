if (debug_enabled && room_world == WORLDS.BEACH) {
	audio_stop_all();
	transition_room(room_next(room));
}