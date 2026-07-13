// Inherit the parent event
event_inherited();

is_left = false;
can_power_up = false;
can_push_objects = false;
can_be_controlled = false;
can_be_crushed = false;

has_cape = false;
walk_timer = 0;
death_sprite = spr_robot_dying_particle;
death_particle_color1 = make_colour_rgb(123, 123, 123);
death_particle_color2 = make_colour_rgb(189, 189, 189);

update_controls = function() {
	walk_timer++;
	walk_timer = walk_timer % 8;
	
	if (walk_timer == 0 && state != PLAYER_STATES.FALL) {
		var _blocked_on_right = is_blocked_on_right(), _blocked_on_left = is_blocked_on_left();

		if (_blocked_on_right && _blocked_on_left) { }
		else if (is_left) {
			if (_blocked_on_left) { key_right = true; } 
			else { key_left = true; }
		}
		else {
			if (_blocked_on_right) { key_left = true; } 
			else { key_right = true; }
		}
	}
}


parent_update_player_graphics = update_player_graphics;
update_player_graphics = function() {
	parent_update_player_graphics();
	var _image_index = image_index;
	switch (sprite_index) {
		case spr_player_walk:
		case spr_player_idle: { sprite_index = spr_robot_walk; break; }
		case spr_player_fall: { sprite_index = spr_robot_fall; break; }
		case spr_player_turn: { sprite_index = spr_robot_turn; break; }
	}
	image_index = (state == PLAYER_STATES.STAND) ? 0 : _image_index;
}