event_inherited();

// Handle Interrupting Original Transition
if (cutscene_timer < INTERRUPTION_FRAME/4) {
	with (obj_player) {
		if (transition_timer == 0 && is_ladder_state() && y <= room_height - (GRID_SIZE*3)) { grid_move_down_direct(GRID_SIZE); }
	}
}

if (cutscene_timer == INTERRUPTION_FRAME) {
	with (obj_world_transition_manager) { instance_destroy(); }
	audio_stop_sound(bgm_mdb_transition);
	audio_stop_sound(bgm_old_transition);
	play_global_sound(snd_explosion);
	global.controller.start_screen_shake();
	with (obj_player) {
		transition_timer = 0;
		x_transition_timer = 0;
		y_transition_timer = 0;
		is_left = true;
		start_hopping(true);
	}
	with (obj_saucer) {
		var _part_x = x + sprite_get_width(sprite_index)/2, _part_y = y + sprite_get_height(sprite_index);
		vspeed = -4;
		create_particles(16, PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW, _part_x, _part_y);
		create_particles(8, PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW, _part_x - 16, y + _part_y);
		create_particles(8, PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW, _part_x + 16, y + _part_y);
	}
}

// Handle Cutscene Post-Interrupt
if (text_pos_timer > 0 && cutscene_timer > INTERRUPTION_FRAME) {
	if (text_pos_timer >= next_text_trigger && text_pos < array_length(text_box_strings)) {
		text_pos_timer = 0;
		next_text_trigger += DISPLAY_TIME + text_time;
		text_pos += 1;
	}
	else { text_pos_timer++; }

	actor = (text_pos == 10 || text_pos == 11 || text_pos == 9 || text_pos == 14) ? 1 : 0;
	
	with (obj_player) { reset_controls(); }
	with (obj_saucer) { vspeed -= 0.5; }
}