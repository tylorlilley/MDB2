if (debug_enabled && room_world == WORLDS.FOREST) {
	audio_stop_all();
	transition_room(room_next(room));
}