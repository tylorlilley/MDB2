// Inherit the parent event
event_inherited();
create_particles(6, PARTICLE_TYPES.DEBRIS, PALETTES.RED_DARK, x, y);
instance_create(x, y+8, obj_eih_dead);
