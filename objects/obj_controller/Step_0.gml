// Handle Dynamic Game Object Step
var _dynamic_instances = [];

with (obj_dynamic_object) { array_push(_dynamic_instances, id); }
array_sort(_dynamic_instances, function(_a, _b) {
    return sign(_b.y - _a.y);
});
for (var _i = 0; _i < array_length(_dynamic_instances); _i++) {
    var _inst = _dynamic_instances[_i];
    if (instance_exists(_inst)) { _inst.game_object_step(); }
}
for (var _i = 0; _i < array_length(_dynamic_instances); _i++) {
    var _inst = _dynamic_instances[_i];
	with(_inst) {
		// Update Swim Timer for Visual Bob
		swim_timer = swim_timer % FLOAT_OFFSET_PERIOD_FRAMES;
	
		// Update Virtual X and Y Positions Based on new Actual Positions
		var _x_diff = (x - virtual_x), _y_diff = (y - virtual_y);
		var _x_speed = (x_transition_timer == 0) ? 0 : (_x_diff / x_transition_timer);
		var _y_speed = (y_transition_timer == 0) ? 0 : (_y_diff / y_transition_timer);
		if (!is_undefined(y_transition_speed)) { _y_speed = y_transition_speed; }
		if (!is_undefined(x_transition_speed)) { _x_speed = x_transition_speed; }
		if (abs(_x_speed) > 0 && abs(_x_speed) < 1) { _x_speed = (x_transition_timer % 2 == 0) ? sign(_x_speed) : 0; }
		if (abs(_y_speed) > 0 && abs(_y_speed) < 1) { _y_speed = (y_transition_timer % 2 == 0) ?  sign(_y_speed) : 0; }
		virtual_x += _x_speed;
		virtual_y += _y_speed;
		
		// Update Transition Timers Based on Remaining Transition Time
		if (transition_timer > 0) { transition_timer--; }
		if (x_transition_timer > 0) { x_transition_timer--; }
		if (y_transition_timer > 0) { y_transition_timer-- }
		var _new_transition_timer = 0;
		if (x_transition_timer > 0 && y_transition_timer > 0) { _new_transition_timer = max(x_transition_timer, y_transition_timer); }
		else if (x_transition_timer > 0) { _new_transition_timer = x_transition_timer; }
		else if (y_transition_timer > 0) { _new_transition_timer = y_transition_timer; }
		transition_timer = max(transition_timer, _new_transition_timer);
	}
}

// Handle Static Object Step
with (obj_dynamic_object) {
	if (is_carrying_key()) { shine_periodically(); }
}
with (obj_water) {
	anim_timer++;
	anim_timer = anim_timer % (8 * 8);
}
with (obj_lava) {
	anim_timer++;
	anim_timer = anim_timer % (sprite_get_number(outline_sprite) * 8);
	global.should_rebuild_static_area = true;
}
with (obj_spikes) {
	if (shine_timer > 0) { shine_timer--; }
	if (shine_timer == 0) { image_index = 0; }
}

// Update Switch Logic
blocked_switch_colors = [false, false, false];
with (obj_switch) {
	prev_pressed = pressed;
	if (!is_fully_on_ground()) { instance_destroy(); }
	else {
		var _pressed_on = array_length(get_pressing_objects()) > 0;
		if (_pressed_on && !pressed) { press_switch(); }
	}
}
// Update Switch Graphics and Sound
with (obj_switch) {
	if (global.controller.blocked_switch_colors[switch_color]) { if (image_index != 1) { play_sound(snd_soft_thud); } image_index = 1; }
	else if (pressed) { if (!prev_pressed) { play_sound(snd_switch); } image_index = 2; }
	else if (!prev_pressed && image_index != 0) { play_sound(snd_soft_thud); image_index = 0; }
}
with (obj_key) { shine_periodically(); }
with (obj_door) {
	if (!is_fully_on_ground()) { instance_destroy(); }
	if (image_index == 0) {
		shine_periodically();
		
		if (global.room_keys == global.keys_collected) {
			create_particles(8 + irandom(8), PARTICLE_TYPES.DEBRIS, PALETTES.YELLOW_DARK);
			create_particles(8 + irandom(8), PARTICLE_TYPES.SPARKLE, PALETTES.GRAY_LIGHT);
			image_index = 1;
			play_sound(snd_door_unlock);
			global.controller.start_screen_shake();
		}
	}
}
with (obj_spawner) {
	timer--;
	if timer <= 0 {
		var _inst = instance_create(x, y, spawned_obj);
		_inst.is_left = is_left;
	    timer = frequency;
	}
}
with (obj_reforming_cloud_outline) {
	if (reform_timer > 0) {
		reform_timer--;
		if (reform_timer == 0) { create_cloud(); }
	}
	image_index = 0;
	if (reform_timer > 60) { image_index = 1; }
	if (reform_timer <= 60 && reform_timer > 45) { image_index = 2;}
	if (reform_timer <= 45 && reform_timer > 30) { image_index = 3;}
	if (reform_timer <= 30 && reform_timer > 15) { image_index = 4;}
	if (reform_timer <= 15 && reform_timer > 0) { image_index = 5;}
	if (reform_timer == 0) { image_index = 0;}
}
frame_timer++;
frame_timer = frame_timer % 24;
with (obj_portal) {
	// Determine Activated State
	if (!instance_exists(linked_portal)) { activated = false; }
	else if (activation_timer > 0) { activated = false;  activation_timer--; } // TODO: Turn off when one portal is inside a solid like crate?
	else if (is_blocked() || linked_portal.is_blocked()) { activated = false; }
	else { activated = true; } // image_blend = get_portal_color(portal_color);
	
	// Determine Visual Speed
	var _portal_speed = 4, _is_overlapped = (is_overlapped() || (instance_exists(linked_portal) && linked_portal.is_overlapped()));
	if (_is_overlapped) { _portal_speed = 2; }
	
	// Set Palette and Animation Speed
	main_palette = (activated) ? ((masked) ? PALETTES.INDIGO_DARK : original_palette) : PALETTES.GRAY;
	image_alpha = (activated) ? ((_is_overlapped) ? 1 : 0.8) : 0.5;
	
	// Animate Portal
	image_index = other.frame_timer / _portal_speed;
}

// Game Object End Step
with (obj_player) {
	if ((x + sprite_get_width(sprite_index) <= 0) || (x >= room_width) || (y >= room_height) || (y + sprite_get_height(sprite_index) <= 0 && !is_a(obj_robot))) { 
		ring_out_timer++;
	}
	else { ring_out_timer = 0; }

	if (ring_out_timer == 8) { if (can_be_controlled) { play_sound(snd_player_offscreen); } }
	else if (ring_out_timer == 40) { instance_destroy(); }
}

with (obj_dynamic_object) { update_virtual_y_offset(); }

// Handle Transition Code
var _controllable_player_exists = false;
with (obj_player) { if (can_be_controlled) { _controllable_player_exists = true; } }

if (!_controllable_player_exists && transition_timer == 0) { transition_timer = 1; }
else if (transition_timer > 0) {
	transition_timer++;
	
	if (transition_timer == TRANSITION_DELAY) { play_sound(snd_fade_out); }
	else if (transition_timer == TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD) { 
		if (!_controllable_player_exists) { reset_room(); }
		else { transition_room(room_next(room), true); }
		play_sound(snd_fade_in);
	}
	else if (transition_timer >= (TRANSITION_DURATION * 2) + TRANSITION_HOLD + TRANSITION_DELAY) { transition_timer = 0; surface_free(transition_surface); } //audio_play_sound(snd_bgm_w1, 100, true); } // TODO: Vary by level
}