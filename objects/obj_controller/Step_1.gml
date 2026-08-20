// Poll for Gamepad
determine_gamepad();

// Update Framerate
var _fast_forward_button_held = (keyboard_check(vk_shift) || gamepad_button_check(global.gamepad, gp_shoulderl) || gamepad_button_check(global.gamepad, gp_shoulderr) || gamepad_button_check(global.gamepad, gp_shoulderlb) || gamepad_button_check(global.gamepad, gp_shoulderrb));
fast_forward_enabled = (_fast_forward_button_held && !paused && window_fps_setting >= 60);
var _new_logical_fps = (fast_forward_enabled) ? 60 : 30;
if (_new_logical_fps != logical_fps) {
	var _old_ratio = fps_ratio;
	logical_fps = _new_logical_fps;
	fps_ratio = max(1, (window_fps_setting div logical_fps));
	fps_timer = 0;
	recalculate_engine_speeds(fps_ratio/_old_ratio);
}

// Handle Game Pause
if (unpausing) {
	if (pause_timer > 0) {
		pause_timer--;
		if (pause_timer <= 0) {
			// Unpause Game
			paused = false;
			unpausing = false;
			pause_timer = 0;
			audio_resume_all();
			
			// Unpause Built in Motion
			with (obj_particle) {
				hspeed = paused_hspeed;
				vspeed = paused_vspeed;
				gravity = paused_gravity;
				image_speed = paused_image_speed;
			}
			
			// Unpause Built in Background Motion
			for (var _i = 0; _i < array_length(paused_layers); _i++) {
				var _paused_layer = paused_layers[_i];
				if (!layer_exists(_paused_layer.layer_id)) { continue; }
				
				layer_hspeed(_paused_layer.layer_id, _paused_layer.h_speed);
				layer_vspeed(_paused_layer.layer_id, _paused_layer.v_speed);
				for (var _j = 0; _j < array_length(_paused_layer.backgrounds); _j++) {
					layer_background_speed(_paused_layer.backgrounds[_j].element, _paused_layer.backgrounds[_j].img_speed);
				}
			}
			paused_layers = [];
		}
	}
}
else {
	if (paused && pause_timer <= (32 * fps_ratio)) { pause_timer ++; }
	if (room != rm_controller && (!is_cutscene_room() || room == rm_how_to_play || room == rm_title)) {
		if (paused) {
			if (get_restart_released()) {
				// Quit Game
				if (room == rm_title) { game_end(); }
				// Return to Title
				else {
					pause_timer = 0;
					paused = false;
					unpausing = false;
					paused_layers = [];
					return_to_title();
					play_global_sound(snd_explosion);
				}
			}
			else if (get_jump_released() || get_pause_released() || get_up_released() || get_down_released() || get_left_released() || get_right_released()) {
				unpausing = true;
				pause_timer = min(pause_timer, 8 * fps_ratio);
				audio_stop_sound(snd_pause);
				audio_play_sound(snd_unpause, 0, false);
			}
		}
		else if (get_pause_released()) {
			// Pause the Game
			paused = true;
		
			audio_pause_all();
			audio_stop_sound(snd_unpause);
			audio_play_sound(snd_pause, 0, false);
		
			// Pause Built in Motion
			with (obj_particle) {
				paused_hspeed = hspeed;
				hspeed = 0;
				paused_vspeed = vspeed;
				vspeed = 0;
				paused_gravity = gravity;
				gravity = 0;
				paused_image_speed = image_speed;
				image_speed = 0;
			}
		
			// Pause Built in Background Motion
			paused_layers = [];
			var _layers = layer_get_all();
			for (var _i = 0; _i < array_length(_layers); _i++) {
				var _layer = _layers[_i], _backgrounds = [], _elements = layer_get_all_elements(_layer);
				for (var _j = 0; _j < array_length(_elements); _j++) {
					var _element = _elements[_j];
					if (layer_get_element_type(_element) != layerelementtype_background) { continue; }
					array_push(_backgrounds, { element: _element, img_speed: layer_background_get_speed(_element) });
					layer_background_speed(_element, 0);
				}
				array_push(paused_layers, { layer_id: _layer, h_speed: layer_get_hspeed(_layer), v_speed: layer_get_vspeed(_layer), backgrounds: _backgrounds });
				layer_hspeed(_layer, 0);
				layer_vspeed(_layer, 0);
			}
		}
	}
}
	