event_inherited();

// Gameplay Variables
hits = 1;
is_pushable = true;

// Visual Drawing Variables
depth = CRATE_DEPTH;
sprite_index = spr_crate;
main_palette = PALETTES.BROWN;
particle_palette = PALETTES.BROWN_DARK;
particle_frequency = 1;
	
// Sound Variables
step_sound = snd_step_wood;
damaged_sound = snd_solid_crack;
destroyed_sound = snd_explosion;

// Overidden Functions
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