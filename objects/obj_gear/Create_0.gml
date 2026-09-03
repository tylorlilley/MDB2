event_inherited();

// Gameplay Variables
hits = 0;
has_gravity = false;

// Visual Drawing Variables
sprite_index = spr_gear;
set_depth(GEAR_DEPTH);
main_palette = PALETTES.GRAY_LIGHT;
particle_palette = PALETTES.GRAY_LIGHT;
particle_frequency = 0;
	
// Sound Variables
step_sound = snd_step_metal;
damaged_sound = snd_solid_invulnerable;
destroyed_sound = snd_explosion;

// New Variables
gear_dir = 0;
gear_timer = 0;

// Overriden Functions
parent_powerfall_on = powerfall_on;
parent_powerfly_into = powerfly_into;

treat_object_as_solid = function(_inst) { return !_inst.is_a(obj_player) && !_inst.is_a(obj_crate); }

powerfall_on = function(_other) {
	parent_powerfall_on(_other);
	start_gear_damaged(_other, 8);
}

powerfly_into = function(_other) {
	parent_powerfly_into(_other);
	start_gear_damaged(_other, -8);
}

start_gear_damaged = function(_other, _gear_timer) {
	shine_timer = 2;
	create_particles(4 + irandom(2), PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW, x+sprite_get_width(sprite_index)/2, y);
	start_gear_move(_gear_timer);
	if (instance_exists(_other)) {
		gear_dir = (_other.is_left) ? 1 : -1;
		if (_other.x < x) { gear_dir = -1; }
		if (_other.x > x) { gear_dir = 1; }
	}
}

game_object_step = function() {
	do_switch_collisions();
	if (gear_timer == 0) { image_angle = 0; state = PLAYER_STATES.STAND; return; }

	var _dir = sign(gear_timer);
	gear_timer -= _dir;
	image_angle += 22.5 * gear_dir;
	if (gear_timer % 4 == 0) { play_sound(snd_gear); }

	if (abs(gear_timer) == 4) {
		if (!start_gear_move(_dir * 4)) { gear_timer = 0; image_angle = 0; }
	}
}

// New Functions
start_gear_move = function(_gear_timer) {
	if (_gear_timer > 0) { if (!grid_move_down(2)) { return false; } }
	else { if (!grid_move_up(2)) { return false; } }
	gear_timer = _gear_timer;
	return true;
}
