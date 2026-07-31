event_inherited();

step_sound = snd_step_metal;

is_connected = true;
is_player_lethal = true;

hits = 0;
original_palette = PALETTES.GRAY_LIGHT;
main_palette = PALETTES.GRAY_LIGHT;
main_sprite = spr_spikes_1;
outline_sprite = noone;
particle_frequency = 0;
shine_timer = 0;

parent_deal_damage = deal_damage;

deal_damage = function() { 
	shine_timer = 4;
	main_sprite = spr_spikes_shine;
	main_palette = PALETTES.ALL_WHITE;
	parent_deal_damage();
	play_sound(snd_player_idle_yell);
}