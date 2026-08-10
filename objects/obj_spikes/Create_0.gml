event_inherited();

step_sound = snd_step_metal;
image_speed = 0;

is_player_lethal = true;
is_powered_player_lethal = true;
is_climbable = true;
has_gravity = false;

hits = 0;
original_palette = PALETTES.GRAY_LIGHT;
main_palette = PALETTES.GRAY_LIGHT;

particle_frequency = 0;
shine_timer = 0;

parent_deal_damage = deal_damage;

deal_damage = function() { 
	shine_timer = 2;
	y_transition_timer = 4;
	virtual_y -= 2;
	parent_deal_damage();
}

game_object_step = function() { }