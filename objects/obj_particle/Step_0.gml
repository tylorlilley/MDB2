if (y > room_height || (destroyed_by_object_index != undefined && (place_meeting(x, y, destroyed_by_object_index) && vspeed > 0))) { instance_destroy(); }
else {
	image_angle += image_rotation * (0.5) * abs(vspeed);

	if (vspeed > terminal_velocity) { vspeed = terminal_velocity; }
	if (sprite_index == spr_particle_leaf) {
		var _sway_speed = sign(hspeed) * 0.25;
		if (image_index == 0) { hspeed += _sway_speed * 2; vspeed += 0.5; }
		else if (image_index == 2) { hspeed -= _sway_speed * 2; vspeed -= 0.5; }
		else if (image_index == 1 || image_index == 3) { vspeed -= 0.25; }
	}
}