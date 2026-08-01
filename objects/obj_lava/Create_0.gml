// Inherit the parent event
event_inherited();
depth = STATIC_AREA_DEPTH+1;
animated = true;

anim_timer = 0;
main_palette = PALETTES.RED;

is_climbable = false;
is_connected = true;
is_player_lethal = true;
is_robot_lethal = true;

hits = 0;
step_sound = snd_step_metal;
damaged_sound = snd_solid_invulnerable;
main_palette = PALETTES.RED;
main_sprite = spr_lava_old_1;
outline_sprite = spr_lava_outline;
outline_mask_sprite = spr_lava_outline_mask;
particle_frequency = 8;

parent_deal_damage = deal_damage;

// Overriden Functions
deal_damage = function() { 
	parent_deal_damage();
	play_sound(snd_step_lava);
	play_sound(snd_player_idle_yell);
	create_particles(4);
}

get_connection_key = function() {
	return (object_index = obj_lava || is_solid_from_all_sides());
}
