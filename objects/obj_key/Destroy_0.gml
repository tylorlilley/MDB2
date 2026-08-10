if (instance_exists(creator)) { creator.part_destroyed(id); }
grid_remove();
create_particles(irandom(2)+4, PARTICLE_TYPES.SPARKLE, PALETTES.YELLOW);
play_sound(destroyed_sound);
//global.room_keys--;
global.keys_collected++;