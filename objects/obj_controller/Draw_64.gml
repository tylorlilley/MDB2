// Draw HUD
draw_set_valign(fa_top)
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(0, 0, 256, (global.original_controls ? 24 : 16), false);
if (global.original_controls) {
	draw_rectangle(0, 24, 8, 232, false);
	draw_rectangle(248, 24, 256, 232, false);
	//draw_rectangle(0, 232, 256, 240, false);
}
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(ft_teko);

// Draw Debug Mask Highlights
if (draw_game_object_grid) {
	for (var _grid_x = 0; _grid_x < array_length(game_object_grid); _grid_x++) {
		for (var _grid_y = 0; _grid_y < array_length(game_object_grid[0]); _grid_y++) {
			var _instances = game_object_grid[_grid_x][_grid_y];
			for (var _i = 0; _i < array_length(_instances); _i++) {
				var _inst = _instances[_i]
			
				with (_inst) {
					draw_sprite_ext(spr_box_16x16, 0, -8 + _grid_x * 8, -8 + _grid_y * 8, 0.5, 0.5, 1, c_teal, 0.5);
				}
			}
		}
	}
}

// Draw Level Text and Key Amounts
var _text_y_pos = -1 + (global.original_controls ? 4 : 0), _text_x_pos = 256-20;
if (global.original_controls) { _text_x_pos -= 8; }
if (global.room_keys >= 10) { _text_x_pos -= 8; }
draw_text(((global.original_controls) ? 12 : 4), _text_y_pos, room_title);
draw_text(_text_x_pos, _text_y_pos, "x" + string(global.room_keys));

main_palette = PALETTES.YELLOW;
shader_set(shd_palettizer);
set_shader_palette();
draw_sprite(spr_key_icon, 0, _text_x_pos-16, _text_y_pos+1);
shader_reset();

// Draw Transition
if (transition_timer > TRANSITION_DELAY) {
	// Determine Transition Parameters
	var _max_scale = room_width;
	var _fade_pos_x = is_undefined(global.last_player_x) ? room_width/2 : global.last_player_x;
	var _fade_pos_y = is_undefined(global.last_player_y) ? room_height/2 : global.last_player_y;
	if (_fade_pos_x < 0 || _fade_pos_x > room_width) { _fade_pos_x = room_width/2; }
	if (_fade_pos_y < 0 || _fade_pos_y > room_height) {	_fade_pos_y = room_height/2; }
		
	var _scale = 0;
	if (transition_timer < TRANSITION_DURATION + TRANSITION_DELAY) { _scale = power((1-((transition_timer - TRANSITION_DELAY) / TRANSITION_DURATION)), 4); }
	else if (transition_timer > TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD) { _scale = power(((transition_timer - TRANSITION_DURATION - TRANSITION_HOLD - TRANSITION_DELAY) / (TRANSITION_DURATION)), 4); }
		
	// Create Transition Graphics
	if (!surface_exists(transition_surface)) { transition_surface = surface_create(room_width, room_height); }
		
	surface_set_target(transition_surface);
	draw_set_color(c_black);
	draw_rectangle(0, 0, room_width, room_height, false);
	gpu_set_blendequation(bm_eq_subtract);
	draw_sprite_ext(spr_transition_mask, 0, _fade_pos_x, _fade_pos_y, _max_scale*_scale, _max_scale*_scale, 0, c_white, 1);
	gpu_set_blendequation(bm_eq_add);
	surface_reset_target();
		
	// Draw Transition
	draw_surface(transition_surface, 0, 0);
}