// Inherit the parent event
event_inherited();

// Gameplay Variables
hits = 0;
is_climbable = false;
is_connected = true;
is_player_lethal = true;
is_powered_player_lethal = true;
is_robot_lethal = true;

// Sprite Variables
main_palette = PALETTES.RED;
main_sprite = spr_lava_old_1;
outline_sprite = spr_lava_outline;
outline_mask_sprite = spr_lava_outline_mask;
fuzzing_sprite = undefined;
	
// Visual Drawing Variables
animated = true;
has_square_shape = false;
has_darker_particles = true;
particle_frequency = 8;
connection_object_index = obj_static_area;
	
// Sound Variables
step_sound = snd_step_lava;
damaged_sound = snd_step_lava;
destroyed_sound = snd_explosion;

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
