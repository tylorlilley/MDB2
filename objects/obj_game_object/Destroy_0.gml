create_particles(irandom(particles_max-particles_min)+particles_min);
play_sound(destroyed_sound);
if (instance_exists(creator)) { creator.part_destroyed(id); }
grid_remove();