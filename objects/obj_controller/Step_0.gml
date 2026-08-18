// Read Controls for Player on All Frames
with (obj_player) {
	// Check Controls
	var _transition_manager_exists = false;
	with (obj_cutscene_manager) { _transition_manager_exists = true; }
	if (!_transition_manager_exists) {
		update_controls(object_index == obj_mirror_player);
		if (global.combine_up_and_jump_controls) { key_jump = key_up; }
		if (global.original_controls) { key_jump = false; }
	}
}

if (!is_logic_frame()) { exit; }

// Set up Switch Blocks for this Frame
with (obj_switch_block_outline) {
	// Refresh Flashing Switch Blocks
	if (solid_obj.main_palette != main_palette) {
		solid_obj.main_palette = main_palette;
		solid_obj.mark_manager_for_redraw();
	}
}
blocked_switch_colors = [[], [], []];
pressed_switch_colors = [[], [], []];

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

// Handle Static Object Step
with (obj_dynamic_object) {
	if (is_carrying_key()) {
		shine_timer++;
		if (shine_timer == 0) { reset_shine_timer(); }
	}
}
with (obj_water) {
	anim_timer++;
	anim_timer = anim_timer % (8 * 8);
}
with (obj_lava) {
	anim_timer++;
	anim_timer = anim_timer % (sprite_get_number(outline_sprite) * 8);
	if (anim_timer % 8 == 0) { mark_manager_for_redraw(); }
	
	if (bubble_timer > 0 && !connected_above) {
		bubble_timer--;
		if (bubble_timer == 0) {
			bubble_timer = irandom(256*6) + 256 + 128;
			if (!is_inside_solid()) {
				var _lava_bubble = create_particles(1, PARTICLE_TYPES.DEBRIS, PALETTES.RED_DARK);
				_lava_bubble.vspeed -= 1 / global.controller.fps_ratio;
				_lava_bubble.destroyed_y = _lava_bubble.y + sprite_get_height(_lava_bubble.sprite_index);
				_lava_bubble.creator = id;
			}
		}
	}
}
with (obj_eih) {
	walk_timer++;
	should_draw = true;
	if (x < room_width/2-8) {
		if (walk_timer == 6) { grid_move_to(x+8,y); walk_timer = 0; play_sound(snd_eih_step); image_index++; }
	}
	else if (walk_timer > 80 && instance_number(obj_player) == 0)  { instance_create(x, -16, obj_player); }
}

// Handle Switch Updates
with (obj_switch) {
	var _pressed_switches = other.pressed_switch_colors[switch_color], _blocked_switches = other.blocked_switch_colors[switch_color];
	var _pressed_switch = array_length(_pressed_switches) > 0, _blocked_switch = array_length(_blocked_switches) > 0;

	if (_pressed_switch) {
		if (_blocked_switch) {
			// Set all switches of the pressed color to the middle, blocked state
			if (image_index != 1) { play_sound(snd_soft_thud); }
			image_index = 1;
		}
		else {
			// Toggle all switches of the pressed color
			pressed = !pressed;
			image_index = (pressed) ? 2 : 0;
			if (array_contains(_pressed_switches, id)) { play_sound(snd_switch); }
		}
	}
	else {
		// Release previously blocked switches to previous state
		if (image_index == 1) { play_sound(snd_soft_thud); }
		image_index = (pressed) ? 2 : 0;
	}
	if (!is_fully_on_ground()) { instance_destroy(); }
}
with (obj_switch_block_outline) { if (array_length(other.pressed_switch_colors[switch_color]) > 0 && array_length(other.blocked_switch_colors[switch_color]) == 0) { toggle_solid(true); } }
with (obj_switch_block_outline) { if (array_length(other.pressed_switch_colors[switch_color]) > 0 && array_length(other.blocked_switch_colors[switch_color]) == 0) { solid_obj.update_connections(); } }
with (obj_key) {
	// Update Timers
	shine_timer++;
	if (shine_timer == 0) { reset_shine_timer(); }
	sway_timer++;
	if (sway_timer > 32) { sway_timer = -(irandom(60) + 60); }
	float_timer = (float_timer + 1) % (4 * FLOAT_OFFSET_PERIOD_FRAMES);
	
	// Update Key Stack
	if (visible) {
		var _keys_at_position = []
		with (global.controller) { _keys_at_position = instances_at_grid_position_exact(other.x, other.y, sprite_get_width(other.sprite_index), sprite_get_height(other.sprite_index), obj_key, false); }
		keys_to_draw = min(5, array_length(_keys_at_position));

		if (keys_to_draw > 1) { visible = grid_array_first(_keys_at_position).id == id; }
	}
}
with (obj_door) {
	if (!is_fully_on_ground()) { instance_destroy(); }
	else if (image_index == 0) {
		shine_timer++;
		if (shine_timer == 0) { reset_shine_timer(); }
		
		if (global.room_keys == global.keys_collected) {
			create_particles(6 + irandom(6), PARTICLE_TYPES.DEBRIS, PALETTES.YELLOW_DARK);
			create_particles(6 + irandom(6), PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW);
			image_index = 1;
			play_sound(snd_door_unlock);
			global.controller.start_screen_shake();
		}
	}
}
with (obj_spawner) {
	timer--;
	if (timer <= 0) {
		if (instance_number(spawned_obj) > 32) { play_sound(snd_solid_invulnerable); }
		else {
			var _inst = instance_create(x, y, spawned_obj);
			_inst.is_left = is_left;
		}
	    timer = frequency;
	}
}
with (obj_reforming_cloud_outline) {
	if (reform_timer > 0) {
		image_alpha = (240-reform_timer) / 240;
		reform_timer--;
		if (reform_timer == 0) { reform_cloud(); }
		mark_manager_for_redraw();
	}

}
frame_timer++;
frame_timer = frame_timer % 24;
float_timer++;
float_timer = float_timer % (4 * FLOAT_OFFSET_PERIOD_FRAMES);
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
	main_palette = (activated) ? ((masked) ? masked_palette : original_palette) : PALETTES.GRAY;
	image_alpha = (activated) ? ((_is_overlapped) ? 1 : 0.8) : 0.5;
	
	// Animate Portal
	image_index = other.frame_timer / _portal_speed;
}

// Game Object End Step
with (obj_player) {
	if ((x + sprite_get_width(sprite_index) <= 0) || (x >= room_width) || (y >= room_height && is_fall_state()) || (!is_a(obj_robot) && y + sprite_get_height(sprite_index) <= 0 && is_fly_state())) {
		ring_out_timer++;
	}
	else { ring_out_timer = 0; }

	if (ring_out_timer == 8) { if (can_be_controlled) { play_sound(snd_player_offscreen); } }
	else if (ring_out_timer == 40) { instance_destroy(); }
}

with (obj_dynamic_object) { update_virtual_y_offset(); }

// Handle Transition Code
var _controllable_player_exists = false, _transition_manager_exists = false;
with (obj_player) { if (can_be_controlled) { _controllable_player_exists = true; } }
with (obj_cutscene_manager) { _controllable_player_exists = true; _transition_manager_exists = true; }

if (!_controllable_player_exists && transition_timer == 0) { transition_timer = 1; }
else if (transition_timer > 0) {
	if (transition_timer == 1 && quips_enabled) {
		randomize();
		latest_quip = (is_cutscene_room() || _controllable_player_exists) ? "" : get_quip_text();
	}
	
	transition_timer++;
	
	if (transition_timer == TRANSITION_DELAY) { play_sound(snd_fade_out); }
	else if (transition_timer == TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD) { 
		if (!_controllable_player_exists) { reset_room(); }
		else { transition_room(target_room); }
		play_sound(snd_fade_in);
	}
	else if (transition_timer >= (TRANSITION_DURATION * 2) + TRANSITION_HOLD + TRANSITION_DELAY) {
		transition_timer = 0;
		if (surface_exists(transition_surface)) { surface_free(transition_surface); }
		transition_surface = undefined;
	}
}

// Create Win Sparkles
var _winning_player_x = undefined, _door_open = true;
with (obj_door) { if (image_index >= 2) { _door_open = false; } }
if (instance_number(obj_cutscene_manager) == 0) {
	with (obj_player) { if (state == PLAYER_STATES.WIN) { _winning_player_x = x; } }
	if (!is_undefined(_winning_player_x) && _door_open && irandom(2) == 0) {
		create_particles(1, PARTICLE_TYPES.CONFETTI, PALETTES.GRAY_LIGHT, _winning_player_x+8, -2);
	}
}