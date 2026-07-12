// Handle Dynamic Game Object Step
var _dynamic_instances = [];

with (obj_dynamic_object) {
	//carried_objects = get_carried_objects();
	//if (transition_timer == 0) { virtual_x = x; virtual_y = y; }
}
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
		// Update Virtual X and Y Positions Based on new Actual Positions
		var _x_diff = (x - virtual_x), _y_diff = (y - virtual_y);
		var _x_speed = (x_transition_timer == 0) ? 0 : (_x_diff div x_transition_timer);
		var _y_speed = (y_transition_timer == 0) ? 0 : (_y_diff div y_transition_timer);
		if (_x_speed != 0) { virtual_x += _x_speed; }
		if (_y_speed != 0) { virtual_y += _y_speed; }
		
		// Update Transition Timers Based on Remaining Transition Time
		if (x_transition_timer > 0) { x_transition_timer--; }
		if (y_transition_timer > 0) { y_transition_timer-- }
		if (x_transition_timer > 0 && y_transition_timer > 0) { transition_timer = min(x_transition_timer, y_transition_timer); }
		else if (x_transition_timer > 0) { transition_timer = x_transition_timer; }
		else if (y_transition_timer > 0) { transition_timer = y_transition_timer; }
	}
}

// Handle Static Object Step
with (obj_water) {
	anim_timer++;
	anim_timer = anim_timer % (8 * 8);
}
with (obj_switch) {
	event_inherited();

	var _pressed_on = array_length(get_pressing_objects()) > 0

	if (_pressed_on && !pressed) {
		var _toggle_blocks = true;
		with (obj_switch) {
			if (id != other.id && image_blend == other.image_blend && array_length(get_pressing_objects()) > 0) { _toggle_blocks = false; }
		}
	
		if (_toggle_blocks) {
			with (obj_switch_block) { 
				if (image_blend == other.image_blend) { toggle_solid(true); }
			}
			with (obj_switch) { if (image_blend == other.image_blend) { pressed = !pressed; } }
		}
	}

	image_index = (pressed || _pressed_on) ? 1 : 0;

	if (!is_grounded()) { instance_destroy(); }
}
with (obj_ladder) {
	// Set Graphic Based on Adjacent Ladders and Solid Areas
	image_index = 0;
	var _spr_width = sprite_get_width(sprite_index), _spr_height = sprite_get_height(sprite_index);
	var _ladder_above = at_grid_position_exact(x, y-_spr_height, _spr_width, obj_static_area) || at_grid_position_exact(x, y-_spr_height, _spr_width, obj_ladder) 
	var _ladder_below = at_grid_position_exact(x, y+_spr_height, _spr_width, obj_static_area) || at_grid_position_exact(x, y+_spr_height, _spr_width, obj_ladder) 
	if (!_ladder_above && !_ladder_below) { image_index = 3; }
	else if (!_ladder_below) { image_index = 1; }
	else if (!_ladder_above) { image_index = 2; }
}
with (obj_key) {
	shine_periodically();
}
with (obj_door) {
	if (image_index <= 1) {
		shine_periodically();

		if (instance_number(obj_key) == 0) {
			create_particles(8 + irandom(8));
			particle_color = c_white;
			create_particles(8 + irandom(8), true, spr_sparkle);	
			particle_color = make_color_rgb(136, 112, 0);
			image_index = 2;
			play_sound(snd_door_open);
			play_sound(snd_explosion);
		}
	}
}

// Game Object End Step
with (obj_player) {
	if ((x + sprite_get_width(sprite_index) <= 0) || (x >= room_width) || (y >= room_height) || (y + sprite_get_height(sprite_index) <= 0)) { 
		ring_out_timer++;
	}
	else { ring_out_timer = 0; }

	if (ring_out_timer == 8) { play_sound(snd_player_offscreen); }
	else if (ring_out_timer == 40) { instance_destroy(); }
}

// Handle Transition Code
if (instance_number(obj_player) == 0 && transition_timer == 0) { transition_timer = 1; }
else if (transition_timer > 0) {
	transition_timer++;
	
	if (transition_timer == transition_delay) { play_sound(snd_fade_out); }
	else if (transition_timer == transition_duration + transition_hold + transition_delay) { 
		if (instance_number(obj_player) == 0) { reset_room(); }
		else { transition_room(room_next(room)); }
		play_sound(snd_fade_in);
	}
	else if (transition_timer >= (transition_duration * 2) + transition_hold + transition_delay) { transition_timer = 0; } //audio_play_sound(snd_bgm_w1, 100, true); } // TODO: Vary by level
}