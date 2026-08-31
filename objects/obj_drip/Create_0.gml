// Inherit the parent event
event_inherited();

state = 0;
creator = noone;
main_palette = PALETTES.BLUE_LIGHT;

image_alpha = 0.85;
sprite_index = spr_particle_drip_forming;
image_xscale = (irandom(1) == 0) ? -1 : 1;
depth = PARTICLE_DEPTH + 1;

set_engine_speeds(0, 0, 0, 0, 0.125/2);