// Inherit the parent event
event_inherited();

state = 0;
creator = noone;
main_palette = PALETTES.BLUE_LIGHT;
looped = false;
image_alpha = 0.66;
image_speed = 0.125/3;
sprite_index = spr_particle_drip_forming;
image_xscale = (irandom(1) == 0) ? -1 : 1;
depth = PARTICLE_DEPTH + 1;