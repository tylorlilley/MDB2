event_inherited();

// Visual Object Overrides
main_palette = PALETTES.GRAY_LIGHT;

// Game Maker Variable Overrides
image_speed = 0.25;

// Physics Variables
image_rotation = 0;
terminal_velocity = 8;
destroyed_y = room_height + sprite_get_height(sprite_index);
creator = noone;
decay_timer = 0;
decay_trigger = 0;
has_cape = false;
particle_type = PARTICLE_TYPES.DEBRIS;