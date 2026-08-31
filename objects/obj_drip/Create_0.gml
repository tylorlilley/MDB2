// Inherit the parent event
event_inherited();

state = 0;
creator = noone;
main_palette = PALETTES.BLUE_LIGHT;

image_alpha = 0.75;
sprite_index = spr_particle_drip_forming_1;
image_xscale = (irandom(1) == 0) ? -1 : 1;
depth = PARTICLE_DEPTH + 1;

set_engine_speeds(0, 0, 0, 0, 0.125);

destroy_with_particle = function(_is_lava = false) {
	var _part = create_particles(1);
	if (_is_lava) { _part.main_palette = get_darker_palette(main_palette); }
	else { 
		_part.image_index = 0;
		_part.image_alpha = image_alpha;
		_part.sprite_index = spr_particle_debris_dark;
	}
	instance_destroy();
}