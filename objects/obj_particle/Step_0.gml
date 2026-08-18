image_angle += image_rotation * (0.5) * abs(vspeed);
if (!global.controller.is_logic_frame()) { exit; }

if (y > destroyed_y && (!instance_exists(creator) || place_meeting(x, y, creator.object_index))) { instance_destroy(); }
else {
	var _fps_ratio = global.controller.fps_ratio;

	if (vspeed > terminal_velocity) { vspeed = terminal_velocity; }
	if (sprite_index == spr_particle_leaf) {
		var _sway_speed = sign(hspeed) * 0.25;
		if (image_index == 0) { hspeed += (_sway_speed * 2) / _fps_ratio; vspeed += (0.5 / _fps_ratio); }
		else if (image_index == 2) { hspeed -= (_sway_speed * 2) / _fps_ratio; vspeed -= (0.5 / _fps_ratio); }
		else if (image_index == 1 || image_index == 3) { vspeed -= (0.25 / _fps_ratio); }
	}
	
	decay_timer++;
	if (decay_trigger > 0 && decay_timer >= decay_trigger) {
		image_alpha -= 1/decay_trigger;
		if (image_alpha <= 0) { instance_destroy(); }
	}
}