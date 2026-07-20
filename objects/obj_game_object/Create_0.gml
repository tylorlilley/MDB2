enum STATES {
	STILL,
	FALLING,
	PUSHED,
	SURFACE,
	FLOAT
}

creator = noone;
main_palette = PALETTES.GRAY;
particle_palette = noone;
image_blend = c_white;

has_gravity = false;

is_left = false;

is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;

is_climbable = false;
is_pushable = false;
is_fragile = false;
is_connected = false;
is_player_lethal = false;
is_robot_lethal = false;

hits = 1;
image_speed = 0;
destroyed_sound = snd_explosion;
damaged_sound = snd_solid_crack;
shine_timer = 60 + irandom(8);

scr_game_object_functions();
grid_add();