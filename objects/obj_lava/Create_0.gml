// Inherit the parent event
event_inherited();

// Game Object Overrides
hits = 0;
is_climbable = false;
is_connected = true;
is_player_lethal = true;
is_powered_player_lethal = true;
is_robot_lethal = true;

step_sound = snd_step_lava;
damaged_sound = snd_step_lava;

// Visual Object Overrides
depth = STATIC_AREA_DEPTH+1;
animated = true;
main_palette = PALETTES.RED;
main_sprite = spr_lava_old_1;
outline_sprite = spr_lava_outline;
outline_mask_sprite = spr_lava_outline_mask;
particle_frequency = 8;
has_darker_particles = true;
connection_object_index = obj_static_area;

// New Variables
anim_timer = 0;
bubble_timer = irandom(256*4) + 32;

// Overriden Functions
parent_deal_damage = deal_damage;
deal_damage = function() { 
	parent_deal_damage();
	play_sound(snd_step_lava);
	create_particles(4);
}

connected_to = function(_inst) { return _inst.object_index == object_index || (_inst.is_solid_from_all_sides() && _inst.y >= y); }
