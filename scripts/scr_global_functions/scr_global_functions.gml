function instances_at_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true, _grid = global.controller.game_object_grid) {
	var _grid_width = abs(_w) div 8, _grid_height = abs(_h) div  8, _single_cell_query = (_grid_width == 1 && _grid_height == 1);
	var _returned_instances = [], _max_x = room_width div 8, _max_y = room_height div 8, _min_x = 0, _min_y = 0;
	if (_ignore_outside_border) {
		var _border_size = 1; //(global.original_controls) ? 2 : 1;
		_max_x -= _border_size;
		_max_y -= _border_size-1;
		_min_x += _border_size;
		_min_y += _border_size;
	}
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = (_x div 8) + _grid_x, _checked_y = (_y div 8) + _grid_y;

			if (_checked_x < _min_x || _checked_x >= _max_x || _checked_y < _min_y || _checked_y >= _max_y) {
                continue;
            }
			
			var _instances_at_grid_position = _grid[_checked_x][_checked_y];
			for (var _i = 0; _i < array_length(_instances_at_grid_position); _i++) {
				var _inst = _instances_at_grid_position[_i];
				if (instance_exists(_inst) && id != _inst && _inst.is_a(_object_index) && (_single_cell_query || !array_contains(_returned_instances, _inst))) {
					array_push(_returned_instances, _inst);
				}
			}
		}
	}
	return _returned_instances;
}

// Checks if a single instance is at every position - doesn't count as an overlap of two instances with the same object index, like two ladders.
function instances_at_grid_position_exact(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	var _initial_instances = instances_at_grid_position(_x, _y, 8, 8, _object_index, _ignore_outside_border);
	var _instances_at_grid_position = [];
	array_copy(_instances_at_grid_position, 0, _initial_instances, 0, array_length(_initial_instances));
	for (var _grid_x = 0; _grid_x < _w; _grid_x += 8) {
		for (var _grid_y = 0; _grid_y < _h; _grid_y += 8) {
			var _potential_instances = instances_at_grid_position(_x+_grid_x, _y+_grid_y, 8, 8, _object_index, _ignore_outside_border);
			for (var _i = array_length(_instances_at_grid_position) - 1; _i >= 0; _i--) {
				var _inst = _instances_at_grid_position[_i]
				if (!array_contains(_potential_instances, _inst)) { array_delete(_instances_at_grid_position, _i, 1); }
			}
		}
	}
	return _instances_at_grid_position
}

function is_instance_at_grid_position(_x, _y, _inst, _ignore_outside_border = true) {
	var _instances_at_position = instances_at_grid_position(_x, _y, GRID_SIZE, GRID_SIZE, _inst.object_index, _ignore_outside_border);
	for (var _i = 0; _i < array_length(_instances_at_position); _i++) {
		if (_inst == _instances_at_position[_i]) { return true; }
	}
	return false;
}

function at_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	return array_length(instances_at_grid_position(_x, _y, _w, _h, _object_index, _ignore_outside_border)) > 0;
}

function at_each_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	for (var _grid_x = 0; _grid_x < _w; _grid_x += 8) {
		for (var _grid_y = 0; _grid_y < _h; _grid_y += 8) {
			if (!at_grid_position(_x+_grid_x, _y+_grid_y, 8, 8, _object_index, _ignore_outside_border)) { return false; }
		}
	}
	return true;
}

function at_grid_position_exact(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	return array_length(instances_at_grid_position_exact(_x, _y, _w, _h, _object_index, _ignore_outside_border)) > 0;
}

function get_objects_at(_x_pos, _y_pos, _width, _height, _pred, _ignored_objects = [], _object_index = obj_game_object) {
	var _potential_objects = instances_at_grid_position(_x_pos, _y_pos, _width, _height, _object_index), _static_objects = [];

	for (var _i = 0; _i < array_length(_potential_objects); _i++)
	{
		var _inst = _potential_objects[_i];
		if (!array_contains(_ignored_objects, _inst) && _pred(_inst, _ignored_objects)) { array_push(_static_objects, _inst); }
	}
	
	return _static_objects;
}

// Misc
function grid_array_first(_array) {
	return (array_length(_array) > 0) ? _array[0] : noone;
}

function get_shake_value(_shake_magnitude) {
	return (irandom(1 + (_shake_magnitude div 2)) * ((irandom(1) == 0) ? -1 : 1));
}

function draw_sprite_silhoutte(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha) {
	gpu_set_fog(true, _silhoutte_color, 0, 0);
	draw_sprite_ext(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha);
	gpu_set_fog(false, _silhoutte_color, 0, 0);
}

function draw_sprite_swaying(_sprite_index, _image_index, _sway_value, _x, _y, _image_blend, _image_alpha, _max_angle, _angle_offset = 0) {
	var _sprite_x_center = sprite_get_width(_sprite_index) / 2, _sprite_y_center = sprite_get_height(_sprite_index) / 2;
	var _radius = point_distance(0, 0, _sprite_x_center, _sprite_y_center);
	var _angle = _max_angle * dsin(clamp(_sway_value + _angle_offset, 0, 24) * 15);
	var _direction = point_direction(0, 0, -_sprite_x_center, -_sprite_y_center) + _angle;
		
	draw_sprite_ext(_sprite_index, _image_index, _x + _sprite_x_center + lengthdir_x(_radius, _direction), _y + _sprite_y_center + lengthdir_y(_radius, _direction), 1, 1, _angle, _image_blend, _image_alpha);
}

function set_shader_palette(_palette_to_use = undefined) {
	_palette_to_use ??= main_palette;
	shader_set_uniform_f_array(global.u_replacement_colors, global.palette_uniform_values[_palette_to_use]);
}

 
function get_float_value(_timer, _amplitude, _period = FLOAT_OFFSET_PERIOD_FRAMES) {
	var _y_offset = _amplitude * sin(_timer*(2 * pi / _period));
	return _y_offset;
}

function always_true() { return true; }

function instance_create(_x, _y, _obj) {
	return instance_create_depth(_x, _y, 0, _obj);
}

function draw_sprite_with_center_rotation(_sprite_index, _image_index, _x, _y, _x_scale, _y_scale, _angle, _color, _alpha) {
	var _sprite_x_center = sprite_get_width(_sprite_index) / 2, _sprite_y_center = sprite_get_height(_sprite_index) / 2;
	var _radius = point_distance(0, 0, _sprite_x_center, _sprite_y_center);
	var _direction = point_direction(0, 0, -_sprite_x_center, -_sprite_y_center) + _angle;
		
	draw_sprite_ext(_sprite_index, _image_index, _x + _sprite_x_center + lengthdir_x(_radius, _direction), _y + _sprite_y_center + lengthdir_y(_radius, _direction), _x_scale, _y_scale, _angle, _color, _alpha);
}

function draw_text_outlined(_x, _y, _text, _color = C_WHITE, _sep = undefined, _w = undefined) {
	draw_set_color(C_BLACK);
	for (var _x_offset = -1; _x_offset < 2; _x_offset++) {
		for (var _y_offset = -1; _y_offset < 4; _y_offset++) {
			if (_x_offset == 0 && _y_offset == 0) { continue; }
			
			if (is_undefined(_sep) || is_undefined(_w)) { draw_text(_x + _x_offset, _y + _y_offset, _text); }
			else { draw_text_ext(_x + _x_offset, _y + _y_offset, _text, _sep, _w); }
		}
	}
	
	draw_set_color(_color);
	if (is_undefined(_sep) || is_undefined(_w)) { draw_text(_x, _y, _text); }
	else { draw_text_ext(_x, _y, _text, _sep, _w); }
	
}

// Partcile Effect Functions
enum PARTICLE_TYPES {
	DEBRIS,
	SPARKLE,
	CORPSE,
	LEAF,
	CONFETTI,
	PUFF,
	SPARK
}

function create_particles(_total_particles, _particle_type = undefined, _particle_palettes = undefined, _x_pos = undefined, _y_pos = undefined, _death_sprite = undefined, _has_cape = false) {
	if (_total_particles <= 0) { exit; }
	
	_x_pos ??= x+sprite_get_width(sprite_index)/2;
	_y_pos ??= y+sprite_get_height(sprite_index)/2;
	_particle_type ??= particle_type;
	_particle_palettes ??= particle_palette ?? get_darker_palette(main_palette);
	
	static _particle_type_sprites = [spr_particle_debris, spr_particle_sparkle, undefined, spr_particle_leaf, spr_particle_confetti, spr_particle_debris, spr_particle_debris];
	var _particle_sprite = _particle_type_sprites[_particle_type] ?? (_death_sprite ?? sprite_index);
	var  _horizontal_direction = (irandom(1) == 0) ? 1 : -1;
	for (var _i = 0; _i < _total_particles; _i++) {
		var _particle_palette = is_array(_particle_palettes) ? _particle_palettes[_i % array_length(_particle_palettes)] : _particle_palettes;
		
		var _particle = instance_create(_x_pos, _y_pos, obj_particle);
		with (_particle) {
			main_palette = _particle_palette;
			particle_type = _particle_type;
			sprite_index = _particle_sprite;
			depth = PARTICLE_DEPTH;
			image_angle = 15 * image_rotation;
			image_speed = 0;
			//image_alpha = other.image_alpha;
			
			// Randomize Physics Variables
			hspeed = (random(3) / 2) * _horizontal_direction;
			vspeed = (random(4) / -2) - 2;
			gravity = 0.45;
			terminal_velocity = 8;
			
			// Modify basics by type
			if (_particle_type == PARTICLE_TYPES.DEBRIS || _particle_type == PARTICLE_TYPES.SPARKLE) {
				// Randomize Visuals
				if (irandom((_particle_type == PARTICLE_TYPES.DEBRIS ? 3 : 1)) == 0) { image_index = 1; }
				image_angle = irandom(3) * 90;
				image_xscale = (irandom(1) == 0) ? -1 : 1;
				image_yscale = (irandom(1) == 0) ? -1 : 1;
				image_speed = (_particle_type == PARTICLE_TYPES.SPARKLE) ? 1 : 0;
				if (_particle_type == PARTICLE_TYPES.SPARKLE) {
					//image_alpha = 0.85;
					var _angle_per_particle = ((360 / _total_particles) * _i) + -20 + random(40), _velocity = 3.5// + random(1);
					var _x_speed = lengthdir_x(_velocity, _angle_per_particle), _y_speed = lengthdir_y(_velocity, _angle_per_particle);
					hspeed = _x_speed;
					vspeed = _y_speed; //- 0.125;
					gravity = 0.0;
					decay_trigger = 5;
				}
			}
			else if (_particle_type == PARTICLE_TYPES.LEAF) {
				if (irandom(1) == 0) { main_palette = get_darker_palette(main_palette); }
				//if (irandom(32) == 0) { main_palette = PALETTES.BROWN; }
				image_speed = 0.125;
				image_xscale = _horizontal_direction;
				
				vspeed += 0.25;
				hspeed += 0.25 * _horizontal_direction;
				gravity = 0.35;
				terminal_velocity = 4;
			}
			else if (_particle_type == PARTICLE_TYPES.CONFETTI) {
				switch (irandom(5)) {
					case 0: { main_palette = PALETTES.YELLOW; break; }
					case 1: { main_palette = PALETTES.GREEN; break; }
					case 2: { main_palette = PALETTES.PINK; break; }
					case 3: { main_palette = PALETTES.RED; break; }
					case 4: { main_palette = PALETTES.BLUE; break; }
					case 5: { main_palette = PALETTES.PURPLE; break; }
				}
				if (irandom(1) == 0) { main_palette = get_darker_palette(main_palette); }
				//if (irandom(32) == 0) { main_palette = PALETTES.BROWN; }
				image_speed = 0.125;
				image_xscale = _horizontal_direction;
				
				vspeed = 0;
				hspeed /= 3;
				gravity = 0.25;
				terminal_velocity = 2.5;
			}
			else if (_particle_type == PARTICLE_TYPES.CORPSE) {
				depth -= 1;
				image_speed = 1;
				image_rotation =  -_horizontal_direction;
				has_cape = _has_cape;
				
				hspeed += _horizontal_direction;
				hspeed /= 2;
				vspeed -= 1;
			}
			
			// Switch Direction for Next Particle Created
			_horizontal_direction *= -1;
			
			// Divide speeds by fps values to maintain parity
			var _fps_ratio = global.controller.fps_ratio;
			gravity /= sqr(_fps_ratio);
			hspeed /= _fps_ratio;
			vspeed = (vspeed / _fps_ratio) + (gravity * (_fps_ratio - 1) / 2);
			terminal_velocity /= _fps_ratio;
			image_speed /= _fps_ratio;
		}
		if (_total_particles == 1) { return _particle; }
	}
}

function get_maximum_screen_scale() {
	var _monitor_width = display_get_width(), _monitor_height = display_get_height(), _max_scale = 2;
	while (_monitor_width >= (SCREEN_WIDTH*_max_scale) && _monitor_height >= (SCREEN_HEIGHT*_max_scale)) {
		_max_scale++;
		if (_max_scale > 100) { break; }
	}
	return max(1, _max_scale-1);
}

function get_maximum_fps() {
	var _monitor_freq = display_get_frequency(), _fps = 30;
	
	if (_monitor_freq >= 120) { _fps = 120; }
	else if (_monitor_freq >= 60) { _fps = 60; }
	
	return _fps;
}

// Control Functions
function get_left_pressed() {
	return (keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(global.gamepad, gp_padl) || (gamepad_axis_value(global.gamepad, gp_axislh) < -0.5 && global.last_gamepad_h_axis_value >= -0.5));
}

function get_right_pressed() {
	return (keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(global.gamepad, gp_padr) || (gamepad_axis_value(global.gamepad, gp_axislh) > 0.5 && global.last_gamepad_h_axis_value <= 0.5));
}

function get_up_pressed() {
	return (keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(global.gamepad, gp_padu) || (gamepad_axis_value(global.gamepad, gp_axislv) < -0.5 && global.last_gamepad_v_axis_value >= -0.5));
}

function get_down_pressed() {
	return (keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(global.gamepad, gp_padd) || (gamepad_axis_value(global.gamepad, gp_axislv) > 0.5 && global.last_gamepad_v_axis_value <= 0.5));
}

function get_jump_pressed() {
	return (keyboard_check_pressed(ord("Z")) || gamepad_button_check_pressed(global.gamepad, gp_face1) || gamepad_button_check_pressed(global.gamepad, gp_face2) || gamepad_button_check_pressed(global.gamepad, gp_face3) || gamepad_button_check_pressed(global.gamepad, gp_face4));
}

function get_restart_pressed() {
	return (keyboard_check_pressed(ord("R")) || keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(global.gamepad, gp_start) || gamepad_button_check_pressed(global.gamepad, gp_select));
}

function get_left_held() {
	return (keyboard_check(vk_left) || gamepad_button_check(global.gamepad, gp_padl) || gamepad_axis_value(global.gamepad, gp_axislh) < -0.5);
}

function get_right_held() {
	return (keyboard_check(vk_right) || gamepad_button_check(global.gamepad, gp_padr) || gamepad_axis_value(global.gamepad, gp_axislh) > 0.5);
}

function get_up_held() {
	return (keyboard_check(vk_up) || gamepad_button_check(global.gamepad, gp_padu) || gamepad_axis_value(global.gamepad, gp_axislv) < -0.5);
}

function get_down_held() {
	return (keyboard_check(vk_down) || gamepad_button_check(global.gamepad, gp_padd) || gamepad_axis_value(global.gamepad, gp_axislv) > 0.5);
}

function get_jump_held() {
	return (keyboard_check(ord("Z")) || gamepad_button_check(global.gamepad, gp_face1) || gamepad_button_check(global.gamepad, gp_face2) || gamepad_button_check(global.gamepad, gp_face3) || gamepad_button_check(global.gamepad, gp_face4));
}

function get_restart_held() {
	return (keyboard_check(ord("R")) || keyboard_check(vk_enter) || gamepad_button_check(global.gamepad, gp_start) || gamepad_button_check(global.gamepad, gp_select));
}

function get_left_released() {
	return (keyboard_check_released(vk_left) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padl) || (gamepad_axis_value(global.gamepad, gp_axislh) >= -0.5 && global.last_gamepad_h_axis_value < -0.5))));
}

function get_right_released() {
	return (keyboard_check_released(vk_right) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padr) || (gamepad_axis_value(global.gamepad, gp_axislh) <= 0.5 && global.last_gamepad_h_axis_value > 0.5))));
}

function get_up_released() {
	return (keyboard_check_released(vk_up) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padu) || (gamepad_axis_value(global.gamepad, gp_axislv) >= -0.5 && global.last_gamepad_v_axis_value < -0.5))));
}

function get_down_released() {
	return (keyboard_check_released(vk_down) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_padd) || (gamepad_axis_value(global.gamepad, gp_axislv) <= 0.5 && global.last_gamepad_v_axis_value > 0.5))));
}

function get_jump_released() {
	return (keyboard_check_released(ord("Z")) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_face1) || gamepad_button_check_released(global.gamepad, gp_face2) || gamepad_button_check_released(global.gamepad, gp_face3) || gamepad_button_check_released(global.gamepad, gp_face4))));
}

function get_restart_released() {
	return (keyboard_check_released(ord("R")) || keyboard_check_released(vk_enter) || (global.gamepad != noone && (gamepad_button_check_released(global.gamepad, gp_start) || gamepad_button_check_released(global.gamepad, gp_select))));
}
