// Inherit the parent event
event_inherited();

// Visual Drawing Variables
depth = KEY_DEPTH;
main_palette = PALETTES.YELLOW;
particle_palette = PALETTES.YELLOW;
particle_type = PARTICLE_TYPES.SPARKLE;
particles_min = 6;
particles_max = 12;
global.room_keys++;
reset_shine_timer();

// Sound Variables
destroyed_sound = snd_key;

// New Variables
sway_timer = -(irandom(60) + 60);
float_timer = irandom(FLOAT_OFFSET_PERIOD_FRAMES);
keys_to_draw = 1;

// New Functions
draw_key_stack = function() {
	static _draw_offsets = [[0], [2,-2], [2,0,-2], [3,1,-1,-3], [4,2,0,-2,-4]];
	
	// Sway Back and Forth
	set_shader_palette((shine_timer == 1) ? PALETTES.ALL_WHITE : main_palette);
	
	var _offsets_for_total_keys = _draw_offsets[max(0, keys_to_draw-1)], _float_offset = get_float_value(float_timer, 0.75, 4 * FLOAT_OFFSET_PERIOD_FRAMES);
	for (var _i = 0; _i < keys_to_draw; _i++) {
		var _offset = _offsets_for_total_keys[_i], _angle_offset = _i * 2;
		draw_sprite_swaying(sprite_index, image_index, sway_timer, x + _offset, y + _offset + _float_offset, image_blend, image_alpha, 15, _angle_offset);
	}
}