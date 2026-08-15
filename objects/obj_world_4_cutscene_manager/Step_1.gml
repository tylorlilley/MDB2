event_inherited();

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
		is_left = true;
		start_hopping(true);
		is_left = false;
		sprite_index = spr_particle_player_dying;
		cape_sprite = spr_cape_crushed;
		cape_image_index = 0;
	}
}

if (cutscene_timer >= INTERRUPTION_FRAME) {
	with (obj_player) {
		reset_controls();
		var _image_index = image_index;
		sprite_index = spr_particle_player_dying;
		image_index = _image_index;
		cape_sprite = spr_cape_crushed;
		cape_image_index = 0;
	}
}