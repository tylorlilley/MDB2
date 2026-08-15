// Repeat some things instead of using event_inherited()
grid_remove();
spawn_contents();

// Handle Creating Death Particles
var _inside_playable_area = (x + sprite_get_width(sprite_index) >= 0 && y + sprite_get_height(sprite_index) >= 0 && x < room_width && y < room_height);
if (_inside_playable_area) {
	create_particles(8 + irandom(8), PARTICLE_TYPES.DEBRIS, get_darker_palette(particle_palette));
	create_particles(8 + irandom(8), PARTICLE_TYPES.DEBRIS, get_darker_palette(get_darker_palette(particle_palette)));
	create_particles(1, PARTICLE_TYPES.CORPSE, original_palette, undefined, undefined, death_sprite, has_cape);
}

// Other Player Death Stuff
if (_inside_playable_area || !is_a(obj_robot)) { play_sound(destroyed_sound); }
stop_sound(fall_sound);
fall_sound = undefined;
if (can_be_controlled) {
	global.controller.start_screen_shake();
	if (!is_undefined(last_x) && !is_undefined(last_y)) {
		global.controller.x = last_x;
		global.controller.y = last_y;
	}
}
