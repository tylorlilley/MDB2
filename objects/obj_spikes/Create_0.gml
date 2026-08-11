event_inherited();

// Gameplay Variables
hits = 0;
has_gravity = false;
is_player_lethal = true;
is_powered_player_lethal = true;
is_climbable = true;

// Visual Drawing Variables
original_palette = PALETTES.GRAY_LIGHT;
main_palette = PALETTES.GRAY_LIGHT;
particle_frequency = 0;
shine_timer = 0;
	
// Sound Variables
step_sound = snd_step_metal;
damaged_sound = snd_solid_invulnerable;
destroyed_sound = snd_explosion;

// Function Overrides
parent_deal_damage = deal_damage;

deal_damage = function() { 
	shine_timer = 2;
	y_transition_timer = 4;
	virtual_y -= 4;
	parent_deal_damage();
}

game_object_step = function() { }