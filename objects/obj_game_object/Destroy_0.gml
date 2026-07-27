if (instance_exists(creator)) { creator.part_destroyed(id); }
grid_remove();
create_particles(irandom(6)+2);
play_sound(destroyed_sound);