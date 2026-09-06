event_inherited();

// Visual Object Overrides
main_palette = PALETTES.GRAY_LIGHT;

// Physics Variables
image_rotation = 0;
terminal_velocity = 8;
original_gravity = 0;
destroyed_y = room_height + sprite_get_height(sprite_index);
decay_timer = 0;
decay_trigger = 0;
has_cape = false;
particle_type = PARTICLE_TYPES.DEBRIS;

// Creator Variables
creator = noone;
creator_object_index = undefined;
destroyed_by_solids = false;
destroyed_by_creator = false;
has_left_solid = false;
original_y = y;

// Pause Variables
paused_hspeed = 0;
paused_vspeed = 0;
paused_gravity = 0;
paused_image_speed = 0;