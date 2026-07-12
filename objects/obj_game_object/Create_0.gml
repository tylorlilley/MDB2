enum STATES {
	STILL,
	FALLING,
	PUSHED,
	SURFACE,
	FLOAT
}

has_gravity = false;

is_left = false;
is_up = false;

is_ground = false;
is_ceiling = false;
is_right_wall = false;
is_left_wall = false;

is_climbable = false;
is_pushable = false;
is_moving = false;
is_fragile = false;
is_connected = false;

hits = 1;
move_timer = 0;
transition_timer = 0;
particle_color = c_white;
fall_timer = 0;
swim_timer = 0;
image_speed = 0;
destroyed_sound = snd_explosion;

scr_game_object_functions();
grid_add();