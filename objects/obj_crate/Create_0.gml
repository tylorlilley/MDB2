event_inherited();
image_blend = c_orange;

is_fixed = false;
is_pushable = true;

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