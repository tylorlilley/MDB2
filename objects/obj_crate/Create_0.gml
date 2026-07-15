event_inherited();

depth = 2;
sprite_index = spr_crate;
main_palette = global.PALETTE_BROWN;

is_pushable = true;
shine_timer = 60 + irandom(8);

step_sound = snd_step_wood;

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