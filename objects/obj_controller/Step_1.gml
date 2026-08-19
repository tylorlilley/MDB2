// Poll for Gamepad
determine_gamepad();

// Handle Game Pause
if (!is_cutscene_room() || room == rm_how_to_play || room == rm_title) {
	if (paused) {
		if (get_restart_released()) {
			// Quit Game
			if (room == rm_title) { game_end(); }
			// Return to Title
			else {
				paused = false;
				audio_stop_all();
				play_global_sound(snd_key);
				return_to_title();
			}
		}
		else if (get_jump_released() || get_pause_released() || get_up_released() || get_down_released() || get_left_released() || get_right_released()) {
			// Unpause the Game
			paused = false;
			audio_resume_all();
			audio_stop_sound(snd_pause);
			play_global_sound(snd_unpause);
		}
	}
	else if (get_pause_released()) {
		// Pause the Game
		paused = true;
		
		audio_stop_sound(snd_unpause);
		audio_pause_all();
		play_global_sound(snd_pause);
	}
}
