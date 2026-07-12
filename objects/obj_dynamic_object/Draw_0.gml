event_inherited();

var _y_offset = get_float_offset();
var _drawn_x_scale = (is_left) ? -1 : 1;
var _x_offset = (_drawn_x_scale == -1) ? sprite_get_width(sprite_index) : 0;

draw_sprite_ext(sprite_index, image_index, virtual_x+_x_offset, virtual_y+_y_offset, _drawn_x_scale, 1, 0, image_blend, image_alpha);
 
 
 var _str = (state == STATES.FALLING) ? "FA" : "ST"
 if (state == STATES.FLOAT) { _str = "FL" }
 if (state == STATES.SURFACE) { _str = "SR" }
 draw_text(x, y, _str + ":" + string(fall_timer));
 