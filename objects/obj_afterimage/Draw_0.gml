if (instance_exists(creator)) { virtual_y = creator.get_main_y() + 1; set_shader_palette(main_palette); }
else if (use_outline_draw) { set_shader_outline_palette(main_palette); }

// Coppied from Draw Dynamic Object
draw_sprite_with_center_rotation(sprite_index, image_index, virtual_x + get_x_draw_offset(), virtual_y + virtual_y_offset, get_left_value(), 1, image_angle, image_blend, image_alpha);