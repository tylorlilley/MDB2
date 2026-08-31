if (!global.controller.is_logic_frame()) { exit; }

switch (state) {
	case 0: {
		if (!instance_exists(creator)) { instance_destroy(); }
		break;
	}
	case 1: {
		if (vspeed > terminal_velocity) { vspeed = terminal_velocity; }
		if (y > destroyed_y) { instance_destroy(); break; }
		
		var _floor = noone; _instances = instances_at_grid_position(x, y, GRID_SIZE, GRID_SIZE * 2, obj_game_object, false);
		for (var _i = 0; _i < array_length(_instances); _i++) {
			var _inst = _instances[_i];
			if (_inst.object_index == obj_lava) { instance_destroy(); exit; }
			if (_inst.is_solid_from_above) { _floor = _inst; break; }
		}
		if (_floor == noone) { break; }
		
		state = 2;
		creator = _floor;
		sprite_index = spr_particle_drip_forming;
		image_index = 5;
		image_yscale = -1;
		y = _floor.y - 1;
		set_engine_speeds(0, 0, 0, 0, -1.25);
		/*
		if (irandom(1) == 0) {
			var _part = create_particles(1);
			_part.image_index = 0;
			_part.image_alpha = image_alpha;
			_part.sprite_index = spr_particle_debris_dark;
		}
		*/
		
		break;
	}
	case 2: {
		if (!instance_exists(creator) || !instance_place(x, y+1, creator)) { instance_destroy(); }
	}
}