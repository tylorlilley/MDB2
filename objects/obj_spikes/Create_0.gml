event_inherited();

step_sound = snd_step_metal;

is_connected = true;
is_player_lethal = true;
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_climbable = true;

hits = 0;
original_palette = PALETTES.GRAY_LIGHT;
main_palette = PALETTES.GRAY_LIGHT;

particle_frequency = 0;
shine_timer = 0;

parent_deal_damage = deal_damage;

deal_damage = function() { 
	shine_timer = 4;
	image_index = 1;
	parent_deal_damage();
	play_sound(snd_player_idle_yell);
}