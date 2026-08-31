if (!global.controller.is_logic_frame()) { exit; }
if (y > destroyed_y) { instance_destroy(); exit; }

switch (state) {
	case 0: {
		if (!instance_exists(creator)) { destroy_with_particle(); }
		break;
	}
	case 1: {
		if (vspeed > terminal_velocity) { vspeed = terminal_velocity; }
		if (y > destroyed_y) { instance_destroy(); break; }
		
		var _floor = noone, _instances = instances_at_grid_position(x, y, GRID_SIZE, GRID_SIZE * 2, obj_game_object, false);
		for (var _i = 0; _i < array_length(_instances); _i++) {
			var _inst = _instances[_i];
			if (_inst.is_solid_from_above && instance_place(x, y + (vspeed * global.controller.fps_ratio), _inst)) { _floor = _inst; break; }
		}
		if (_floor == noone) { break; }
		
		if (!_floor.is_a(obj_static_area) || _floor.object_index == obj_lava) { destroy_with_particle(_floor.object_index == obj_lava); }
		else {
			state = 2;
			creator = _floor;
			sprite_index = spr_particle_drip_forming_1;
			image_index = 4;
			image_yscale = -1;
			y = _floor.y - 1;
			set_engine_speeds(0, 0, 0, 0, -1);
		}
		
		break;
	}
	case 2: {
		if (!instance_exists(creator) || !instance_place(x, y+1, creator)) { destroy_with_particle(); }
	}
}