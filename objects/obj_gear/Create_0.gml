event_inherited();

sprite_index = spr_gear;
depth = CRATE_DEPTH;
main_palette = PALETTES.GRAY_LIGHT;
particle_palette = PALETTES.GRAY_LIGHT;

has_gravity = false;

step_sound = snd_step_metal;

hits = 0;
particle_frequency = 0;
transition_timer = 0;

parent_powerfall_on = powerfall_on;
parent_powerfly_into = powerfly_into;

powerfall_on = function() {
	parent_powerfall_on();
	if (grid_move_down(2)) { transition_timer = 16; play_sound(snd_solid_invulnerable); }
}

powerfly_into = function() {
	parent_powerfly_into();
	if (grid_move_up(2)) { transition_timer = -16; play_sound(snd_solid_invulnerable); }
}

game_object_step = function() {
	var _dir = sign(transition_timer) * -1;
	if (transition_timer != 0) {
		transition_timer += _dir;
		image_angle += 11.25 * _dir;
		if (transition_timer % 2 == 0) { play_sound(snd_gear); }
	}
	else { image_angle = 0; }
	
	if (abs(transition_timer) == 8) {
		if (_dir < 0) { if (!grid_move_up(2)) { transition_timer = 0; image_angle = 0; } }
		else { if (!grid_move_down(2)) { transition_timer = 0; image_angle = 0; } }
	}
}