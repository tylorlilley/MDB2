// Repeat some things instead of using event_inherited()
grid_remove();
spawn_contents();

var _inside_playable_area = (x + sprite_get_width(sprite_index) >= 0 && y + sprite_get_height(sprite_index) >= 0 && x < room_width && y < room_height);
if (_inside_playable_area) {
	// Create Death Particles
	create_particles(8 + irandom(8), PARTICLE_TYPES.DEBRIS, get_darker_palette(particle_palette));
	create_particles(8 + irandom(8), PARTICLE_TYPES.DEBRIS, get_darker_palette(get_darker_palette(particle_palette)));
	create_particles(1, PARTICLE_TYPES.CORPSE, original_palette, undefined, undefined, death_sprite, has_cape);
	has_afterimage = true;
	var _img = create_afterimage();
	if (instance_exists(_img)) {
		_img.sprite_index = afterimage_sprite;
		_img.image_index = 0;
		_img.main_palette = PALETTES.ALL_WHITE;
	}
}

// Other Player Death Stuff
if (_inside_playable_area || !is_a(obj_robot)) { play_sound(destroyed_sound); }
stop_sound(fall_sound);
fall_sound = undefined;
if (controlled_by_human) {
	global.controller.start_screen_shake();
	global.controller.x = clamp(virtual_x, GRID_SIZE, room_width - GRID_SIZE*2);
	global.controller.y = clamp(virtual_y, GRID_SIZE, room_height - GRID_SIZE*2);
}
