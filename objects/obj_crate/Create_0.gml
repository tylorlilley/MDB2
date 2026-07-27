event_inherited();

sprite_index = spr_crate;
depth = CRATE_DEPTH;
main_palette = PALETTES.BROWN;
particle_palette = PALETTES.BROWN_DARK;

is_pushable = true;
shine_timer = 60 + irandom(8);

step_sound = snd_step_wood;

parent_can_be_pushed_left = can_be_pushed_left;
parent_can_be_pushed_right = can_be_pushed_right;

can_be_pushed_left = function() {
	if (state != PLAYER_STATES.STAND) { return false; }

	return parent_can_be_pushed_left();
}

can_be_pushed_right = function() {
	if (state != PLAYER_STATES.STAND) { return false; }

	return parent_can_be_pushed_right();
}