if (instance_exists(creator)) { creator.part_destroyed(id); }
grid_remove();
create_particles(irandom(4)+2, PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW);
play_sound(destroyed_sound);
//global.room_keys--;
global.keys_collected++;