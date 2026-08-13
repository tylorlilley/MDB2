event_inherited();

#macro INTRO_STRING "Tylor Lilley Presents"

// Override Parent Variables
depth = global.controller.depth - 1;
cutscene_timer_max = (room == rm_intro_eih) ? 360 : 80;

// Called by EIH as a Workaround
part_damaged = function(_inst) { } // Do Nothing

part_destroyed = function(_inst) {
	with (obj_particle) { instance_destroy(); }
	
	var _room_x_middle = room_width/2, _room_y_middle = room_height/2, _intro_string_length = string_width(INTRO_STRING)
	for (var _y_pos = _room_y_middle; _y_pos <= _room_y_middle + 8; _y_pos += 8) {
		for (var _x_pos = _room_x_middle - _intro_string_length/2;_x_pos <= _room_x_middle +_intro_string_length/2; _x_pos += 8) {
			create_particles(irandom(2), PARTICLE_TYPES.DEBRIS, PALETTES.ALL_WHITE, _x_pos, _y_pos);
		}
	}
}
