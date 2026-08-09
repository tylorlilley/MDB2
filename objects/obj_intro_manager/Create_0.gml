event_inherited();

#macro INTRO_STRING "Tylor Lilley Presents"

// Override Parent Variables
depth = global.controller.depth - 1;
cutscene_timer_max = (room == rm_intro_eih) ? 360 : 80;

// Called by EIH as a Workaround
part_damaged = function(_inst) { } // Do Nothing

part_destroyed = function(_inst) {
	with (obj_particle) { instance_destroy(); }
	
	var _intro_string_length = string_width(INTRO_STRING)
	show_debug_message(_intro_string_length);
	for (var _y_pos = SCREEN_MIDDLE_Y; _y_pos <= SCREEN_MIDDLE_Y+8; _y_pos += 8) {
		for (var _x_pos = SCREEN_MIDDLE_X - _intro_string_length/2;_x_pos < SCREEN_MIDDLE_X + _intro_string_length/2; _x_pos += 8) {
			create_particles(irandom(2), PARTICLE_TYPES.DEBRIS, PALETTES.ALL_WHITE, _x_pos, _y_pos);
		}
	}
}

// New Variables
bgm = noone;
