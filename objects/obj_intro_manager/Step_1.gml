event_inherited();
audio_stop_sound(bgm_transition)
if (transition_timer == 24 && room == rm_intro_eih) { instance_create(-24, room_height/2, obj_eih); }
if (transition_timer == 40 && room == rm_intro) { instance_create(room_width/2 - 8, -16, obj_player); }

with (obj_static_area) { should_draw = false; particle_palette = PALETTES.ALL_WHITE; }
with (obj_door) { visible = false; }
with (obj_player) { key_right = false; }

if (instance_number(obj_sand) == 0 && !made_particles) {
	made_particles = true;
	var _intro_string_length =  114; //string_width(intro_string)
	for (var _y_pos = 128; _y_pos <= 136; _y_pos += 8) {
		for (var _x_pos = room_width/2 - _intro_string_length/2;_x_pos < room_width/2 + _intro_string_length/2; _x_pos += 8) {
			create_particles(irandom(4), PARTICLE_TYPES.DEBRIS, PALETTES.ALL_WHITE, _x_pos, _y_pos);
		}
	}
}