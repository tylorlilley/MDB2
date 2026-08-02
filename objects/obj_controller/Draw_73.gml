shader_reset();

var _winning_player_x = noone;
with (obj_player) { if (state == PLAYER_STATES.WIN) { _winning_player_x = x; } }
if (_winning_player_x != noone) {
	// Create Spotlight Graphics
	if (!surface_exists(transition_surface)) { transition_surface = surface_create(room_width, room_height); }
	surface_set_target(transition_surface);
	draw_set_color(c_black);
	draw_rectangle(0, 0, room_width, room_height, false);
	gpu_set_blendequation(bm_eq_subtract);
	draw_sprite_ext(spr_spotlight_mask, 0, _winning_player_x-8, 0, 1, 1, 0, c_white, 1);
	gpu_set_blendequation(bm_eq_add);
	surface_reset_target();
		
	// Draw Spotlight
	draw_surface_ext(transition_surface, 0, 0, 1, 1, 0, c_white, 0.65);
}