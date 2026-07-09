event_inherited();

depth = 2;
is_pushable = true;

particle_color = make_color_rgb(136, 112, 0);
step_sound = snd_step_wood;
contents = instance_create_depth(-128, -128, 0, obj_key);
instance_deactivate_object(contents);

parent_can_be_pushed_left = can_be_pushed_left;
parent_can_be_pushed_right = can_be_pushed_right;

can_be_pushed_left = function() {
	if (state != STATES.STILL) { return false; }

	return parent_can_be_pushed_left();
}

can_be_pushed_right = function() {
	if (state != STATES.STILL) { return false; }

	return parent_can_be_pushed_right();
}