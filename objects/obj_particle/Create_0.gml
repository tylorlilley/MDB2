event_inherited();

// Visual Object Overrides
main_palette = PALETTES.GRAY_LIGHT;

// Physics Variables
image_rotation = 0;
terminal_velocity = 8;
original_gravity = 0;
destroyed_y = room_height + sprite_get_height(sprite_index);
creator = noone;
decay_timer = 0;
decay_trigger = 0;
has_cape = false;
particle_type = PARTICLE_TYPES.DEBRIS;

paused_hspeed = 0;
paused_vspeed = 0;
paused_gravity = 0;
paused_image_speed = 0;