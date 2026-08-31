switch (state) {
	case 0: {
		if (!instance_exists(creator)) { instance_destroy(); }
		break;
	}
	case 1: {
		sprite_index = spr_particle_drip;
		gravity = 0.35;
		if (vspeed > 4) { vspeed = 4; }
		
		with (obj_game_object) {
			if (is_solid_from_above && instance_place(x, y, other)) {
				other.state = 2;
				other.vspeed = 0;
				other.gravity = 0;
				other.sprite_index = spr_particle_drip_forming;
				other.image_index = 0;
				other.image_yscale = -1;
				other.image_speed = -0.125;
				other.creator = id;
				other.y = y-4;
				break;
			}
		}
		
		break;
	}
	case 2: {
		if (!instance_exists(creator) || !instance_place(x, y+4, creator)) { instance_destroy(); }
	}
}