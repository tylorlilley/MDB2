event_inherited();

create_particles(irandom(6)+2);
var _destroyed_sound = (is_fragile) ? snd_pop : snd_explosion;
play_sound(_destroyed_sound);