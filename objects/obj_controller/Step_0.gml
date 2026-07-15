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
		var _x_speed = (x_transition_timer == 0) ? 0 : (_x_diff div x_transition_timer);
		var _y_speed = (y_transition_timer == 0) ? 0 : (_y_diff div y_transition_timer);
		if (_x_speed != 0) { virtual_x += _x_speed; }
		if (_y_speed != 0) { virtual_y += _y_speed; }
		
		// Update Transition Timers Based on Remaining Transition Time
		if (x_transition_timer > 0) { x_transition_timer--; }
		if (y_transition_timer > 0) { y_transition_timer-- }
		var _new_transition_timer = 0;
		if (x_transition_timer > 0 && y_transition_timer > 0) { _new_transition_timer = min(x_transition_timer, y_transition_timer); }
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
	anim_timer = anim_timer % (8 * 8);
}
with (obj_switch) {
	var _pressed_on = array_length(get_pressing_objects()) > 0

	if (_pressed_on && !pressed) {
		var _toggle_blocks = true;
		with (obj_switch) {
			if (id != other.id && switch_color == other.switch_color && array_length(get_pressing_objects()) > 0) { _toggle_blocks = false; }
		}
	
		if (_toggle_blocks) {
			with (obj_switch_block) { 
				if (switch_color == other.switch_color) { toggle_solid(true); }
			}
			with (obj_switch) { if (switch_color == other.switch_color) { pressed = !pressed; } }
		}
	}

	image_index = (pressed || _pressed_on) ? 1 : 0;
}
with (obj_key) {
	shine_periodically();
}
with (obj_door) {
	if (image_index == 0) {
		shine_periodically();

		if (global.controller.room_keys == 0) {
			create_particles(8 + irandom(8), particle_color);
			create_sparkles(8 + irandom(8));
			particle_color = make_color_rgb(136, 112, 0);
			image_index = 1;
			play_sound(snd_door_open);
			play_sound(snd_explosion);
		}
	}
}
with (obj_spawner) {
	timer--;
	if timer <= 0 {
		var _inst = instance_create_depth(x, y, depth, spawned_obj);
		_inst.is_left = is_left;
	    timer = frequency;
	}
}

// Game Object End Step
with (obj_player) {
	if ((x + sprite_get_width(sprite_index) <= 0) || (x >= room_width) || (y >= room_height) || (y + sprite_get_height(sprite_index) <= 0)) { 
		ring_out_timer++;
	}
	else { ring_out_timer = 0; }

	if (ring_out_timer == 8) { if (can_be_controlled) { play_sound(snd_player_offscreen); } }
	else if (ring_out_timer == 40) { instance_destroy(); }
}

// Handle Transition Code
var _controllable_player_exists = false;
with (obj_player) { if (can_be_controlled) { _controllable_player_exists = true; } }

if (!_controllable_player_exists && transition_timer == 0) { transition_timer = 1; }
else if (transition_timer > 0) {
	transition_timer++;
	
	if (transition_timer == transition_delay) { play_sound(snd_fade_out); }
	else if (transition_timer == transition_duration + transition_hold + transition_delay) { 
		if (!_controllable_player_exists) { reset_room(); }
		else { transition_room(room_next(room)); }
		play_sound(snd_fade_in);
	}
	else if (transition_timer >= (transition_duration * 2) + transition_hold + transition_delay) { transition_timer = 0; surface_free(transition_surface); } //audio_play_sound(snd_bgm_w1, 100, true); } // TODO: Vary by level
}