if (instance_exists(creator)) { creator.part_destroyed(id); }
grid_remove();
create_particles(irandom(6)+6, PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW_LIGHT);
play_sound(destroyed_sound);
global.room_keys--;